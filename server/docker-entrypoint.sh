#!/bin/bash
set -e

echo "$ONEC_USERNAME"
if [ "$1" = "ragent" ]; then
  exec gosu usr1cv8 /opt/1cv8/x86_64/8.3.20.1590/ragent
fi

exec "$@"
