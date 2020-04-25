#include <stdio.h>
#include "postgres.h"

#include "fmgr.h"
#include "libpq/pqformat.h"

PG_MODULE_MAGIC;

typedef struct Complex
{
	double		x;
	double		y;
}			Complex;


/*****************************************************************************/

PG_FUNCTION_INFO_V1(complex_in);

Datum
complex_in(PG_FUNCTION_ARGS)
{
	char	   *str = PG_GETARG_CSTRING(0);
	double		x,
				y;
	Complex    *result;

	if (sscanf(str, " ( %lf , %lf )", &x, &y) != 2)
		ereport(ERROR,
				(errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
				 errmsg("invalid input syntax for type %s: \"%s\"",
						"complex", str)));

	result = (Complex *) palloc(sizeof(Complex));
	result->x = x;
	result->y = y;
	PG_RETURN_POINTER(result);
}

PG_FUNCTION_INFO_V1(complex_out);

Datum
complex_out(PG_FUNCTION_ARGS)
{
	Complex    *complex = (Complex *) PG_GETARG_POINTER(0);
	char	   *result;

	result = psprintf("(%g,%g)", complex->x, complex->y);
	PG_RETURN_CSTRING(result);
}

/*****************************************************************************/

PG_FUNCTION_INFO_V1(complex_recv);

Datum
complex_recv(PG_FUNCTION_ARGS)
{
	StringInfo	buf = (StringInfo) PG_GETARG_POINTER(0);
	Complex    *result;

	result = (Complex *) palloc(sizeof(Complex));
	result->x = pq_getmsgfloat8(buf);
	result->y = pq_getmsgfloat8(buf);
	PG_RETURN_POINTER(result);
}

PG_FUNCTION_INFO_V1(complex_send);

Datum
complex_send(PG_FUNCTION_ARGS)
{
	Complex    *complex = (Complex *) PG_GETARG_POINTER(0);
	StringInfoData buf;

	pq_begintypsend(&buf);
	pq_sendfloat8(&buf, complex->x);
	pq_sendfloat8(&buf, complex->y);
	PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

/*****************************************************************************/

PG_FUNCTION_INFO_V1(complex_add);

Datum
complex_add(PG_FUNCTION_ARGS)
{
	Complex    *a = (Complex *) PG_GETARG_POINTER(0);
	Complex    *b = (Complex *) PG_GETARG_POINTER(1);
	Complex    *result;

	result = (Complex *) palloc(sizeof(Complex));
	result->x = a->x + b->x;
	result->y = a->y + b->y;
	PG_RETURN_POINTER(result);
}
//----------------------------------------------------
PG_FUNCTION_INFO_V1(complex_minus);

Datum
complex_minus(PG_FUNCTION_ARGS)
{
	Complex    *a = (Complex *) PG_GETARG_POINTER(0);
	Complex    *b = (Complex *) PG_GETARG_POINTER(1);
	Complex    *result;

	result = (Complex *) palloc(sizeof(Complex));
	result->x = a->x - b->x;
	result->y = a->y - b->y;
	PG_RETURN_POINTER(result);
}

//-----------------------------------------------------
PG_FUNCTION_INFO_V1(complex_multiplication);

Datum
complex_multiplication(PG_FUNCTION_ARGS)
{
	Complex    *a = (Complex *) PG_GETARG_POINTER(0);
	Complex    *b = (Complex *) PG_GETARG_POINTER(1);
	Complex    *result;

	result = (Complex *) palloc(sizeof(Complex));
	result->x = (a->x * b->x) - (a->y * b->y);
	result->y = (a->x * b->y) + (a->y * b->x);
	PG_RETURN_POINTER(result);
}

//-------------------------------------------------
PG_FUNCTION_INFO_V1(complex_division);

Datum
complex_division(PG_FUNCTION_ARGS)
{
	Complex    *a = (Complex *) PG_GETARG_POINTER(0);
	Complex    *b = (Complex *) PG_GETARG_POINTER(1);
	Complex    *result;

	result = (Complex *) palloc(sizeof(Complex));
	result->x = ((a->x * b->x) + (a->y * b->y))/ ((b->x * b->x) + (b->y * b->y));
	result->y =  ((a->y * b->x) + (a->x * b->y))/ ((b->x * b->x) + (b->y * b->y))
	PG_RETURN_POINTER(result);
}
