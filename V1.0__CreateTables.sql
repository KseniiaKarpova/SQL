CREATE UNLOGGED TABLE public.unlog_table(
id serial PRIMARY KEY,
str text);

CREATE TABLE public.log_table(
id serial PRIMARY KEY,
str text);

CREATE FUNCTION random_string()
RETURNS varchar AS $$
SELECT array_to_string(ARRAY(
SELECT substr('qwertyuiopasdfghjklzxcvbnm',trunc(random()*21+1)::int,1)
FROM generate_series(1,10)),'')
$$ LANGUAGE sql VOLATILE;
