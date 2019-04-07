# Source code for Cassandra Presentation

This folder contains the infrastructure code and
examples for a Cassandra presentation.

The structure of the project is described below.

## Cluster

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

TBC