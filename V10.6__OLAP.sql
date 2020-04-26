CREATE TYPE matrix AS (
  points integer[5][5]
);

CREATE OR REPLACE FUNCTION matrix_add(matrix, matrix) RETURNS
 matrix AS
$$ 
BEGIN
   FOR i IN 1..5 LOOP
      FOR j IN 1..5 LOOP
        $1.points[i][j] := $1.points[i][j] +$2.points[i][j];
      END LOOP;
   END LOOP;
  RETURN $1;
 END;
$$ LANGUAGE plpgsql; 


CREATE AGGREGATE sum_matrix(matrix) (
sfunc = matrix_add,
stype = matrix,
initcond = '("{{0, 0, 0, 0, 0} , {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0},{0, 0, 0, 0, 0},{0, 0, 0, 0, 0}}")',
combinefunc = matrix_add,
parallel = safe
);

CREATE TABLE public.matrix_t(
id serial PRIMARY KEY,
m matrix);
