\set id random(1,1000000)
BEGIN;
SELECT * FROM public.heap_table
WHERE id = :id;
COMMIT;
