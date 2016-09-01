#!/bin/bash

if [ -n "${TOYBOX_GID+x}" ]; then
    groupmod -g ${TOYBOX_GID} ${group}
fi

if [ -n "${TOYBOX_UID+x}" ]; then
    usermod -u ${TOYBOX_UID} ${user}
fi

exec /docker-entrypoint.sh mysqld --user=mysql --console
