# Source code for a Cassandra presentation

This folder contains the infrastructure code and
examples for a Cassandra presentation.

The structure of the project is described below.

## cluster

This folder contains the dockerized environment.

```bash
# Create a three node Cassandra 3.11 cluster
./01-start.sh 

# Create a three node legacy Cassandra cluster (2.1)
./01-start.sh old

# Destroy cluster
./99-stop.sh

# Setup the nobel dataset in the cluster (allow time for cluster startup)
./02-setup-nobel.sh

# Start a shell in the first node of the cluster
./node1-shell.sh
```

## CQL

Contains the CQL example files.

## client-app

Simple client application that connects to a local cluster.
Requirements:
 - A cassandra cluster available @ localhost
 - The nobel.laureates table
 - An index on borncountrycode

All the requirements are satisfied after executing
the queries from the CQL folder.
