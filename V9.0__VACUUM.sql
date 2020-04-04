CREATE TABLE public.tab_vacuum(
id integer,
name text);

ALTER TABLE public.tab_vacuum SET (
autovacuum_enabled = false, toast.autovacuum_enabled = false);


INSERT INTO public.tab_vacuum VALUES (1, 'Kseniia');
