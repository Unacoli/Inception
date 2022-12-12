#!/bin/sh

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
    echo "Database exists."
else
    mysql_install_db

    /etc/init.d/mysql start
    echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root
    /etc/init.d/mysql stop
fi

exec "$@"