# MariaDB on Docker

A Dockerfile for deploying a MariaDB using Docker container.

This ``toybox-mariadb`` image has been extended [the official mariadb image](https://hub.docker.com/_/mariadb/) which is maintained in the [docker-library/mariadb](https://github.com/docker-library/mariadb/) GitHub repository.

This image is registered to the [Docker Hub](https://hub.docker.com/r/nutsllc/toybox-mariadb/) which is the official docker image registory.

## Feature

* gid/uid inside container correspond with outside container gid/uid by ``TOYBOX_GID`` or ``TOYBOX_UID`` environment valiable.

## Usage

### Start a MariaDB server instance

Starting a MariaDB instance is simple:

``docker run --name mariadb -e MYSQL_ROOT_PASSWORD=root -d nutsllc/mariadb``

### Connect to MariaDB from an application in another Docker container

Since MariaDB is intended as a drop-in replacement for MySQL, it can be used with many applications. This image exposes the standard MySQL port (3306), so container linking makes the MySQL instance available to other application containers. Start your application container like this in order to link it to the MySQL container:

``docker run --link mariadb -d application-image-name``

### Connect to MariaDB from the MySQL command line client

The following command goes into MariaDB container and runs the [MySQL Command-Line Tool](http://dev.mysql.com/doc/refman/5.7/en/mysql.html), allowing you to execute SQL statements:

``docker exec -it mariadb mysql -u root -proot``

### To correspond the gid/uid between inside and outside container

* To find a specific user's UID and GID, at the shell prompt, enter: ``id <username>``

``docker run --name mariadb -e TOYBOX_GID=1000 -e TOYBOX_UID=1000 -e MYSQL_ROOT_PASSWORD=root mariadb nutsllc/mariadb``

### Persistent the MariaDB data

``docker run --name mariadb -v $(pwd)/.mariadb_data/:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mariadb nutsllc/mariadb``

## Environment Variables

When you start the mariadb image, you can adjust the configuration of the MariaDB instance by passing one or more environment variables on the docker run command line. Do note that none of the variables below will have any effect if you start the container with a data directory that already contains a database: any pre-existing database will always be left untouched on container startup.

### MYSQL_ROOT_PASSWORD

This variable is mandatory and specifies the password that will be set for the MariaDB root superuser account. In the above example, it was set to my-secret-pw.

### MYSQL_DATABASE

This variable is optional and allows you to specify the name of a database to be created on image startup. If a user/password was supplied (see below) then that user will be granted superuser access (corresponding to GRANT ALL) to this database.

### MYSQL_USER, MYSQL_PASSWORD

These variables are optional, used in conjunction to create a new user and to set that user's password. This user will be granted superuser permissions (see above) for the database specified by the MYSQL_DATABASE variable. Both variables are required for a user to be created.

Do note that there is no need to use this mechanism to create the root superuser, that user gets created by default with the password specified by the MYSQL_ROOT_PASSWORD variable.

### MYSQL_ALLOW_EMPTY_PASSWORD

This is an optional variable. Set to yes to allow the container to be started with a blank password for the root user. NOTE: Setting this variable to yes is not recommended unless you really know what you are doing, since this will leave your MariaDB instance completely unprotected, allowing anyone to gain complete superuser access.

### MYSQL_RANDOM_ROOT_PASSWORD

This is an optional variable. Set to yes to generate a random initial password for the root user (using pwgen). The generated root password will be printed to stdout (GENERATED ROOT PASSWORD: .....).

### MYSQL_ONETIME_PASSWORD

Sets root (not the user specified in MYSQL_USER!) user as expired once init is complete, forcing a password change on first login. NOTE: This feature is supported on MySQL 5.6+ only. Using this option on MySQL 5.5 will throw an appropriate error during initialization.

## Contributing

We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/nutsllc/toybox-apache2/issues), or submit a [pull request](https://github.com/nutsllc/toybox-apache2/pulls) with your contribution.