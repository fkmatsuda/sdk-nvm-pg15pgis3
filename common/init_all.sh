#!/bin/bash

set -e

./init_dev.sh

./init_db.sh

exec "$@"