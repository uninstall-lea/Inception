FROM	debian:bullseye

# Update package list and install Nginx and OpenSSL
RUN		apt update					\
		&& apt upgrade -y			\
		&& apt install nginx -y		\
		&& apt install openssl -y

# Create SSL directory and directory for Nginx PID file
RUN		mkdir -p /etc/nginx/ssl		\
		&& openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lbisson.42.fr/UID=lbisson"	\
		&& mkdir -p /var/run/nginx

# Copy configuration file from host in the container
COPY	conf/nginx.conf /etc/nginx/nginx.conf

# Set permissions for HTML directory and set ownership
RUN		chmod 755 /var/www/html	\
		&& chown -R www-data:www-data /var/www/html

# Expose port 443 to allow connection to MariaDB serv from outside the container
EXPOSE	443

# Command to start Nginx in foreground
CMD		[ "nginx", "-g", "daemon off;" ]

# Dockerfile Summary:
# 1. Setting up a Debian Bullseye image.
	# - Choosing the base operating system for our Docker container.
# 2. Installing Nginx.
	# - Updating package lists and installing Nginx, a web server.
# 3. Setting up SSL.
	# - Installing OpenSSL to create SSL certificates for secure connections.
# 4. Configuring Nginx.
	# - Copying a custom Nginx configuration file to tailor server settings.
# 5. Managing File Permissions.
	# - Adjusting permissions to ensure Nginx can access website files.
# 6. Ensuring Correct Ownership.
	# - Assigning ownership of website files to Nginx user and group for proper access control.
# 7. Starting Nginx.
	# - Command to start Nginx service and keep the container running.
