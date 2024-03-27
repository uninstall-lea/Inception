FROM	debian:bullseye

# Update package list and install Nginx and OpenSSL
RUN		apt update					\
		&& apt upgrade -y			\
		&& apt install wget	php-fpm php-mysql mariadb-client -y

RUN		mkdir -p /var/www/			\
		&& wget https://fr.wordpress.org/wordpress-6.4.3-fr_FR.tar.gz -P /var/www \
		&& cd /var/www && tar -xzf wordpress-6.4.3-fr_FR.tar.gz && rm wordpress-6.4.3-fr_FR.tar.gz

RUN		chown -R root:root /var/www/wordpress

COPY	conf/www.conf /etc/php/7.3/fpm/pool.d

RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar	\
		&& mv wp-cli.phar /usr/local/bin/wp

COPY	conf/auto_config.sh conf/

EXPOSE	9000

CMD		["sh", "conf/auto_config.sh"]