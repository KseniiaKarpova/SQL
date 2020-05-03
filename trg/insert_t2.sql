BEGIN;
PREPARE ps(INTEGER, VARCHAR) AS
  INSERT INTO public.tbl_2 VALUES($1, $2);
  EXECUTE ps($1, $2)using SELECT generate_series(1,100)::INTEGER, 'string');
  DEADLLOCATE ps;
COMMIT;
