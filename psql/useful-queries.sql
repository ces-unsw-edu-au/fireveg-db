
\x
select * from functional_groups ;
select distinct name from efg_authors;
select names from functional_groups order by names;
select biome_code,code,name from functional_groups order by biome_code,code;
select typarray,typname,enumsortorder,enumlabel from pg_type typ left join pg_enum enu on enu.enumtypid=typ.oid where typname ='sampling_method'
