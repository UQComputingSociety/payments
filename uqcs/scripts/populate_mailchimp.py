from ..app import app
from ..base import Session, DB, mailchimp_queue
from ..workers import mailchimp_worker
from .. import models as m
import sqlalchemy as sa
from queue import Queue
import threading
import os


def main(args):
    logging.basicConfig(level=logging.DEBUG)
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get("SQLALCHEMY_DATABASE_URI")
    DB.init_app(app)

    with app.app_context():
        s = Session()
        members = s.query(m.Member)
        for mem in members:
            mailchimp_queue.put(mem)
        mailchimp_queue.put(None)
        mailchimp_worker(mailchimp_queue)


if __name__ == "__main__":
    main()