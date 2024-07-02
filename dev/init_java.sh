#!/bin/bash

set -e

. $HOME/.sdkman/bin/sdkman-init.sh
sdk install java ${JAVA_VERSION}
sdk install maven ${MAVEN_VERSION}
