FROM php:7.4-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html

RUN set -ex \
  && apk --no-cache add \
    curl postgresql-dev jpeg-dev zlib-dev libpng-dev oniguruma-dev libxml2-dev

RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql json gd mbstring bcmath xml intl tokenizer