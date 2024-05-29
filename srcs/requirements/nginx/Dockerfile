FROM	debian:bullseye

# Update package list and install Nginx and OpenSSL
RUN		apt update && apt upgrade -y && \
		apt install -y vim nginx curl openssl

COPY	conf/nginx.conf /etc/nginx/sites-available/lbisson.42.fr.conf

RUN		openssl req -x509 -sha256 -nodes				\
		-days 365 										\
		-newkey rsa:4096 								\
		-keyout /etc/ssl/private/nginx-selfsigned.key	\
		-out /etc/ssl/certs/nginx-selfsigned.crt		\
		-subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=Inception/CN=lbisson.42.fr/"

RUN 	ln -s /etc/nginx/sites-available/lbisson.42.fr.conf /etc/nginx/sites-enabled/lbisson.42.fr.conf

EXPOSE	443

# Start nginx in foreground (deamon off means not in background)
CMD		[ "nginx", "-g", "daemon off;" ]