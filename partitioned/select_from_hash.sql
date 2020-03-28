\set id random(1,1000000)
BEGIN;
SELECT * FROM public.hash
WHERE id = :id;
COMMIT;
