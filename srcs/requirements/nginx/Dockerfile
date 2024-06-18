FROM debian:bullseye

RUN	apt update -y && \
	apt upgrade -y && \
	apt install -y openssl nginx && \
	mkdir /etc/nginx/certificates && \
	mkdir /var/www/wordpress && \
	openssl req \
		-x509 \
		-newkey rsa:2048 \
		-keyout /etc/nginx/certificates/lbisson-key.pem \
		-out /etc/nginx/certificates/lbisson.pem \
		-days 365 \
		-nodes \
		-subj '/C=FR/ST=IDF/L=Paris/O=42/OU=42Paris/CN=lbisson.42.fr/UID=lbisson'

EXPOSE 443

RUN rm /etc/nginx/sites-enabled/default
COPY conf/nginx.conf /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

ENTRYPOINT ["nginx", "-g", "daemon off;"]

