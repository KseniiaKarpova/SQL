\set id random(1, 100000)
BEGIN;
SELECT * FROM hash_table WHERE id=:id;
END;
