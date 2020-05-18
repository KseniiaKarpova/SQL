\set id random(1, 1000)
BEGIN;
SELECT f2(:id);
END;
