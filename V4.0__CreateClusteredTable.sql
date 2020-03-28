CREATE TABLE public.clustered_table(
id integer,
name text) WITH (FILLFACTOR =90);

CREATE INDEX id_idx ON public.clustered_table(id);

INSERT INTO public.clustered_table SELECT(random()*10000)::INTEGER, 'test' FROM generate_series(1,10000) AS g(i);

