-- Schema for storing information from the field (field forms)
CREATE SCHEMA litrev;


CREATE TABLE IF NOT EXISTS litrev.ref_list (
    ref_code varchar(50) PRIMARY KEY,
    ref_cite text,
    alt_code varchar(30)
);


CREATE TABLE IF NOT EXISTS litrev.survival_traits(
   species VARCHAR(255),
   species_code int,
   resprouting resprouting_types,
   regenerative_organ resprout_organ,
   standing_plant_longevity int,
   seedbank_halflife int,
   seed_longevity int,
   PRIMARY KEY (species,species_code)
);

-- we will accept all entries and then match them a posteriori.
-- ALTER TABLE litrev.survival_traits
--   ADD CONSTRAINT traits_ref_fkey
--   FOREIGN KEY (species_code,species)
--   REFERENCES species.caps("currentScientificNameCode","currentScientificName") -- speciesID is a new code
--   ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS litrev.germination_traits(
  species VARCHAR(255),
  species_code int,
  seedbank_type seedbank_type,
  heat_cued_germination yes_no_indet,
  smoke_cued_germination yes_no_indet,
  heat_smoke_interactive_germination_cue heat_smoke_interaction,
  T50 numeric,
  T_max numeric,
  T_lethal numeric,

CREATE TABLE IF NOT EXISTS litrev.recruitment_traits(
  species VARCHAR(255),
  species_code int,
  postfire_seedling_recruitment post_seed_recruit,
  establishment_pattern establishment_type,


CREATE TABLE IF NOT EXISTS litrev.reproduction_traits(
species VARCHAR(255),
species_code int,
flowering_commencement months,
flowering_cessation months,
postfire_flowering_response postfire_response,
first_flower_production int,
maturation_age int,
age_at_maximum_seed_production int,
age_at_maximum_seedbank_size int,

CREATE TABLE IF NOT EXISTS litrev.growth_traits(
species VARCHAR(255),
species_code int,
age_for_development_regnerative_organs int,
age_at_maximum_growth_stage int,
maximum_growth_stage text,

   -- information_type text[],
   -- ref_code varchar(100),
   -- refs text[],
   PRIMARY KEY (species,species_code)
);


ALTER TABLE litrev.traits
  ADD CONSTRAINT traits_ref_fkey
  FOREIGN KEY (ref_code)
  REFERENCES simple_ref_list(ref_code)
  ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS simple_ref_list (
ref_code varchar(100) PRIMARY KEY,
ref_cite text,
ref_json text
);


CREATE SCHEMA litrev ;
CREATE TABLE IF NOT EXISTS litrev.raw_annotations (
species VARCHAR(255),
species_code int NULL,
attribute text,
value text,
ref_code varchar(100),
refs text[]
);
ALTER TABLE litrev.raw_annotations ADD PRIMARY KEY (species,attribute,ref_code);

ALTER TABLE litrev.raw_annotations
  ADD CONSTRAINT raw_annotations_ref_fkey
  FOREIGN KEY (ref_code)
  REFERENCES simple_ref_list(ref_code)
  ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS litrev.nsw_status (
species VARCHAR(255),
species_code int PRIMARY KEY,
common_name VARCHAR(255),
nsw_status varchar(50),
source text,
access_date DATE
);

--ALTER TABLE litrev.nsw_status   ADD CONSTRAINT nsw_status_code_fkey  FOREIGN KEY (species_code)  REFERENCES ...(...)  ON DELETE CASCADE ON UPDATE CASCADE;
