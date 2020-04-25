CREATE FUNCTION complex_in(cstring)
 RETURNS complex
 AS 'complex'
 LANGUAGE C IMMUTABLE STRICT;
 
 CREATE FUNCTION complex_out(complex)
 RETURNS cstring
 AS 'complex'
 LANGUAGE C IMMUTABLE STRICT;
 
 CREATE FUNCTION complex_recv(internal)
 RETURNS complex
 AS 'complex'
 LANGUAGE C IMMUTABLE STRICT;
 
 CREATE FUNCTION complex_send(complex)
 RETURNS bytea
 AS 'complex'
 LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE complex (
 internallength = 16,
 input = complex_in,
 output = complex_out,
 receive = complex_recv,
 send = complex_send,
 alignment = double
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
