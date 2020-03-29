\set idnew random(500000, 1000000)
\set idold random(0,300000)
BEGIN;
UPDATE public.tbl
SET id=:idnew
WHERE id=:idold;
END;
