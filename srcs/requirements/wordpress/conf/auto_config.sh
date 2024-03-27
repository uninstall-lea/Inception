#!/bin/bash

sleep 10

if [ -z "$WP_SETUP_COMPLETE" ]; then

	wp config create	--allow-root										\
						--dbname=$SQL_DATABASE								\
						--dbuser=$SQL_USER									\
						--dbpass=$SQL_PASSWORD								\
						--dbhost=mariadb:3306 --path='/var/www/wordpress'	\
	&& wp core install	--title="lbisson.42.fr"								\
						--url="lbisson.42.fr"								\
						--path='/var/www/wordpress'							\
						--admin_user="lbisson"								\
						--admin_password=$WORDPRESS_ADMIN_PWD				\
						--admin_email="lbisson@student.42.fr"				\
						--skip-email										\
						--allow-root										\
	&& wp user create	author author@example.com							\
						--path='/var/www/wordpress'							\
						--role=author										\
						--user_pass=$WORDPRESS_USER_PWD						\
						--allow-root

    export WP_SETUP_COMPLETE=true
fi

if ! [ -d "/run/php" ]; then
	mkdir /run/php
fi

exec /usr/sbin/php-fpm7.3 --nodaemonize