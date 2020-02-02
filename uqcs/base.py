from sqlalchemy import orm
import queue
from functools import wraps
from flask_sqlalchemy import SQLAlchemy


mailer_queue = queue.Queue()
mailchimp_queue = queue.Queue()

DB = SQLAlchemy()
Session = DB.session
Session.expire_on_commit = False


def needs_db(fn):
    @wraps(fn)
    def decorated(*args, **kwargs):
        s = Session()
        s.expire_on_commit = False
        with s.begin_nested():
            result = fn(s, *args, **kwargs)
        s.commit()
        return result
    return decorated
