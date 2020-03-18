\set id random(1, 94258)
BEGIN;
DELETE FROM public.unlog
WHERE id = :id;
END;
