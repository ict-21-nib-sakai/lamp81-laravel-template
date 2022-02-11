#!/bin/sh

APP_PREFIX="my_app"
CURRENT_DIRECTORY=$(pwd)

cd "${CURRENT_DIRECTORY}"/../../containers || exit
docker exec --user root ${APP_PREFIX}-php81_apache-1 index.sh
docker-compose restart

cd "${CURRENT_DIRECTORY}" || exit