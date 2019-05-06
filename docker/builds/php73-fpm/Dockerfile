FROM php:7.3-fpm-alpine

RUN addgroup -g 3000 -S app
RUN adduser -u 3000 -S -D -G app app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk add --no-cache bash
RUN docker-php-ext-install pdo pdo_mysql
RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
  && pecl install xdebug \
  && pecl install redis \
  && docker-php-ext-enable xdebug \
  && docker-php-ext-enable redis \
  && apk del pcre-dev ${PHPIZE_DEPS}

# Prevent error in nginx error.log
RUN touch /var/log/xdebug_remote.log
RUN chmod 777 /var/log/xdebug_remote.log

COPY www.conf /etc/php-fpm.d/www.conf
COPY php.ini /etc/php.ini
COPY 15-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN chown app:app /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN chown app:app /etc/php-fpm.d/www.conf
RUN chown app:app /etc/php.ini
RUN touch /var/log/error.log
RUN touch /var/log/access.log
RUN chown app:app /var/log/error.log
RUN chown app:app /var/log/access.log

WORKDIR /app

