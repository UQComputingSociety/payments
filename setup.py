from setuptools import setup, find_packages
import sys

requires = [
    'premailer',
    'requests',
    'sqlalchemy',
    'stripe',
    'mako',
    'psycopg2',
    'waitress',
    'mailchimp3',
    'bcrypt',
    'tzlocal',
    'flask-sqlalchemy',
    'flask',
]

if sys.version_info < (3, 5):
    requires.append('typing')

setup(
    name='uqcs-signup',
    version='0.2.0',
    packages=find_packages(),
    install_requires=requires,
    url='https://join.uqcs.org.au',
    license='MIT',
    author='UQCS Committee',
    author_email='contact@uqcs.org.au',
    description='The UQCS payment systems for membership signup',
    include_package_data=True,
)
