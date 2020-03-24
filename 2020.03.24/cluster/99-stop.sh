#!/bin/bash

MODE=${1-small}
docker-compose \
    -f docker-compose-${MODE}.yml \
    down
