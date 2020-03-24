
-- Preparations:
-- execute cluster/02-setup-nobel.sh

USE nobel;

SELECT * FROM laureates LIMIT 10;

SELECT * FROM laureates WHERE year = 2010;

SELECT * FROM laureates WHERE year IN (2010, 2011);

SELECT * FROM laureates WHERE borncountrycode = 'HU';

CREATE INDEX ON laureates (borncountrycode);

SELECT * FROM laureates WHERE borncountrycode = 'HU';

SELECT * FROM laureates WHERE borncity='Budapest';

-- not recommended
SELECT * FROM laureates WHERE borncity='Budapest'
ALLOW FILTERING;

-- ### Slicing

CREATE TABLE calls (
    customerid bigint,
    year int,
    month int,
    callid timeuuid,
    seconds int,
    PRIMARY KEY (customerid, year, month, callid)
);

INSERT INTO calls (customerid, year, month, callid, seconds) VALUES (1, 2015, 11, now(), 55);
INSERT INTO calls (customerid, year, month, callid, seconds) VALUES (1, 2015, 12, now(), 44);
INSERT INTO calls (customerid, year, month, callid, seconds) VALUES (1, 2015, 12, now(), 33);
INSERT INTO calls (customerid, year, month, callid, seconds) VALUES (1, 2016,  1, now(), 77);
INSERT INTO calls (customerid, year, month, callid, seconds) VALUES (1, 2016,  1, now(), 88);
INSERT INTO calls (customerid, year, month, callid, seconds) VALUES (1, 2016,  2, now(), 11);

SELECT * FROM calls WHERE customerid = 1;
SELECT * FROM calls WHERE customerid = 1 AND year = 2015;
SELECT * FROM calls WHERE customerid = 1 AND month = 2;
SELECT * FROM calls WHERE customerid = 1 AND year = 2015 and month = 12;
SELECT * FROM calls WHERE customerid = 1 AND (year, month) >= (2015, 12) AND (year, month) <= (2016, 1);

-- ## Ordering

USE nobel;

DESCRIBE TABLE laureates;

SELECT * FROM laureates WHERE year=2002;

SELECT * FROM laureates WHERE year=2002 
ORDER BY laureateid DESC;

SELECT * FROM laureates WHERE year=2002
ORDER BY borncountrycode;

SELECT * FROM laureates WHERE borncountrycode='HU';

SELECT * FROM laureates WHERE borncountrycode='HU'
ORDER BY laureateid;

SELECT * FROM laureates WHERE year in (2002, 1992)
ORDER BY laureateid;

CREATE TABLE laureates_by_category (
  year int,
  laureateid int,
  borncity text,
  borncountrycode text,
  category text,
  firstname text,
  surname text,
  PRIMARY KEY (category, year, laureateid))
WITH CLUSTERING ORDER BY (year DESC);

COPY laureates_by_category (year, category, laureateid, firstname, surname, borncountrycode, borncity)
FROM 'nobel-laureates.csv';

SELECT * FROM laureates_by_category WHERE category = 'physics';
SELECT * FROM laureates_by_category WHERE category = 'physics' LIMIT 5;
SELECT * FROM laureates_by_category WHERE category = 'physics' ORDER BY year LIMIT 5;
