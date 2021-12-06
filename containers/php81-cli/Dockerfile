FROM php:8.1.0-cli-alpine3.15

COPY provision/*.sh /usr/local/bin/
COPY conf /tmp/conf

RUN /usr/local/bin/install-composer.sh \
&& apk update \
&& apk add --no-cache \
    curl-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    supervisor \
&& docker-php-ext-configure gd --enable-gd \
&& docker-php-ext-install \
  bcmath \
  bz2 \
  calendar \
  ctype \
  curl \
  dba \
&& rm -rf /var/cache/apk/*

COPY conf/etc/supervisord.default.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]