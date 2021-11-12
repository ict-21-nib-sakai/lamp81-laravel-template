FROM php:8.1.0RC6-cli-alpine3.14

RUN apk update \
  && apk add --no-cache \
    bzip2-dev \
    curl-dev \
    gettext-dev \
    gmp-dev \
    icu-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
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
    dom \
    exif \
    fileinfo \
    gd \
    gettext \
    gmp \
    iconv \
    intl \
    mysqli \
    opcache \
    session \
    simplexml \
  && rm -rf /var/cache/apk/*

COPY conf/etc/supervisord.empty.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]