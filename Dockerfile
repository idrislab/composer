FROM php:7.1.0RC4-zts-alpine

MAINTAINER Luís Pitta Grós <luis.gros@olx.com>

RUN apk --update add \
	  git && \
	  apk del build-base && \
	  rm -rf /var/cache/apk/*

# Based on official docker image composer/composer
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer

RUN chmod +x /usr/local/bin/composer

WORKDIR /src

COPY docker_entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
