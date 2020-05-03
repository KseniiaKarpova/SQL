SELECT *
from brin_table 
left join clustered_table ON brin_table.id = clustered_table.id
left join  hash_table on clustered_table.id= hash_table.id
right join btree_t on btree_t.a = clustered_table.id
inner join gin_tbl on gin_tbl.id = hash_table.id
right join gist_tbl on gist_tbl.id = gin_tbl.id
right join public.log on public.log.id = hash_table.id
inner join btree_table on btree_table.id = gin_tbl.id; 
