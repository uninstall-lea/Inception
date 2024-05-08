service mariadb start

# Create table of name $SQL_DATABASE (an environemment variable from our .env file)
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE}";

# Create user with passwords (i.e. from .env file)
mariadb -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}'";

# Grant all privileges on the database to user
mariadb -u root -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%'";

# Create root password
mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}'";

# Apply the new privileges
mariadb -u root -e "FLUSH PRIVILEGES";

mysqldump -u root -p$SQL_ROOT_PASSWORD $SQL_DATABASE > /usr/local/bin/dump.sql

service mariadb stop

