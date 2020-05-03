CREATE TABLE public.GIN_table(
    id   serial PRIMARY KEY,
    content varchar);

CREATE TABLE public.BTree_t(
    id   serial PRIMARY KEY,
    content varchar);


CREATE TABLE public.GIST_table(
    id   serial PRIMARY KEY,
    content varchar);

CREATE INDEX gin_index ON public.GIN_table USING GIN(content);
CREATE INDEX btree_idx ON public.BTree_t USING btree(content);
CREATE INDEX gist_index ON public.GIST_table USING GIST(content);


INSERT INTO public.GIN_table(content)
SELECT random_string() FROM generate_series(1,100000) AS g(i);

INSERT INTO public.BTree_t(content)
SELECT random_string() FROM generate_series(1,100000) AS g(i);

INSERT INTO public.GIST_table(content)
SELECT random_string() FROM generate_series(1,100000) AS g(i);
