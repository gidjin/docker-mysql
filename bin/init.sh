#!/bin/bash
set -e

if [[ "$1" == mysqld* ]]; then
  /usr/local/bin/etcd_updater_service.rb start
fi

exec /entrypoint.sh "$@"
