#!/bin/sh

CURRENT_DIRECTORY=`pwd`

# Install docker-compose.
cd ~/

# Note (The file naming conventions have changed since version 2.0.0.)
#  e.g. Linux → linux
sudo curl -L "https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-$(uname -s | sed 's/.\+/\L\0/')-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

cd $CURRENT_DIRECTORY