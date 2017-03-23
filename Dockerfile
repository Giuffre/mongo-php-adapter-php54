FROM php:5.4-fpm

MAINTAINER 'agiuffredi@gmail.com'

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --filename=composer --install-dir=/usr/bin && \
    php -r "unlink('composer-setup.php');"

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