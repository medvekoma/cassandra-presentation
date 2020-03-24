## Inserting and Updating

```sql
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
```
