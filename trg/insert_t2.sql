BEGIN;
PREPARE ps(INTEGER, VARCHAR) AS
  INSERT INTO public.tbl_2 VALUES($1, $2);
  EXECUTE ps(SELECT generate_series(1,100)::INTEGER, 'string');
COMMIT;
