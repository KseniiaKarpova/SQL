CREATE TABLE public.GIN_tbl(
    id   serial PRIMARY KEY,
    content varchar);

CREATE TABLE public.BTree_tbl(
    id   serial PRIMARY KEY,
    content varchar);


CREATE TABLE public.GIST_tbl(
    id   serial PRIMARY KEY,
    content varchar);

CREATE INDEX gin_idx ON public.GIN_tbl USING GIN(content);
CREATE INDEX btree_idx ON public.BTree_tbl USING btree(content);
CREATE INDEX gist_idx ON public.GIST_tbl USING GIST(content);


INSERT INTO public.GIN_tbl(content)
SELECT random_string() FROM generate_series(1,100000) AS g(i);

INSERT INTO public.BTree_tbl(content)
SELECT random_string() FROM generate_series(1,100000) AS g(i);

INSERT INTO public.GIST_tbl(content)
SELECT random_string() FROM generate_series(1,100000) AS g(i);
