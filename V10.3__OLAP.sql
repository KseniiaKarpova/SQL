DROP AGGREGATE minus_complex(complex);
DROP AGGREGATE multiplication_complex(complex);
DROP AGGREGATE division_complex(complex);

CREATE AGGREGATE minus_complex(complex) (
sfunc = complex_minus,
stype = complex,
finalfunc = complex_final,
initcond = '(0,0)',
combinefunc = complex_minus,
parallel = safe
);
                                                             
CREATE AGGREGATE multiplication_complex(complex) (
sfunc = complex_multiplication,
stype = complex,
finalfunc = complex_final,
initcond = '(1,1)',
combinefunc = complex_multiplication,
parallel = safe
);
                                                                                                      
CREATE AGGREGATE division_complex(complex) (
sfunc = complex_division,
stype = complex,
finalfunc = complex_final,
initcond = '(0,0)',
combinefunc = complex_division,
parallel = safe
);
