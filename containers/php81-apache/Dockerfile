FROM php:8.1.0RC6-apache

RUN apt-get update \
\
&& apt-get install -y --no-install-recommends \
  libxml2-dev \
\
&& docker-php-ext-install \
  bcmath \
  calendar \
  ctype \
  dba \
  dom \
  exif \
\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
\
&& a2enmod rewrite