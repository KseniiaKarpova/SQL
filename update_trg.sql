\set idnew random(1, 1000000)
\set idold random(1,1000000)
BEGIN;
UPDATE public.hub_table
SET id=:idnew
WHERE id=:idold;
END;
