FROM php:5.4-fpm

MAINTAINER 'agiuffredi@gmail.com'

# Require composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chown www-data:www-data /home/composer

RUN apt-get update && apt-get install -y \
        clibcurl4-openssl-dev pkg-config libssl-dev libsslcommon2-dev \
        php-patchwork-utf8 \
        git \
        zip \
        php5-xdebug \
        mongodb-server

RUN docker-php-ext-install \
        mbstring && \
    pecl install \
        mongodb && \
    docker-php-ext-enable \
        mongodb \
        mbstring

RUN echo "date.timezone=\"Europe/Rome\"" > /usr/local/etc/php/conf.d/date.ini

WORKDIR /var/www/mongo-adapter

CMD ["php-fpm"]
