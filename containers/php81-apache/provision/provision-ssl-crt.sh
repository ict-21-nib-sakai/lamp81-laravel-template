#!/bin/bash

PHP_APACHE_USER_NAME=app-user

# Prepare directories.
mkdir -p /etc/pki/tls/certs
mkdir -p /etc/pki/tls/private

# Put SSL conf, certificate and private key.
cp -f /tmp/conf/etc/apache2/sites-available/my-site-ssl.conf /etc/apache2/sites-available/my-site-ssl.conf
cp -f /tmp/conf/etc/pki/tls/certs/my-site.crt                /etc/pki/tls/certs/my-site.crt
cp -f /tmp/conf/etc/pki/tls/private/my-site.key              /etc/pki/tls/private/my-site.key

chown ${PHP_APACHE_USER_NAME}:${PHP_APACHE_USER_NAME} /etc/apache2/sites-available/my-site-ssl.conf
chmod 644                                             /etc/apache2/sites-available/my-site-ssl.conf
chown ${PHP_APACHE_USER_NAME}:${PHP_APACHE_USER_NAME} /etc/pki/tls/certs/my-site.crt
chmod 600                                             /etc/pki/tls/certs/my-site.crt
chown ${PHP_APACHE_USER_NAME}:${PHP_APACHE_USER_NAME} /etc/pki/tls/private/my-site.key
chmod 600                                             /etc/pki/tls/private/my-site.key

a2enmod ssl
a2ensite my-site-ssl

# Do NOT restart apache here. Because container startup will not start and will loop.
#/etc/init.d/apache2 force-reload