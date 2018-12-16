#!/bin/bash
set -e

user="mysql"
group="mysql"

if [ -n "${TOYBOX_GID}" ] && ! cat /etc/group | awk 'BEGIN{ FS= ":" }{ print $3 }' | grep ${TOYBOX_GID} > /dev/null 2>&1; then
    groupmod -g ${TOYBOX_GID} ${group}
    echo "GID of ${group} has been changed."
fi

if [ -n "${TOYBOX_UID}" ] && ! cat /etc/passwd | awk 'BEGIN{ FS= ":" }{ print $3 }' | grep ${TOYBOX_UID} > /dev/null 2>&1; then
    usermod -u ${TOYBOX_UID} ${user}
    echo "UID of ${user} has been changed."
fi

mariadb_conf='/etc/mysql/mariadb.cnf'
sed -i -e "s:^#default-character-set:default-character-set:" ${mariadb_conf}
sed -i -e "s:^#character-set-server:character-set-server:" ${mariadb_conf}
sed -i -e "s:^#collation-server:collation-server:" ${mariadb_conf}
sed -i -e "s:^#character_set_server:character_set_server:" ${mariadb_conf}
sed -i -e "s:^#collation_server:collation_server:" ${mariadb_conf}

exec /docker-entrypoint.sh mysqld --user=${user} --console
