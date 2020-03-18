CREATE UNLOGGED TABLE public.unlog(
id serial PRIMARY KEY,
str text);

CREATE TABLE public.log(
id serial PRIMARY KEY,
str text);
