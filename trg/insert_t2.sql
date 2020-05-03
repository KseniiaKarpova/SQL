
BEGIN;
PREPARE ps(INTEGER, VARCHAR) AS
  INSERT INTO public.tbl_2 VALUES($1, $2);
  DO $$
  BEGIN
  FOR i in 1..100 LOOP
    EXECUTE ps(i, 'string');
  END LOOP;
  END;
  $$ LANGUAGE plpgsql; 
DEADLLOCATE ps;
COMMIT;

