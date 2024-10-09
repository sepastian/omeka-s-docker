FROM php:8-fpm-alpine

ENV OMEKA_VERSION=4.1.1

WORKDIR /var/www/html
RUN apk add --update-cache --virtual build-dependencies \
    unzip \
    wget \
    && wget https://github.com/omeka/omeka-s/releases/download/v${OMEKA_VERSION}/omeka-s-${OMEKA_VERSION}.zip \
    && unzip omeka-s-${OMEKA_VERSION}.zip \
    && mv omeka-s/* . \
    && apk del build-dependencies

RUN apk add \
    freetype-dev \
    jpeg-dev \
    icu-dev \
    imagemagick-dev \
    imagemagick-jpeg \
    libpng-dev \
    libjpeg-turbo-dev \
    sed \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl pdo_mysql

# Remove config/database.ini, which is empty;
# instead, OMEKA_DB_CONNECTION_URL will be set during startup.
RUN rm config/database.ini

# Make sure /var/www/html/files is owned by www-data.
# Run as www-data.
RUN mkdir -p /var/www/html/files \
    && chown -R www-data:www-data /var/www/html
USER www-data
