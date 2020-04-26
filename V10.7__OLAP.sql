CREATE OR REPLACE FUNCTION matrix_add(matrix, matrix) RETURNS
 matrix AS
$$ 
 DECLARE
  m matrix:= ('("{{0, 0, 0, 0, 0} , {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0},{0, 0, 0, 0, 0},{0, 0, 0, 0, 0}}")');
BEGIN
   FOR i IN 1..5 LOOP
      FOR j IN 1..5 LOOP
        m.points[i][j] := $1.points[i][j] +$2.points[i][j];
      END LOOP;
   END LOOP;
  RETURN ROW(m)::matrix;
 END;
$$ LANGUAGE plpgsql; 
