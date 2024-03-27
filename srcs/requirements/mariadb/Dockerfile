FROM	debian:bullseye

# Update package list and install Mariadb
RUN		apt update							\
		&& apt upgrade -y					\
		&& apt install mariadb-server -y	\
		&& apt install mariadb-client -y	\
		&& apt install procps -y			\
		&& apt install gettext -y

# Copy configuration file from host in the container
COPY 	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy configuration script file and DB inside the container
COPY tools/init_script.sh tools/configDB.sql /etc/mysql/

# Set permissions for script file
RUN		chmod 777 /etc/mysql/init_script.sh

# Expose port 3306 to allow connection to MariaDB serv from outside the container
EXPOSE	3306

# Launch script file at startup
CMD		["sh", "/etc/mysql/init_script.sh"]