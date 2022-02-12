#!/bin/sh

CURRENT_DIRECTORY=$(pwd)

cd "${CURRENT_DIRECTORY}"/../../containers || exit
docker-compose restart

cd "${CURRENT_DIRECTORY}" || exit