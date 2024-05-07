FROM	debian:bullseye

# Update package list and install Nginx and OpenSSL
RUN		apt update && apt upgrade -y && apt install -y \
		vim \
		nginx \
		curl \
		openssl

		# Create the directory for storing the SSL certificate and private key
RUN		mkdir -p /etc/nginx/ssl \
		# Use OpenSSL to generate a new self-signed certificate request
			# '-x509' indicates we want to generate a self-signed certificate rather than a certificate request
			# '-nodes' (no DES) means the private key file will not be encrypted with a passphrase
		&& openssl req -x509 -nodes \
		# Specify where to store the generated certificate and private key
		-out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
		# Set the subject information for the certificate
		-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lea.42.fr/UID=lea"

RUN		mkdir -p /var/run/nginx

COPY	conf/nginx.conf /etc/nginx/nginx.conf

# Set permissions for HTML directory so everyone can read, write, execute.
# And change the ownership and group of '/var/www/html' and its contents to www-data:www-data (i.e., owner:group)
RUN		chmod 755 /var/www/html \
		&& chown -R www-data:www-data /var/www/html

EXPOSE	443

# Start nginx in foreground (deamon off means not in background)
CMD		[ "nginx", "-g", "daemon off;" ]