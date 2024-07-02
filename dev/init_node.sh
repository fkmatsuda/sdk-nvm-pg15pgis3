#!/bin/bash

set -e

. $NVM_DIR/nvm.sh
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION
nvm use default

mkdir -p /usr/local/node

ln -sfn $(dirname $(dirname "$(nvm which current)")) /usr/local/node/current
