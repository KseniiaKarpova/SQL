BEGIN;
INSERT INTO log(str) SELECT random_string();
END;
