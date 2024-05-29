if ! [ -d $WP_PATH ];
then
	echo "Download core wordpress files to /var/www/html/"
    wp core download --path=$WP_PATH --allow-root
fi

cd $WP_PATH;

if [ -f wp-config.php ] && wp config has DB_PASSWORD --allow-root;
then
	echo "wp-config.php is found"
else
	cp wp-config-sample.php wp-config.php

	# Configure WordPress
	wp config set --allow-root DB_HOST $MYSQL_HOST --path="."
    wp config set --allow-root DB_NAME $MYSQL_DATABASE --path="." 
    wp config set --allow-root DB_USER $MYSQL_USER --path="."
    wp config set --allow-root DB_PASSWORD "${MYSQL_USER_PASSWORD}" --path="." --quiet
    wp config set --allow-root table_prefix $MYSQL_TABLE_PREFIX --path="."
    wp config set --allow-root WP_DEBUG false --path="." --raw
    wp config set --allow-root WP_DEBUG_LOG false --path="." --raw

	wp config shuffle-salts --allow-root

    wp core install --allow-root \
        --path="." \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_LOGIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
    wp plugin update --path="." --allow-root --all

    # Create user
    wp user create --path=$WP_PATH --allow-root \
        $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD \
        --role=author --porcelain
fi

php-fpm7.4 -F
