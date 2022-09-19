#!/bin/bash

set -e

VERSION="$1"

if [ "$VERSION" == '' ]; then
  echo "Specify version number."
  echo "Usage: ./push.sh VERSION"
  exit 1
fi

docker tag php-fpm-gost-local "yesnik/php-fpm-gost:$VERSION"
docker tag openssl-gost-local "yesnik/php-fpm-gost:latest"
docker push "yesnik/php-fpm-gost:$VERSION"
docker push "yesnik/php-fpm-gost:latest"

echo "Done."
