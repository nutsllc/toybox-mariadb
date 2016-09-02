#!/bin/bash

user="mysql"
group="mysql"

if [ -n "${TOYBOX_GID+x}" ] && ! cat /etc/group | grep ":${TOYBOX_GID}:" > /dev/null 2>&1; then
    groupmod -g ${TOYBOX_GID} ${group}
    echo "GID of ${group} has been changed."
fi

if [ -n "${TOYBOX_UID+x}" ] && ! cat /etc/passwd | grep ":${TOYBOX_UID}:" > /dev/null 2>&1; then
    usermod -u ${TOYBOX_UID} ${user}
    echo "UID of ${user} has been changed."
fi


exec /docker-entrypoint.sh mysqld --user=mysql --console
