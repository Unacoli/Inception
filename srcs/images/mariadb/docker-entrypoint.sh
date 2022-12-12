#!/bin/sh

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
    echo "Database exists."
else
    mysql_install_db

    /etc/init.d/mysql start
    echo avant route
    echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root
    echo apres route
    echo avant nargouz
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root
    echo apres nargouz
    /etc/init.d/mysql stop
    echo staupe
fi

echo exek
exec "$@"