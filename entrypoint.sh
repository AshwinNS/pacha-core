#!/bin/sh

if [ "$DATABASE" = "pgdb" ]
then
    echo "Waiting for pgdb..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

if [ "$ENVIRONMENT" = "PRODUCTION" ]
then
  crond -f &
  python manage.py crontab add
  python manage.py collectstatic
  python manage.py migrate
elif [ "$ENVIRONMENT" = "DEVELOPMENT" ]
then
  # deactivate cron service in devbox
  # in-case if you are activating cron in devbox
  # make sure all user email ids are changed to your email id
  # this way we can avoid spaming users

  # crond -f &

  python manage.py migrate
fi

exec "$@"
