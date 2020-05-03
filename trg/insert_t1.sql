BEGIN
  INSERT INTO tbl_1 (SELECT generate_series(1,100), "string");
COMMIT;
