
DROP AGGREGATE division_complex(complex);

                                                                                                      
CREATE AGGREGATE division_complex(complex) (
sfunc = complex_division,
stype = complex,
finalfunc = complex_final,
initcond = '(1,1)',
combinefunc = complex_division,
parallel = safe
);
