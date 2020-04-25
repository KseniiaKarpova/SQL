CREATE OR REPLACE FUNCTION complex_add(complex, complex) RETURNS
 complex AS
$$ 
 BEGIN
 RETURN ROW($1.r + $2.r, $1.i + $2.i)::complex;
 END;
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE FUNCTION complex_minus(complex, complex) RETURNS
 complex AS
$$ 
 BEGIN
 RETURN ROW($1.r - $2.r, $1.i - $2.i)::complex;
 END;
$$ LANGUAGE plpgsql;
