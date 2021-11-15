FROM php:8.1.0RC6-apache

RUN apt-get update \
\
&& docker-php-ext-install \
  bcmath \
  calendar \
  ctype \
  dba \
\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
\
&& a2enmod rewrite