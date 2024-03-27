# Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};

# Create a user if he doesn't exist
CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';

# Grant all privileges to user for database
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'localhost';

# Modify password for user 'root'
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';

# Apply the new privileges
FLUSH PRIVILEGES;
