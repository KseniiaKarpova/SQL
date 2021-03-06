CREATE TABLE public.tbl(
id integer,
name text);

CREATE INDEX idx_tbl ON public.tbl(id);

CREATE TABLE public.t_1() INHERITS (public.tbl);

CREATE TABLE public.t_2() INHERITS (public.tbl);

CREATE TABLE public.t_3() INHERITS (public.tbl);

CREATE TABLE public.t_4() INHERITS (public.tbl);

CREATE TABLE public.t_5() INHERITS (public.tbl);

CREATE TABLE public.t_6() INHERITS (public.tbl);

CREATE TABLE public.t_7() INHERITS (public.tbl);

CREATE TABLE public.t_8() INHERITS (public.tbl);

CREATE TABLE public.t_9() INHERITS (public.tbl);

CREATE TABLE public.t_10() INHERITS (public.tbl);

ALTER TABLE public.t_1 ADD CONSTRAINT partition_check
CHECK (id>=0 and id<100000);

ALTER TABLE public.t_2 ADD CONSTRAINT partition_check
CHECK (id>=100000 and id<200000);

ALTER TABLE public.t_3 ADD CONSTRAINT partition_check
CHECK (id>=200000 and id<300000);

ALTER TABLE public.t_4 ADD CONSTRAINT partition_check
CHECK (id>=300000 and id<400000);

ALTER TABLE public.t_5 ADD CONSTRAINT partition_check
CHECK (id>=400000 and id<500000);

ALTER TABLE public.t_6 ADD CONSTRAINT partition_check
CHECK (id>=500000 and id<600000);

ALTER TABLE public.t_7 ADD CONSTRAINT partition_check
CHECK (id>=600000 and id<700000);

ALTER TABLE public.t_8 ADD CONSTRAINT partition_check
CHECK (id>=700000 and id<800000);

ALTER TABLE public.t_9 ADD CONSTRAINT partition_check
CHECK (id>=800000 and id<900000);

ALTER TABLE public.t_10 ADD CONSTRAINT partition_check
CHECK (id>=900000 and id<1000000);

CREATE OR REPLACE RULE insert_into_t1
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 0 AND 99999
DO INSTEAD INSERT INTO public.t_1 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t2
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 100000 AND 199999
DO INSTEAD INSERT INTO public.t_2 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t3
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 200000 AND 299999
DO INSTEAD INSERT INTO public.t_3 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t4
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 300000 AND 399999
DO INSTEAD INSERT INTO public.t_4 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t5
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 400000 AND 499999
DO INSTEAD INSERT INTO public.t_5 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t6
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 500000 AND 599999
DO INSTEAD INSERT INTO public.t_6 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t7
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 600000 AND 699999
DO INSTEAD INSERT INTO public.t_7 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t8
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 700000 AND 799999
DO INSTEAD INSERT INTO public.t_8 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t9
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 800000 AND 899999
DO INSTEAD INSERT INTO public.t_9 VALUES (NEW.id, NEW.name);

CREATE OR REPLACE RULE insert_into_t10
AS ON INSERT TO public.tbl WHERE NEW.id BETWEEN 900000 AND 999999
DO INSTEAD INSERT INTO public.t_10 VALUES (NEW.id, NEW.name);
