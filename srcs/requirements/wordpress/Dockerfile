FROM	debian:bullseye

RUN		apt update && apt upgrade -y && apt install -y	\
			wget										\
			php7.4										\
			php-fpm										\
			php-mysql									\
			mariadb-client

COPY	tools/config.sh /usr/local/bin/
RUN		chmod +x /usr/local/bin/config.sh

ENTRYPOINT [ "sh", "/usr/local/bin/config.sh" ]