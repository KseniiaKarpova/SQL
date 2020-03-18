\set id random(1,77336)
BEGIN;
DELETE FROM public.log
WHERE id = :id;
END;
