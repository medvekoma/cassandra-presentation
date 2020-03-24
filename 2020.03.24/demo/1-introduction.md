## Collections

```sql
CREATE KEYSPACE demo
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE demo;

CREATE TABLE contacts
(
  id int, 
  name text, 
  phones map<text, text>, 
  PRIMARY KEY (id)
);

INSERT INTO contacts 
  (id, name, phones) 
VALUES 
  (1, 'Cassandra Smiths', {'Home':'+36 1 1234567','Mobile':'+36 30 7894561'});

SELECT * FROM contacts;
```

| Row Key |                 |               |                |
| ------ :|: ------------- :|: ----------- :|: ------------ :|
| 1       | name            | phones:Home   | phones:Mobile  |
|         | Cassandra Smith | +36 1 1234567 | +36 30 7894561 |


UPDATE contacts 
SET phones = phones + {'Other':'+1 205 7897897'} 
WHERE id = 1;

-- Check internal data structure with cassandra-cli
use demo;
list contacts;
assume contacts comparator as utf8;
assume contacts validator as utf8;
list contacts;

-- ### User defined types

CREATE TYPE article
(
  id int, 
  name text, 
  price decimal
);

CREATE TABLE invoice 
(
  id int PRIMARY KEY, 
  buyer text, 
  items list<frozen<article>>
);

INSERT INTO invoice (id, buyer, items) 
VALUES (1, 'Joe', [{id: 1, name: 'Book', price: 11.99}, {id: 2, name: 'Computer', price: 3333}]);

SELECT * FROM invoice;

UPDATE invoice 
SET items = items + [{id: 3, name: 'Cable', price: 1.00}] 
WHERE id = 1;

-- TODO: check internal data structure with cassandra-cli

-- ## Inserting and Updating

CREATE TABLE user
(
  id int,
  name text,
  PRIMARY KEY (id)
);

INSERT INTO user (id, name)
VALUES ( 1, 'Ada Lovelace');

-- Key violation ?
INSERT INTO user (id, name)
VALUES ( 1, 'Charles Babbage');

SELECT * FROM user;

-- Nothing to update
UPDATE user
SET name = 'Linus Torvalds'
WHERE id = 2;
