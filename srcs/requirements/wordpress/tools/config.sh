sleep 10

if [ -z "$WORDPRESS_SETUP_COMPLETE" ]; then

	wp config create	--allow-root										\
						--dbname=$SQL_DATABASE								\
						--dbuser=$SQL_USER									\
						--dbpass=$SQL_PASSWORD								\
						--dbhost=mariadb:3306								\
						--path='/var/www/wordpress'							\
						--skip-check

	wp core install		--url=$WORDPRESS_URL								\
						--title=$WORDPRESS_TITLE							\
						--path='/var/www/wordpress'							\
						--admin_user=$WORDPRESS_ADMIN_LOGIN					\
						--admin_password=$WORDPRESS_ADMIN_PASSWORD			\
						--admin_email=$WORDPRESS_ADMIN_EMAIL				\
						--skip-email										\
						--allow-root

	wp user create	author author@example.com								\
						--path='/var/www/wordpress'							\
						--role=author										\
						--user_pass=$WORDPRESS_USER_PASSWORD				\
						--allow-root

    export WORDPRESS_SETUP_COMPLETE=true
fi

if ! [ -d "/run/php" ]; then
	mkdir /run/php
fi

# This command executes the PHP FastCGI Process Manager (php-fpm7.3)
# '--nodaemonize' tells PHP-FPM to stay in the foreground so Docker can track the process properly
exec /usr/sbin/php-fpm7.3 --nodaemonize