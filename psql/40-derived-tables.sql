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
    WHERE table_schema = 'litrev' AND table_name ~ '[0-9]$' ;

CREATE TEMP TABLE species_traits (species_code,trait_codes) AS (
  WITH A AS (
    SELECT 'repr2' AS table_name, species_code FROM litrev.repr2
    UNION SELECT 'repr3' AS table_name, species_code FROM litrev.repr3
    UNION SELECT 'repr3a' AS table_name, species_code FROM litrev.repr3a
    UNION SELECT 'repr4' AS table_name, species_code FROM litrev.repr4
    UNION SELECT 'rect2' AS table_name, species_code FROM litrev.rect2
    UNION SELECT 'germ1' AS table_name, species_code FROM litrev.germ1
    UNION SELECT 'grow1' AS table_name, species_code FROM litrev.grow1
    UNION SELECT 'germ8' AS table_name, species_code FROM litrev.germ8
    UNION SELECT 'surv1' AS table_name, species_code FROM litrev.surv1
    UNION SELECT 'surv4' AS table_name, species_code FROM litrev.surv4
    UNION SELECT 'surv5' AS table_name, species_code FROM litrev.surv5
    UNION SELECT 'surv6' AS table_name, species_code FROM litrev.surv6
    UNION SELECT 'surv7' AS table_name, species_code FROM litrev.surv7
    UNION SELECT 'disp1' AS table_name, species_code FROM litrev.disp1
  )
  SELECT species_code,array_agg(table_name) FROM A GROUP BY species_code
)

CREATE SCHEMA vag;

CREATE TABLE vag.va_groups(
  species VARCHAR(255),
  species_code numeric PRIMARY KEY,
  persistence text[],
  rationale_persistence text[],
  status_persistence text[],
  establishment text[],
  status_establishment text[],
  date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
  comments text[]
);
ALTER TABLE vag.va_groups
  ADD CONSTRAINT va_groups_fkey
  FOREIGN KEY (species_code)
  REFERENCES species.caps("speciesID")
  ON DELETE CASCADE ON UPDATE CASCADE;


---
--
-- create or replace function uall() returns table ( code integer ,
--   value character varying(50),
--   active boolean,tablename text ) AS $$
-- declare
--   _i int;
--   _r record;
--   _t text := '';
-- begin
--   select distinct string_agg($s$select *,'$s$||table_name||$s$' from $s$||table_name,' union all ') into _t from information_schema.tables where table_name like 'vl_%';
-- return query execute _t;
-- end;$$ language plpgsql
-- ;
--
-- select * from uall()
