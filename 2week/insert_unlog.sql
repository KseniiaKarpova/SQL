BEGIN;
INSERT INTO unlog(str) SELECT random_string();
END;
