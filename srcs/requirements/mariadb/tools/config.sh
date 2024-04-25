# Check if the environment variable has been set (i.e. empty)
if [ -z "$MARIADB_SETUP_COMPLETE" ]; then

	# This line uses 'envsubst' to replace environment variables in '/etc/mysql/configDB.sql' with their current values
    # The output is redirected to a new file '/etc/mysql/config_new.sql'
    < /etc/mysql/config.sql envsubst > /etc/mysql/config_new.sql

	# Change the permissions of the file to allow all users to read, write, and execute the file
	chmod 777 /etc/mysql/config_new.sql

	# Start the MySQL service
	service mysql start;

	# Execute the SQL commands in the file using the root user of MySQL
	mysql -u root < /etc/mysql/config_new.sql

	# Set the environment variable to indicate that the script has been executed
    export MARIADB_SETUP_COMPLETE=true
fi

# Start the MySQL server in safe mode
exec mysqld_safe
