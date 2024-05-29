FROM	debian:bullseye

RUN		apt update && apt upgrade -y \
		&& apt install -y curl php php-fpm php-mysql mariadb-client

RUN		mkdir -p /run/php && \
		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp && \
		wp cli update

COPY	./conf/www.conf /etc/php/7.4/fpm/pool.d/

COPY 	--chmod=0755 /tools/config.sh /usr/local/bin

EXPOSE	9000

ENTRYPOINT [ "sh", "/usr/local/bin/config.sh" ]