FROM debian:bullseye

WORKDIR /var/www/wordpress/

RUN	apt update -y && \
	apt upgrade -y && \
    ##### Install PHP #####
	apt install -y wget gnupg2 lsb-release && \
    sleep 10 && \
    wget https://packages.sury.org/php/apt.gpg && \
    apt-key add apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list && \
    apt update -y && apt install -y php8.1 php8.1-fpm php8.1-mysql && \
    rm apt.gpg && \
	#####    END      #####
    apt install -y mariadb-client

RUN	wget --output-document=/usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp && \
    mkdir -p /var/www/wordpress && \
    chown www-data:www-data /var/www/wordpress

COPY conf/www.conf /etc/php/8.1/fpm/pool.d/www.conf
COPY tools/init-wp.sh /tools/init-wp.sh
RUN chmod -R 755 /tools

EXPOSE 9000

ENTRYPOINT ["/tools/init-wp.sh"]



