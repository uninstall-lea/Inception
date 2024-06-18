#!/bin/sh

#stop the script if anything goes wrong
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

chown -R mysql:mysql /var/lib/mysql
#Update env with new values
envsubst < /scripts/init-db.sql | mariadbd --bootstrap

echo
echo 'MySQL init process done. Ready for start up.'
echo

echo "exec mariadbd"
exec mariadbd