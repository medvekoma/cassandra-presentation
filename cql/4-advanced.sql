-------------------------------------------------------------
-- Cassandra 3.11
-- use demo;
-------------------------------------------------------------

-- ## Counter tables

-- Only key and counter columns
CREATE TABLE employee_counter (
  employeeid bigint,
  year int,
  vacation_days counter,
  badges counter,
  PRIMARY KEY (employeeid, year)
);

-- Update counter is the only operation allowed
UPDATE employee_counter
SET badges = badges + 1
WHERE employeeid = 1 AND year = 2016;

-- ERROR: Cannot set, just increment
UPDATE employee_counter
SET badges = 17
WHERE employeeid = 1 AND year = 2016;

-- ## Lightweight Transactions

-- Verify by primary key
INSERT INTO users (username, name, passwordhash)
VALUES ('ada', 'Ada Lovelace', '20a46ee0')
IF NOT EXISTS;

-- Verify by any field
UPDATE users
SET passwordhash = '20a5f580'
WHERE username = 'ada'
IF passwordhash = '20a46ee0';

-- ## Materialized Views

CREATE MATERIALIZED VIEW laureates_by_category AS
  SELECT * FROM laureates
  -- primary key fields must be non-null
  WHERE category IS NOT NULL AND laureateid IS NOT NULL
PRIMARY KEY (category, year, laureateid)
WITH CLUSTERING ORDER BY (year DESC, laureateid ASC);

INSERT INTO laureates
(year, laureateid, category, firstname)
VALUES (2019, 9999, 'Cassandra', 'epam');

SELECT * FROM laureates_by_category
WHERE category = 'Cassandra';

-- ## JSON support

INSERT INTO contacts JSON
'{
  "id": 2,
  "name": "epam",
  "phones":
  {
    "Budapest": "+36 1 3277400",
    "Szeged": "+36 62 550656"
  }
}';
