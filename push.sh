#!/bin/bash

set -e

VERSION="$1"

if [ "$VERSION" == '' ]; then
  echo "Specify version number."
  echo "Usage: ./push.sh VERSION"
  exit 1
fi

docker tag openssl-gost-local "yesnik/openssl-gost:$VERSION"
docker tag openssl-gost-local "yesnik/openssl-gost:latest"
docker push "yesnik/openssl-gost:$VERSION"
docker push "yesnik/openssl-gost:latest"

echo "Done."
