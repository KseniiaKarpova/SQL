CREATE OR REPLACE FUNCTION matrix_add(matrix, matrix) RETURNS
 matrix AS
$$ 
BEGIN
   FOR i IN 1..5 LOOP
      FOR j IN 1..5 LOOP
        $1.points[i][j] := $1.points[i][j] +$2.points[i][j];
      END LOOP;
   END LOOP;
  RETURN ROW($1)::matrix;
 END;
$$ LANGUAGE plpgsql; 
