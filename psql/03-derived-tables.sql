SELECT table_name
  FROM information_schema.tables
  WHERE table_schema = 'litrev'
  AND table_name LIKE '%[0-9]'


  SELECT
    string_agg(
      'SELECT '''
      ||table_name
      ||''' AS table_name, species_code FROM litrev.'
      ||table_name
    , ' UNION ')::text
  FROM information_schema.tables
    WHERE table_schema = 'litrev'

CREATE TEMP TABLE species_traits (species_code,trait_codes) AS (
  WITH A AS (SELECT 'germ1' AS table_name, species_code FROM litrev.germ1 UNION SELECT 'repr4' AS table_name, species_code FROM litrev.repr4 UNION SELECT 'grow1' AS table_name, species_code FROM litrev.grow1 UNION SELECT 'rect2' AS table_name, species_code FROM litrev.rect2 UNION SELECT 'repr3a' AS table_name, species_code FROM litrev.repr3a UNION SELECT 'repr2' AS table_name, species_code FROM litrev.repr2 UNION SELECT 'surv1' AS table_name, species_code FROM litrev.surv1 UNION SELECT 'repr3' AS table_name, species_code FROM litrev.repr3)
  SELECT species_code,array_agg(table_name) FROM A GROUP BY species_code
)

select distinct litrev.surv1.species_code,'surv1' from litrev.surv1;
select distinct species_code,'rect2' from litrev.rect2;
select distinct species_code,'repr2' from litrev.repr2;
select distinct species_code,'repr3' from litrev.repr3;
select distinct species_code,'repr3a' from litrev.repr3a;
select distinct species_code,'repr4' from litrev.repr4;


create or replace function uall() returns table ( code integer ,
  value character varying(50),
  active boolean,tablename text ) AS $$
declare
  _i int;
  _r record;
  _t text := '';
begin
  select distinct string_agg($s$select *,'$s$||table_name||$s$' from $s$||table_name,' union all ') into _t from information_schema.tables where table_name like 'vl_%';
return query execute _t;
end;$$ language plpgsql
;

select * from uall()
