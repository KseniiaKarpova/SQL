DO $$
BEGIN;
PREPARE ps(INTEGER, VARCHAR) AS
  INSERT INTO public.tbl_2 VALUES($1, $2);
  FOR i in 1..100 LOOP
    EXECUTE ps(%i, 'string');
  END LOOP;
  DEADLLOCATE ps;
COMMIT;
$$ LANGUAGE plpgsql; 
