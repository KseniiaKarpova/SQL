CREATE TABLE users ( id INTEGER, name VARCHAR ); 
 
CREATE INDEX idx_users ON users(id); 
 
CREATE TABLE test_log( time date, user_name varchar, table_name varchar ); 
 
CREATE OR REPLACE FUNCTION write_log_fun() RETURNS event_trigger AS $$ DECLARE obj record; BEGIN FOR obj IN SELECT * FROM pg_event_trigger_ddl_commands() LOOP INSERT INTO test_log VALUES (CURRENT_DATE, USER, obj.object_identity); END LOOP; END; $$ LANGUAGE plpgsql; 
 
CREATE EVENT TRIGGER write_log_table ON ddl_command_end WHEN tag IN ('CREATE TABLE') EXECUTE FUNCTION write_log_fun(); 
 
 
CREATE OR REPLACE FUNCTION redirect_update() RETURNS TRIGGER AS $$ BEGIN 
DELETE FROM users WHERE id=OLD.id AND name=OLD.name; INSERT INTO users VALUES(NEW.id, NEW.name); RETURN NULL; 
END; 
$$ LANGUAGE plpgsql; 
 

BEGIN table_name_str := 'users_part_' || (NEW.id / 100000 + 1) :: VARCHAR; 
 
SELECT relname INTO check_table FROM pg_class WHERE relname=table_name_str; IF check_table ISNULL THEN EXECUTE  format('CREATE TABLE %s (like users including all) INHERITS (users);', table_name_str); 
 
EXECUTE     format('ALTER TABLE %s     ADD CONSTRAINT partition_check     check ( id >= %s and id <= %s );', table_name_str, NEW.id / 100000 * 100000, (NEW.id / 100000 + 1) * 100000); 
 
EXECUTE  format('CREATE TRIGGER %s INSTEAD OF UPDATE ON %s FOR EACH ROW EXECUTE FUNCTION redirect_update();', 'trg_redirect_update_' || table_name_str, table_name_str); END IF; 
 
EXECUTE format('INSERT INTO %s VALUES(%s, %L);', table_name_str, NEW.id, NEW.name); 
 
RETURN NULL; 
END; 
$$ LANGUAGE plpgsql; 
 
CREATE TRIGGER trg_dynamic_create_table BEFORE INSERT ON users FOR EACH ROW EXECUTE FUNCTION dynamic_create_table(); 
 
BEGIN; INSERT INTO public.users SELECT ((random() * 1000000)::integer + 1), 'qweqwe' || i::VARCHAR FROM generate_series(1, 1000000) AS k(i); COMMIT; 
