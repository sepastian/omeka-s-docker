#!/bin/sh

mariadb_password=$(cat ${MARIADB_PASSWORD_FILE})
sed -i \
    -e "s|user.*|user=\"$MARIADB_USER\"|" \
    -e "s|password.*|password=\"$mariadb_password\"|" \
    -e "s|dbname.*|dbname=\"$MARIADB_DATABASE\"|" \
    -e "s|host.*|host=\"$MARIADB_HOST\"|" \
    /var/www/html/config/database.ini

cat /var/www/html/config/database.ini

php-fpm

