#!/bin/bash

echo 'Default username and password are: admin/password'

ADMIN_USERNAME="admin"
ADMIN_PASSWORD="password"

echo 'Checking for environment variables for username and password'

if [ -z "$WILDFLY_ADMIN_USERNAME" -a -z "$WILDFLY_ADMIN_PASSWORD" ]; then
    echo >&2 'username and/or password are not set, using defaults'
else
    echo 'username and password set through environment variables'
    echo 'Setting username:'
    echo "$WILDFLY_ADMIN_USERNAME"
    echo 'Setting password:'
    echo "$WILDFLY_ADMIN_PASSWORD"
    ADMIN_USERNAME="$WILDFLY_ADMIN_USERNAME"
    ADMIN_PASSWORD="$WILDFLY_ADMIN_PASSWORD"
fi

/opt/jboss/wildfly/bin/add-user.sh $ADMIN_USERNAME $ADMIN_PASSWORD --silent

exec "$@"
