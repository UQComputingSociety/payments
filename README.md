# UQCS Payments

The online membership form for the [UQ Computing Society](https://uqcs.org.au).


## Params

### Env Vars
 - `MAILCHIMP_USERNAME`
 - `MAILCHIMP_KEY`
 - `MAILCHIMP_LIST_ID`
 - `STRIPE_API_KEY`
 - `STRIPE_PUBLIC_KEY`
 - `STRIPE_PRICE_ID`
 - `MAILGUN_API_KEY`
 - `APP_SECRET_KEY`
 - `SQLALCHEMY_DATABASE_URI`

API keys can be found in these places:
 - [Mailchimp](https://admin.mailchimp.com/account/api/)
 - [Stripe](https://dashboard.stripe.com/apikeys) (test keys available)
 - [Mailgun](https://app.mailgun.com/app/account/security/api_keys)
 - `APP_SECRET_KEY` can be anything secret.

## Usage

### Database Setup
1. PostgreSQL is needed for the database backend, download from [here](https://www.postgresql.org/download/).
2. Open a psql shell.
3. Create a database for signups if it does not exist:

       CREATE DATABASE uqcs;

4. Load the UUID extension in this database:

       \connect uqcs
       CREATE EXTENSION "uuid-ossp";
       
NOTE: The database to be used is specified in an environment variable as an [SQLAlchemy database string](https://docs.sqlalchemy.org/13/core/engines.html#database-urls). This should be set before running, e.g.

       export SQLALCHEMY_DATABASE_URI=postgresql://postgres:password@localhost:5432/uqcs

### Signup Form
1. Windows machines will need the Microsoft Visual C++ Build Tools, which can be found [here](https://visualstudio.microsoft.com/vs/downloads/).

3. Using Python 3, run:

       python setup.py install --user

4. Run the signup form with

       python -m uqcs [host]

    where [host] is the IP to bind to. For example,

       python -m uqcs localhost

5. The form will be available at port 9090 of the given host.

### Useful Tasks
Generate a [bcrypt hash](https://bcrypt-generator.com/), then add it to the adminuser table with, for example:

    INSERT INTO adminuser VALUES ('admin', 'Admin', '$2y$12$uIcgKDdPYiiEaYKpWqYFXul1aOJrE3CUnbI/XfxgUhPQUu6u0a/ZC');

This adds an admin user with usernamen "admin" and password "test".

## Database Migration

Unfortunately, there's currently no robust process for migrating the database schema.

What you can do (very carefully!) is this:

1. **Backup the database**. This is a full backup and can be used to restore the database in case something goes wrong.

       sudo -u postgres pg_dump uqcs --column-inserts > backup.sql

2. Dump a copy of the data. This is almost the same as above but omits the schema definitions.

       sudo -u postgres pg_dump uqcs --column-inserts --data-only > data.sql

3. Make the schema changes in models.py.
   Make sure that the new schema is a *superset* of the old schema so data can be
   cleanly restored. If not, these steps will likely not work.

4. Run the signup form to create the tables.

5. Connect to a psql shell:

       sudo -u postgres psql -d uqcs

6. Drop the current tables and types
   (you'll need to uncomment the COMMIT line or type it manually):

       BEGIN;
       DROP TABLE member CASCADE;
       DROP TABLE student CASCADE;
       DROP TYPE gender;
       -- COMMIT;

7. Insert the previous data:

       sudo -u postgres psql -d uqcs -f data.sql
