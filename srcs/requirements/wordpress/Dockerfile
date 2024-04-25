FROM	debian:bullseye

RUN		apt update && apt upgrade -y && apt install -y	\
			wget										\
			php7.3										\
			php-fpm										\
			php-mysql									\
			mariadb-client

# Create the /var/www directory, download WordPress 6.4.3 French version, extract it, and remove the tar file
RUN		mkdir -p /var/www/								\
		&& wget https://fr.wordpress.org/wordpress-6.4.3-fr_FR.tar.gz -P /var/www \
		&& cd /var/www && tar -xzf wordpress-6.4.3-fr_FR.tar.gz && rm wordpress-6.4.3-fr_FR.tar.gz

# Change the ownership and group of the /var/www/wordpress directory to root
RUN		chown -R root:root /var/www/wordpress

COPY	conf/www.conf /etc/php/7.3/fpm/pool.d

# Download wp-cli.phar, make it executable, and move it to /usr/local/bin/wp
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar							\
		&& mv wp-cli.phar /usr/local/bin/wp

COPY	conf/config.sh conf/

EXPOSE	9000

CMD		["sh", "conf/config.sh"]