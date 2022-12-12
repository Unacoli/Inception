#!/bin/sh

# Check if wp-config.php exists
if [ -f ./wp-config.php ]
then
	echo "Wordpress downloaded"
else
	# Download wordpress and all config file
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	# Import env variables in the config file
	cp wp-config-sample.php wp-config.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
	
	# Create users in WP
	wp --allow-root user create $WORDPRESS_ADMIN_USER $WORDPRESS_ADMIN_MAIL --user_pass=$WORDPRESS_ADMIN_PASS --role=administrator
	wp --allow-root user create $WORDPRESS_USER_USER $WORDPRESS_USER_MAIL --user_pass=$WORDPRESS_USER_PASS
fi

exec "$@"