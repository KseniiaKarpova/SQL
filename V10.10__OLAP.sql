DROP AGGREGATE sum_matrix(matrix);

CREATE AGGREGATE sum_matrix(matrix) (
sfunc = matrix_add,
stype = matrix,
initcond = '("{{0, 0, 0, 0, 0} , {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0},{0, 0, 0, 0, 0},{0, 0, 0, 0, 0}}")',
combinefunc = matrix_add,
parallel = safe
);
