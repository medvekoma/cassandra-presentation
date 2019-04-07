-------------------------------------------------------------
-- cassandra-cli is deprecated after Cassandra 2.1
-- for examining internal data structure, use Cassandra 2.1
-------------------------------------------------------------

CREATE KEYSPACE cars
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 2};

USE cars;

-- ## Primary key

-- ### Partition key

CREATE TABLE car_registry_1
(
  regnr text,
  car text,
  owner text,
  PRIMARY KEY (regnr)
);

INSERT INTO car_registry_1 (regnr, car, owner)
VALUES ('ABC-111', 'Peugeot', 'Judit Kiss');

INSERT INTO car_registry_1 (regnr, car, owner)
VALUES ('PETER-1', 'Maserati', 'Peter Nagy');

SELECT * FROM car_registry_1;

-- check internal data structure with cassandra-cli
use cars;
list car_registry_1;
assume car_registry_1 validator as 'ascii';

-- ### Partition Key and Clustering Key

-- Don't do this in production
CREATE TABLE car_registry_2
(
  country text,
  regnr text,
  car text,
  owner text,
  PRIMARY KEY (country, regnr)
);

INSERT INTO car_registry_2 (country, regnr, car, owner)
VALUES ('H', 'ABC-111', 'Peugeot', 'Judit Kiss');

INSERT INTO car_registry_2 (country, regnr, car, owner)
VALUES ('H', 'PETER-1', 'Maserati', 'Peter Nagy');

INSERT INTO car_registry_2 (country, regnr, car, owner)
VALUES ('B', 'PETER-1', 'Mercedes', 'Peter Small');

SELECT * FROM car_registry_2;

-- TODO: check internal data structure with cassandra-cli

-- ### Static Columns

-- Don't do this in production
CREATE TABLE car_registry_static
(
  country text,
  cname text static,
  regnr text,
  car text,
  owner text,
  PRIMARY KEY (country, regnr)
);

INSERT INTO car_registry_static (country, cname, regnr, car, owner)
VALUES ('H', 'Magyarorszag', 'ABC-111', 'Peugeot', 'Judit Kiss');

INSERT INTO car_registry_static (country, cname, regnr, car, owner)
VALUES ('H', 'Hungary', 'PETER-1', 'Maserati', 'Peter Nagy');

INSERT INTO car_registry_static (country, cname, regnr, car, owner)
VALUES ('B', 'Belgium', 'PETER-1', 'Mercedes', 'Peter Small');

SELECT * FROM car_registry_static;

-- check internal data structure with cassandra-cli
use cars;
list car_registry_static;
assume car_registry_static validator as 'ascii';
