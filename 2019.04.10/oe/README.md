# Óbudai Egyetem - Demo

This page contains the example code for the demo

```bash
# Create cluster
./01-start.sh

# Shell inside node1
./node1-shell.sh

# Cassandra cluster status
nodetool status

# CQL Shell
cqlsh
```

```sql
-- switch to keyspace
USE nobel;

-- Nobel laureates of 2002
SELECT * FROM laureates WHERE year = 2002;

-- Nobel laureates born in Hungary
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- Nobel laureates born in Hungary (force table scan - not recommended)
SELECT * FROM laureates WHERE borncountrycode = 'HU' ALLOW FILTERING;

-- Create index
CREATE INDEX ON laureates(borncountrycode);

-- Nobel laureates born in Hungary again!
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- quit to the container, then to local machine
```

```bash
# terminate one of the nodes
docker stop cluster_node3_1

# Shell inside node1
./node1-shell.sh

# Cassandra cluster status
nodetool status

# Check endpoints
nodetool getendpoints nobel laureates 2002

# CQL Shell
cqlsh
```

```sql
-- Verify any year
SELECT * FROM laureates WHERE year = 2002;

-- Verify index
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- Verify all
SELECT * FROM laureates;

-- Tunable consistency
CONSISTENCY QUORUM; -- or TWO

-- Verify a few years
SELECT * FROM laureates WHERE year = 2002;
```
