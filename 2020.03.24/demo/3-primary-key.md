## Primary Key

* PRIMARY KEY is just a notation for PARTITION KEY & CLUSTERING KEY
* PARTITION KEY is mandatory
* CLUSTERING KEY is optional

### Nobel dataset

* CSV file: `cluster/files/nobel-laureates.csv`
* Create a table that is organized by `borncountrycode`
* Table structure: `cluster/files/setup-nobel.sql`
    * Note that we need to add `laureateid` for uniqueness
    * Partition key: `borncountrycode`
    * Clustering key: `laureateid`

```bash
./02-setup-nobel.sh
./node1-shell.sh cqlsh
```

### Query nobel dataset

```sql
USE nobel;

-- efficient, we query by partition key 
SELECT * FROM laureates WHERE borncountrycode = 'HU';
```

### Static column

* Stored once by partition key

```sql
-- add new static column
ALTER TABLE laureates ADD borncountry text static;

-- check table
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- update column (needs to write a single cell)
UPDATE laureates SET borncountry='Hungary' WHERE borncountrycode='HU';

-- Add new record
INSERT INTO laureates (borncountrycode , borncountry, laureateid, category, surname, year) 
VALUES ('HU', 'Magyarország', 999, 'Cassandra', 'Óbuda University', 2020);
```
