CREATE TYPE complex AS (
    r       double precision,
    i       double precision
);

CREATE FUNCTION complex_add(complex, complex) RETURNS
 complex AS
$$ 
 BEGIN
 RETURN ROW($1.r + $2.r, $1.i + $2.i)::complex;
 END;
$$ LANGUAGE plpgsql; 

CREATE FUNCTION complex_minus(complex, complex) RETURNS
 complex AS
$$ 
 BEGIN
 RETURN ROW($1.r - $2.r, $1.i - $2.i)::complex;
 END;
$$ LANGUAGE plpgsql; 
 
CREATE FUNCTION complex_multiplication(complex, complex) RETURNS
 complex AS
$$ 
 BEGIN
 RETURN ROW(($1.r * $2.r) - ($1.i * $2.i) , ($1.r * $2.i) + ($1.i * $2.r))::complex;
 END;
$$ LANGUAGE plpgsql;
                                                                                                                    
CREATE FUNCTION complex_division(complex, complex) RETURNS
 complex AS
$$ 
 BEGIN
 RETURN ROW((($1.r * $2.r) + ($1.i * $2.i))/($2.r*$2.r + $2.i*$2.i), (($1.i * $2.r) + ($1.r * $2.i))/($2.r*$2.r + $2.i*$2.i))::complex;
 END;
$$ LANGUAGE plpgsql;
                                                                                                      
CREATE OR REPLACE FUNCTION complex_final(
state complex
) RETURNS complex AS $$
BEGIN
RAISE NOTICE '= % + i%', state.r, state.i;
RETURN state;
END;
$$ LANGUAGE plpgsql;                                                                                                      
                                                                                                     
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
initcond = '(1,1)',
combinefunc = complex_division,
parallel = safe
);                                                                                            

CREATE AGGREGATE sum_complex(complex) (
sfunc = complex_add,
stype = complex,
finalfunc = complex_final,
initcond = '(0,0)',
combinefunc = complex_add,
parallel = safe
);
                                                                                                   
CREATE OPERATOR + (
 leftarg = complex,
 rightarg = complex,
 procedure = complex_add,
 commutator = +
);

CREATE OPERATOR - (
 leftarg = complex,
 rightarg = complex,
 procedure = complex_minus,
 commutator = -
);

CREATE OPERATOR * (
 leftarg = complex,
 rightarg = complex,
 procedure = complex_multiplication,
 commutator = *
);

CREATE OPERATOR / (
 leftarg = complex,
 rightarg = complex,
 procedure = complex_division,
 commutator = /
);
