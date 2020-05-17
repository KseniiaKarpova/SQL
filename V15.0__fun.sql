CREATE FUNCTION f1() RETURNS SETOF public.brin_table AS $$
SELECT * FROM public.brin_table
WHERE id=1;
$$ LANGUAGE SQL;

CREATE FUNCTION f2()
RETURNS TEXT AS $$
DECLARE
str RECORD;
BEGIN
SELECT * INTO str FROM public.brin_table WHERE id=1;
RETURN str;
END;
$$ LANGUAGE plpgsql;
