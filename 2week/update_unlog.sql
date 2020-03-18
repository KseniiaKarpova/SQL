\set id random(1, 94258)
BEGIN;
UPDATE public.unlog
SET str = random_string()
WHERE id=:id;
END;
