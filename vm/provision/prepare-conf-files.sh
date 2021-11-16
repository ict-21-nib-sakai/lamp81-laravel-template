#!/bin/sh

CURRENT_DIRECTORY=`pwd`

# Prepare a ".env" from ".env.example" for Docker Containers.
#  - PHP 8.1 CLI
#  - PHP 8.1 Apache
cd ${CURRENT_DIRECTORY}/../../containers
if [ ! -f ".env" ]; then cp .env.example .env ; fi

# Prepare mysql conf files.
#  - MySQL 8.0
cd ${CURRENT_DIRECTORY}/../../containers/mysql/conf/etc/mysql
if [ ! -f "my.cnf" ];            then cp my.development.cnf            my.cnf ; fi
if [ ! -f "conf.d/mysql.cnf" ];  then cp conf.d/mysql.development.cnf  conf.d/mysql.cnf  ; fi
if [ ! -f "conf.d/docker.cnf" ]; then cp conf.d/docker.development.cnf conf.d/docker.cnf ; fi

# Prepare a crontab file.
#  - PHP 8.1 CLI
cd ${CURRENT_DIRECTORY}/../../containers/php81-cli/conf/etc/crontabs
if [ ! -f "root" ]; then cp root.example root ; fi

cd $CURRENT_DIRECTORY