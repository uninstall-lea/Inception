FROM	debian:bullseye

# Update package list and install Mariadb
RUN		apt update && apt upgrade -y && apt install -y	\
			mariadb-server								\
			mariadb-client								\
			procps										\
			gettext

# Copy the MariaDB configuration file and .sql in the container
COPY 	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy and execute configuration script
COPY	tools/config.sh /usr/local/bin/
RUN		bash /usr/local/bin/config.sh

# Expose port 3306 to allow connection to MariaDB serv from outside the container
EXPOSE	3306

# Start the MySQL server in safe mode
CMD		[ "mysqld_safe" ]