# Tools used in the demo

## cluster

This folder contains the dockerized environment.

```bash
# Create a three node Cassandra 3.11 cluster
./01-start.sh 

# Create a Cassandra cluster (3.1)
./01-start.sh

# Destroy cluster
./99-stop.sh

# Log in to node1
./node-shell.sh
```

| Tool | Description |
|------|-------------|
|cqlsh | CQL Shell. Command line interface to Cassandra. |
|nodetool| Admin Tool (Cluster management) |
