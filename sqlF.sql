\set id random(1, 1000)
BEGIN;
SELECT f1(:id);
END;
