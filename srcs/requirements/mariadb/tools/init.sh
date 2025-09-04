#!/bin/bash
set -e

echo "Initializing MariaDB..."

# Assure que le répertoire PID existe
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld

# Supprime un ancien PID si nécessaire
if [ -f /var/run/mysqld/mysqld.pid ]; then
    rm -f /var/run/mysqld/mysqld.pid
fi

# Démarre MariaDB en arrière-plan
mariadbd --user=mysql --skip-networking &
sleep 5

# Vérifie si la base existe
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo "Creating database and user..."
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
        CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PWD}';
        GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';
        FLUSH PRIVILEGES;
EOSQL
else
    echo "Database already exists, skipping initialization."
fi

# Stop le serveur après init
mysqladmin -u root shutdown

# Lancer le serveur principal
exec "$@"

