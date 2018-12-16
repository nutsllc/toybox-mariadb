FROM mariadb:10.4.0
MAINTAINER NutsProject, LLC <toybox@nutsllc.jp>

COPY toybox-mariadb.cnf /etc/mysql/conf.d/toybox-mariadb.cnf
COPY docker-entrypoint-ex.sh /entrypoint-ex.sh

ENTRYPOINT ["/entrypoint-ex.sh"]
