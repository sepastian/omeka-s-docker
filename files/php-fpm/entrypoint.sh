#!/bin/sh

mariadb_password=$(cat ${MARIADB_PASSWORD_FILE})
cat <<EOF > /var/www/html/config/database.ini
user="$MARIADB_USER"
password="$mariadb_password"
dbname="$MARIADB_DATABASE"
host="$MARIADB_HOST"
EOF

# Enable logging by setting 'log' => true in /var/www/html/config/local.config.php.
# See https://omeka.org/s/docs/user-manual/errorLogging/#log-errors
sed -i \
    -e "s|'log' => false,|'log' => true,|" \
    /var/www/html/config/local.config.php

php-fpm
