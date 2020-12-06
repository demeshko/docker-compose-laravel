FROM php:7.4-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html

WORKDIR /var/www/html

ENV TIMEZONE Europe/Kiev

RUN apk add --update \
		libmcrypt-dev \
		php-pgsql \
	  && apk add --update --no-cache oniguruma-dev \
    && apk add --update tzdata \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
	  && docker-php-ext-install mbstring \
	  && docker-php-ext-install sockets pcntl \
	  && apk add --update icu-dev \
	  && docker-php-ext-install intl \
	  && apk add --update postgresql-dev \
	  && docker-php-ext-install pdo pdo_mysql 


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk --update --no-cache add autoconf g++ make && \
    pecl install -f xdebug && \
    docker-php-ext-enable xdebug && \
    apk del --purge autoconf g++ make