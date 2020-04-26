CREATE TYPE matrix AS (
  points integer[5][5]
);

CREATE FUNCTION matrix_add(matrix, matrix) RETURNS
 matrix AS
$$ 
 DECLARE
  m matrix;
BEGIN
 FOR i IN 1..5 LOOP
  FOR i IN 1..5 LOOP
    m.points[i][j] := $1.points[i][j] +$2.points[i][j]
  END LOOP;
 END LOOP;
RETURN ROW(m)::matrix;
END;
$$ LANGUAGE plpgsql; 


CREATE OR REPLACE FUNCTION matrix_final(
state matrix
) RETURNS complex AS $$
BEGIN
RAISE NOTICE '[ % \n % \n % \n % \n % ]', state.points[1],state.points[2], state.points[3], state.points[4], state.points[5] ;
RETURN state;
END;
$$ LANGUAGE plpgsql;

CREATE AGGREGATE sum_matrix(matrix) (
sfunc = matrix_add,
stype = matrix,
finalfunc = matrix_final,
initcond = '{{0,0,0,0,0}{0,0,0,0,0}{0,0,0,0,0}{0,0,0,0,0}{0,0,0,0,0}}',
combinefunc = matrix_add,
parallel = safe
);

CREATE TABLE public.matrix_t(
id serial PRIMARY KEY,
m matrix);
