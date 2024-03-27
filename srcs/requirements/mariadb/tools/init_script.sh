#!/bin/bash

# Vérifie si la variable d'environnement a été définie
if [ -z "$MARIADB_SETUP_COMPLETE" ]; then

	# Exécute les commandes SQL
    < /etc/mysql/configDB.sql envsubst | mysql
	service mysql start;

    # Définit la variable d'environnement pour indiquer que le script a été exécuté
    export MARIADB_SETUP_COMPLETE=true
fi

# Démarre le serveur MySQL
exec mysqld_safe
