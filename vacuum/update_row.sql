BEGIN;
UPDATE public.tab_vacuum
SET name = random_string()
WHERE id = 1;
END;
