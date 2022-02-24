FROM php:8.1.3-cli-alpine3.15

COPY provision/*.sh /usr/local/bin/
COPY conf /tmp/conf

ARG PHP_CLI_USER_NAME
ARG PHP_CLI_USER_ID

RUN adduser -D ${PHP_CLI_USER_NAME} --uid ${PHP_CLI_USER_ID} --shell /sbin/nologin \
  && /usr/local/bin/install-composer.sh \
  && apk update \
  && apk add --no-cache \
    curl-dev \
    gettext-dev \
    gmp-dev \
    icu-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    sed \
    ssmtp \
    supervisor \
    sudo \
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
    -j$(nproc) gd \
    gettext \
    gmp \
    iconv \
    intl \
    mysqli \
    opcache \
    pdo \
    pdo_mysql \
    posix \
    session \
    simplexml \
    soap \
    sockets \
    xml \
    xmlwriter \
    zip \
  && cp /tmp/conf/etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf \
  && chown root:root /etc/ssmtp/ssmtp.conf \
  && chmod 644       /etc/ssmtp/ssmtp.conf \
  && rm -rf /var/cache/apk/*

COPY conf/etc/supervisord.default.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

# Allow sudo command.
RUN echo "${PHP_CLI_USER_NAME} ALL=NOPASSWD: /usr/local/bin/provision-crontab.sh"     | EDITOR='tee -a' visudo >/dev/null \
&&  echo "${PHP_CLI_USER_NAME} ALL=NOPASSWD: /usr/local/bin/provision-supervisord.sh" | EDITOR='tee -a' visudo >/dev/null

# Inject several command in "docker-php-entrypoint"
RUN /usr/local/bin/inject-command-in-entrypoint.sh

USER ${PHP_CLI_USER_NAME}
WORKDIR /var/www/code