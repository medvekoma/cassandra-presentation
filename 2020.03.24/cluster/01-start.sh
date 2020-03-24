#!/bin/bash

SIZE=${1-small}
docker-compose \
    -f docker-compose-${SIZE}.yml \
    up -d
