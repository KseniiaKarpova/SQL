CREATE TABLE public.BTree_t (
    A integer,
    B integer,
    C integer);


CREATE INDEX a_btree_index ON public.BTree_t USING btree (A);
CREATE INDEX c_btree_index ON public.BTree_t USING btree (C);
CREATE INDEX b_btree_index ON public.BTree_t USING btree (B);
CREATE INDEX ab_btree_index ON public.BTree_t USING btree (A, B);
CREATE INDEX ba_btree_index ON public.BTree_t USING btree (B, A);
CREATE INDEX ac_btree_index ON public.BTree_t USING btree (A, C);
CREATE INDEX ca_btree_index ON public.BTree_t USING btree (C, A);
CREATE INDEX cb_btree_index ON public.BTree_t USING btree (C, B);
CREATE INDEX bc_btree_index ON public.BTree_t USING btree (B, C);
CREATE INDEX abc_btree_index ON public.BTree_t USING btree (A, B, C);
CREATE INDEX acb_btree_index ON public.BTree_t USING btree (A, C, B);
CREATE INDEX bac_btree_index ON public.BTree_t USING btree (B, A, C);
CREATE INDEX bca_btree_index ON public.BTree_t USING btree (B, C, A);
CREATE INDEX cba_btree_index ON public.BTree_t USING btree (C, B, A);
CREATE INDEX cab_btree_index ON public.BTree_t USING btree (C, A, B);

INSERT INTO public.BTree_t(A, B, C) SELECT (random()*100)::INTEGER, (random()*100)::INTEGER, (random()*100)::INTEGER  
FROM generate_series(1,1000) AS g(i);
