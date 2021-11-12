FROM php:8.1.0RC6-cli-alpine3.14

RUN apk update \
  && apk add --no-cache \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    supervisor \
  && docker-php-ext-configure gd --enable-gd \
  && docker-php-ext-install \
    bcmath \
  && rm -rf /var/cache/apk/*

COPY conf/etc/supervisord.empty.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]