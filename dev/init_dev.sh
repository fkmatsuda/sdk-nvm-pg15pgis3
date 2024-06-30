#!/bin/bash

set -e

. $HOME/.sdkman/bin/sdkman-init.sh
. $NVM_DIR/nvm.sh
sdk install java ${JAVA_VERSION}
sdk install maven ${MAVEN_VERSION}
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION
nvm use default

