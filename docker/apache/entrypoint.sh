#!/bin/bash

set -e

echo "+++++++++++++++++++++++++++++++Adding proxy.db++++++++++++++++++++++++++++++++++"
touch /pvw/proxy.db
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

# Run whatever the user wants to
exec "$@"