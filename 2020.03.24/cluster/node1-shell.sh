#!/bin/bash

COMMAND=${1-bash}

docker exec -it cluster_node1_1 ${COMMAND}
