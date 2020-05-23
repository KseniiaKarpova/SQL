CREATE TABLE t1000 AS
SELECT * FROM generate_series(1, 1000) AS id;

CREATE TABLE t10000 AS
SELECT * FROM generate_series(1, 10000) AS id;

CREATE TABLE t100000 AS
SELECT * FROM generate_series(1, 100000) AS id;

CREATE EXTENSION pg_prewarm;
SELECT pg_prewarm('t1000');
SELECT pg_prewarm('t10000');
SELECT pg_prewarm('t100000');
