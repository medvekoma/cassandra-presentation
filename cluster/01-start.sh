#!/bin/bash

VERSION=${1-new}
docker-compose \
    -f docker-compose-${VERSION}.yml \
    up -d
