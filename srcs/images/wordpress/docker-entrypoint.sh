#!/bin/sh

# Check if wp-config.php exists
if wp --allow-root core is-installed; then
	echo "Wordpress already configured."
else
	# Download wp, configure wp, and add admin user
	wp --allow-root core download --version=6.1.1
	wp --allow-root config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME
	wp --allow-root core install --url=$DOMAIN_NAME --title="Inception by nargouse" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_MAIL
	
	# Create demo user in WP
	wp --allow-root user create $WORDPRESS_USER_USER $WORDPRESS_USER_MAIL --user_pass=$WORDPRESS_USER_PASS
fi

exec "$@"