from mailchimp3 import MailChimp, mailchimpclient
import datetime as dt
import premailer
import requests
import requests.exceptions
import os
import logging
import hashlib
import functools
from queue import Queue

from uqcs.base import needs_db
from .templates import lookup
from typing import TYPE_CHECKING
if TYPE_CHECKING:
    from . import models as m


logger = logging.getLogger(__name__)


def mailchimp_worker(queue: Queue):
    list_id = os.environ.get('MAILCHIMP_LIST_ID')
    mailchimp_key = os.environ.get("MAILCHIMP_KEY")
    mailchimp_user = os.environ.get("MAILCHIMP_USERNAME")

    if not all((list_id, mailchimp_key, mailchimp_key)):
        logger.error(
            'msising mailchimp variables, newsletter list updating may fail.')

    client = MailChimp(mailchimp_key, mailchimp_user)

    for item in iter(queue.get, None):  # type: m.Member
        save_fn = None
        try:
            h = hashlib.md5()
            h.update(item.email.lower().encode('utf-8'))
            digest = h.hexdigest()
            client.lists.members.get(list_id, digest)
            save_fn = functools.partial(client.lists.members.update, list_id, digest)
        except (requests.exceptions.HTTPError, mailchimpclient.MailChimpError) as _:
            save_fn = functools.partial(client.lists.members.create, list_id)

        data = {
            'email_address': item.email,
            'status': 'subscribed',
            'merge_fields': {
                'FNAME': item.first_name,
                'LNAME': item.last_name,
                'MTYPE': 'Generic',
                'GENDER': item.gender or '',
            }
        }

        if item.paid is not None:
            data['merge_fields']['PAID'] = item.paid.strip()
        if item.member_type == "student":
            data['merge_fields']['MTYPE'] = 'Student'
            data['merge_fields']['SNUM'] = item.student_no
            if item.domestic is not None:
                data['merge_fields']['DOMESTIC'] = 'Domestic' if item.domestic else 'International'
            if item.year:
                data['merge_fields']['YEAR'] = item.year
            data['merge_fields']['PROGRAM'] = str(item.program)
            if item.undergrad is not None:
                data['merge_fields']['UNDERGRAD'] = 'Undergrad' if item.undergrad else 'Postgrad'
        try:
            save_fn(data)
        except Exception as e:
            logger.exception(e)


def _cents_to_str(cents):
    return str(cents // 100) + '.' + str(cents % 100).rjust(2, '0')


def mailer_worker(mailqueue):
    MAILGUN_KEY = os.environ.get("MAILGUN_API_KEY")

    if not MAILGUN_KEY:
        logger.warn('missing MAILGUN_API_KEY, receipt emails will not work.')

    for item in iter(mailqueue.get, None):
        try:
            if not item.has_paid():
                logger.warn('refusing to send receipt email to unpaid member: '
                    + item.email)
                continue

            # membership is $2.00
            cost = 200
            payment = {
                'cost': _cents_to_str(cost),
                'surcharge': '',
                'total': _cents_to_str(cost),
            }
            # CASH and UQU payments have no surcharges
            if item.paid not in ('CASH', 'UQU'):
                # if item.paid is not SQUARE, it was Stripe
                is_square = item.paid == 'SQUARE'
                # traditionally square and stripe had surcharges.
                # now there is none, courtesy of your friendly neighbourhood
                # ~~2021~~ 2022 committee
                surcharge = 0
                total = cost + surcharge
                payment['total'] = _cents_to_str(total)
                payment['surcharge'] = _cents_to_str(surcharge)
                payment['surcharge_text'] = ('Square' if is_square else 'Stripe') \
                    + ' Payment Fee'

            logger.info('sending receipt email to: ' + item.email
                + ', payment: ' + str(payment))

            time_paid = item.time_paid.strftime('%c')
            receipt_text = lookup.get_template("email.mtxt") \
                .render(user=item, time_paid=time_paid, payment=payment)
            receipt_html = lookup.get_template('email.mako') \
                .render(user=item, time_paid=time_paid, payment=payment)

            requests.post("https://api.mailgun.net/v3/uqcs.org.au/messages",
                          auth=('api', MAILGUN_KEY),
                          data={
                              'from': 'receipts@uqcs.org.au',
                              'to': item.email,
                              'bcc': "receipts@uqcs.org.au",
                              'text': receipt_text,
                              'html': premailer.transform(receipt_html),
                              'subject': "UQCS 2022 Membership Receipt",
                          })
        except Exception as exception:
            logger.exception(exception)
