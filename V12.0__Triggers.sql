CREATE TABLE public.hub_table(
  id serial PRIMARY KEY, 
  name VARCHAR); 

CREATE INDEX index_id_hub_table ON public.hub_table(id); 

CREATE TABLE DDL_LOG( 
  time date, 
  username regrole, 
  table_name varchar); 
  
CREATE OR REPLACE FUNCTION write_into_ddl_log() 
RETURNS event_trigger AS 
$$ DECLARE obj record; 
  BEGIN 
  FOR obj IN SELECT * FROM pg_event_trigger_ddl_commands() LOOP 
    INSERT INTO test_log VALUES (CURRENT_DATE, USER::regrole, obj.object_identity); 
  END LOOP; 
  END; 
$$ LANGUAGE plpgsql; 


CREATE EVENT TRIGGER trigger_ddl_log 
  ON ddl_command_end WHEN tag IN ('CREATE TABLE') 
  EXECUTE FUNCTION write_into_ddl_log(); 
  
CREATE OR REPLACE FUNCTION redirect_update() 
RETURNS TRIGGER 
AS
$$ 
  BEGIN 
  DELETE FROM hub_table WHERE id=OLD.id AND name=OLD.name;
  INSERT INTO hub_table VALUES(NEW.id, NEW.name);
  RETURN NULL; 
  END; 
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION create_table()
RETURNS TRIGGER 
AS 
$$ 
  DECLARE table_name_str VARCHAR;
  check_table VARCHAR; 
  BEGIN 
  table_name_str := 'hub_table_part_' || (NEW.id / 100000 + 1) :: VARCHAR; 
  SELECT relname INTO check_table FROM pg_class WHERE relname=table_name_str;
  IF check_table ISNULL THEN 
    EXECUTE 
      format('CREATE TABLE %s (like hub_table including all) INHERITS (hub_table);', table_name_str); 
    EXECUTE
      format('ALTER TABLE %s ADD CONSTRAINT partition_check check ( id >= %s and id <= %s );',
      table_name_str, NEW.id / 100000 * 100000, (NEW.id / 100000 + 1) * 100000); 
    EXECUTE  
      format('CREATE TRIGGER %s INSTEAD OF UPDATE ON %s FOR EACH ROW EXECUTE FUNCTION redirect_update();',
      'trg_redirect_update_' || table_name_str, table_name_str); 
   END IF; 
 EXECUTE 
 format('INSERT INTO %s VALUES(%s, %L);',
 table_name_str, NEW.id, NEW.name);  
RETURN NULL; 
END; 
$$ LANGUAGE plpgsql; 

 
CREATE TRIGGER tigger_create_table
BEFORE INSERT ON public.hub_table FOR EACH ROW 
EXECUTE FUNCTION create_table();


INSERT INTO public.hub_table(name) 
SELECT (random()*100) FROM generate_series(1,1000000) AS g(i);
