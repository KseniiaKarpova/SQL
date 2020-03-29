INSERT INTO public.tbl SELECT(random()*1000000)::INTEGER, 'test' FROM generate_series(1,1000000) AS g(i);

