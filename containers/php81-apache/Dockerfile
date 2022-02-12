FROM php:8.1.2-apache

COPY provision/*.sh /usr/local/bin/
COPY conf /tmp/conf

ARG PHP_APACHE_USER_NAME
ARG PHP_APACHE_USER_ID

RUN adduser ${PHP_APACHE_USER_NAME} --disabled-password --uid ${PHP_APACHE_USER_ID} --gecos "" --shell /sbin/nologin \
&& apt-get update \
\
&& apt-get install -y --no-install-recommends \
  libcap2-bin \
  libfreetype6-dev \
  libgmp-dev \
  libicu-dev \
  libjpeg-dev \
  libmagickwand-dev \
  libonig-dev \
  libpng-dev \
  libxml2-dev \
  libzip-dev \
  ssmtp \
  sudo \
\
&& docker-php-ext-install \
  bcmath \
  calendar \
  ctype \
  dba \
  dom \
  exif \
  fileinfo \
  -j$(nproc) gd \
  gettext \
  gmp \
  iconv \
  intl \
  mbstring \
  mysqli \
  opcache \
  pdo \
  pdo_mysql \
  posix \
  session \
  simplexml \
  soap \
  xml \
  xmlwriter \
  zip \
\
&& docker-php-ext-configure gd \
  --with-freetype=/usr/include/ \
  --with-jpeg=/usr/include/ \
\
&& docker-php-ext-enable \
  gd \
  mysqli \
  pdo \
  pdo_mysql \
\
&& printf "\n" | pecl install imagick-3.6.0 \
\
&& echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/ssmtp.ini \
&& cp /tmp/conf/etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf \
&& chown root:mail /etc/ssmtp/ssmtp.conf \
&& chmod 640       /etc/ssmtp/ssmtp.conf \
\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
\
&& a2enmod rewrite
 
# Allow "/usr/sbin/apache2" command as non-root user.
RUN setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2

# Allow sudo command.
RUN echo "${PHP_APACHE_USER_NAME} ALL=NOPASSWD: /usr/local/bin/provision-php-ini.sh"      | EDITOR='tee -a' visudo >/dev/null \
&&  echo "${PHP_APACHE_USER_NAME} ALL=NOPASSWD: /usr/local/bin/provision-apache2-conf.sh" | EDITOR='tee -a' visudo >/dev/null

# Inject several command in "docker-php-entrypoint"
RUN /usr/local/bin/inject-command-in-entrypoint.sh

USER ${PHP_APACHE_USER_NAME}
WORKDIR /var/www/code