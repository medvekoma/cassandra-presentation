#!/bin/bash

docker cp files/ cluster_node1_1:

docker exec -it cluster_node1_1 cqlsh -f setup-nobel.sql
