#!/bin/sh

CURRENT_DIRECTORY=`pwd`

# Prepare a ".env" from ".env.example" for Docker Containers.
#  - PHP 8.1 CLI
#  - PHP 8.1 Apache
cd ${CURRENT_DIRECTORY}/../../containers
if [ ! -f ".env" ]; then cp .env.example .env ; fi

cd $CURRENT_DIRECTORY