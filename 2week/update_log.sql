\set id random(1, 77336)
BEGIN;
UPDATE public.log
SET str = random_string()
WHERE id=:id;
END;
