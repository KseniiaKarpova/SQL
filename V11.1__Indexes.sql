CREATE TABLE public.hash_table(
    id   serial PRIMARY KEY,
    name varchar);

CREATE TABLE public.btree_table(
    id   serial PRIMARY KEY,
    name varchar);


CREATE TABLE public.brin_table(
    id   serial PRIMARY KEY,
    name varchar);

CREATE INDEX hash_index ON public.hash_table USING hash(name);
CREATE INDEX btree_index ON public.btree_table USING btree(name);
CREATE INDEX brin_index ON public.brin_table USING brin(name) WITH (pages_per_range=4, autosummarize=true);


INSERT INTO public.hash_table(name)
SELECT (random()*100) FROM generate_series(1,100000) AS g(i);

INSERT INTO public.btree_table(name)
SELECT (random()*100) FROM generate_series(1,100000) AS g(i);

INSERT INTO public.brin_table(name)
SELECT (random()*100) FROM generate_series(1,100000) AS g(i);
