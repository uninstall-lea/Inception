-- Create table of name $SQL_DATABASE (an environemment variable from our .env file)
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};

-- Create user with passwords (i.e. from .env file)
CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';

-- Grant all privileges on the database to user
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'localhost';

-- Create root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';

-- Apply the new privileges
FLUSH PRIVILEGES;
