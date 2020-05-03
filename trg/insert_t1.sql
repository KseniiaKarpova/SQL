BEGIN;
  INSERT INTO public.tbl_1 SELECT generate_series(1,100)::INTEGER, 'string';
COMMIT;
