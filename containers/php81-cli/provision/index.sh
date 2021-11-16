#!/bin/sh

cd `dirname $0`

provision-crontab.sh
provision-supervisord.sh

echo 'Configuration files have been placed. Restart the container. (eg) "docker restart CONTAINER_NAME".'