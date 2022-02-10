,-- Schema for storing information from the field (field forms)
CREATE SCHEMA form;

-- Create controlled vocabularies for some variables:
CREATE TYPE sampling_method AS ENUM ('quadrat', 'transect', 'other');
CREATE TYPE seedbank_type AS ENUM ('soil-persistent', 'transient', 'canopy','non-canopy','other');
CREATE TYPE resprout_organ AS ENUM ('epicormic', 'apical', 'lignotuber', 'basal','tuber','tussock','short rhizome', 'long rhizome or root sucker', 'stolon', 'none', 'other');
CREATE TYPE post_seed_recruit AS ENUM ('abundant','present','absent','other');
CREATE TYPE seedbank_type AS ENUM ('soil-persistent', 'transient', 'canopy','non-canopy','other');
-- DROP TYPE seedbank_type CASCADE;
-- ALTER TYPE seedbank_type ADD VALUE 'non-canopy' AFTER 'canopy';
-- ALTER TYPE seedbank_type RENAME VALUE 'soil' TO 'soil-persistent';
-- \dT
CREATE TYPE age_group AS ENUM ('adult','juvenile', 'other');
CREATE TYPE resprouting_types AS ENUM ('none','few','half','most','all', 'unknown');

--
-- This is copied from tblObserver of Atlas data model
CREATE TABLE IF NOT EXISTS form.observerID (
UserKey SERIAL PRIMARY KEY,
GivenNames varchar(60) NULL,
Surname varchar(60) NOT NULL,
AddressLine1 varchar(50) NULL,
AddressLine2 varchar(50) NULL,
City varchar(30) NULL,
Postcode numeric(4) NULL,
StateID int NULL,
Email varchar(75) NULL,
Occupation varchar(40) NULL,
Notes varchar(255) NULL,
RowTimeStamp timestamp NOT NULL,
CreatedBySystemUserID int NOT NULL,
DateCreated timestamp NOT NULL,
UpdatedBySystemUserID int NOT NULL,
DateUpdated timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS form.field_site (
site_label VARCHAR(30) ,
location_description text,
geom geometry,
elevation numeric,
PRIMARY KEY (site_label)
);


CREATE TABLE IF NOT EXISTS form.surveys (
survey_name VARCHAR(40) ,
survey_description text,
observers text,
PRIMARY KEY (survey_name)
);

COMMENT ON TABLE form.surveys IS 'A single survey is consistent for methods, often has a limited set of recorders and is usually defined in terms of a spatial limit.';
COMMENT ON COLUMN form.surveys.survey_name IS 'Unique identifier of an individual survey, primary reference for queries regarding survey data.';

select obj_description('form.surveys'::regclass);
\d+ form.surveys

CREATE TABLE IF NOT EXISTS form.field_visit (
visit_id VARCHAR(30),
visit_date date,
visit_description text,
mainObserver INT REFERENCES form.observerID ON DELETE RESTRICT,
otherObserver VARCHAR(20),
CreatedBySystemUserID int NOT NULL,
DateCreated timestamp NOT NULL,
UpdatedBySystemUserID int NOT NULL,
DateUpdated timestamp NOT NULL,
PRIMARY KEY (visit_id,visit_date)
);
ALTER TABLE form.field_visit ADD COLUMN survey_name VARCHAR(40) DEFAULT 'TO BE CLASSIFIED';
ALTER TABLE form.field_visit
  ADD CONSTRAINT field_visit_survey_fkey
  FOREIGN KEY (survey_name)
  REFERENCES form.surveys(survey_name)
  ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS form.field_visit_vegetation (
  visit_id VARCHAR(30),
  visit_date date,
  VegType text,
  VegCategoryID int,
  ConfidenceID int,
  ThreatenedEcologicalCommunity text);
  ALTER TABLE form.field_visit_vegetation
    ADD CONSTRAINT field_visit_date_fkey
    FOREIGN KEY (visit_id,visit_date)
    REFERENCES form.field_visit(visit_id,visit_date)
    ON DELETE CASCADE ON UPDATE CASCADE;



CREATE TYPE vegvars AS ENUM ('tree canopy height', 'tree canopy scorch', 'tree canopy cover',
  'mid canopy height', 'mid canopy scorch', 'mid canopy cover',
  'shrub height', 'shrub scorch', 'shrub cover',
  'ground cover','ground burnt', 'tree foliage biomass consumed', 'shrub foliage biomass consumed', 'ground foliage biomass consumed',  'largest twigs consumed', 'peat cons+umption area', 'peat consumption max depth');

CREATE TABLE IF NOT EXISTS form.field_visit_vegetation_estimates (
  visit_id VARCHAR(30),
  visit_date date,
  measured_var vegvars,
  best numeric,
  lower numeric,
  upper numeric,
  CHECK (best >= lower AND best <= upper),


CREATE TABLE IF NOT EXISTS form.field_visit_vegetation_raw_values (
  visit_id VARCHAR(30),
  visit_date date,
  measured_variable vegvars,
  single_value numeric,
);

ALTER TABLE form.field_visit_vegetation
  ADD CONSTRAINT field_visit_date_fkey
  FOREIGN KEY (visit_id,visit_date)
  REFERENCES form.field_visit(visit_id,visit_date)
  ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO form.field_visit_vegetation
SELECT visit_id, visit_date, VegType, VegCategoryID, ConfidenceID, ThreatenedEcologicalCommunity,
  tree_canopy_height_best, tree_canopy_height_lower, tree_canopy_height_upper, tree_canopy_cover,
  tree_canopy_scorch_best, tree_canopy_scorch_lower, tree_canopy_scorch_upper,
  mid_canopy_height_best, mid_canopy_height_lower, mid_canopy_height_upper, mid_canopy_cover,
  mid_canopy_scorch_best, mid_canopy_scorch_lower, mid_canopy_scorch_upper,
  shrub_height_best, shrub_height_lower, shrub_height_upper, shrub_cover,
  shrub_scorch_best, shrub_scorch_lower, shrub_scorch_upper, ground_burnt_best,
  ground_burnt_lower, ground_burnt_upper, ground_cover,
  tree_foliage_biomass_consumed_best, tree_foliage_biomass_consumed_lower, tree_foliage_biomass_consumed_upper,
  shrub_foliage_biomass_consumed_best, shrub_foliage_biomass_consumed_lower, shrub_foliage_biomass_consumed_upper,
  ground_foliage_biomass_consumed_best, ground_foliage_biomass_consumed_lower, ground_foliage_biomass_consumed_upper,
  largest_twigs_consumed_best, largest_twigs_consumed_lower, largest_twigs_consumed_upper, largest_twigs_consumed_raw,
  peat_consumption_area, peat_consumption_maxdepth
  FROM form.old_field_visit;
--
-- Test tables:

CREATE TABLE IF NOT EXISTS form.fire_history (
visit_id VARCHAR(30) REFERENCES form.field_visit ON DELETE CASCADE,
fire_name varchar(100),
fire_date date,
fire_date_uncertain interval,
how_inferred varchar(100),
cause_of_ignition varchar(100),
PRIMARY KEY (visit_id, fire_date)
);


CREATE TABLE IF NOT EXISTS form.field_samples (
visit_id VARCHAR(30),
visit_date date,
sample_nr SMALLINT,
sample_method sampling_method,
quadrat_area numeric,
transect_length numeric,
comments text,
PRIMARY KEY (visit_id, sample_nr)
);

ALTER TABLE form.field_samples
  ADD CONSTRAINT field_samples_visit_id_fkey
  FOREIGN KEY (visit_id, visit_date)
  REFERENCES form.field_visit(visit_id,visit_date)
  ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS form.quadrat_samples (
visit_id VARCHAR(10),
visit_date date,
sample_nr SMALLINT,
species VARCHAR(255),
species_code int,
-- confidenceID int,
agegroup age_group,
resprout_organ resprout_type,
seedbank seedbank_type,
resprouts_live numeric,
resprouts_died numeric,
resprouts_kill numeric,
resprouts_reproductive numeric,
recruits_live numeric,
recruits_reproductive numeric,
recruits_died numeric,
comments text,
FOREIGN KEY (visit_id, visit_date,sample_nr) REFERENCES form.field_samples (visit_id,visit_date,sample_nr) ON DELETE CASCADE
);

ALTER TABLE form.quadrat_samples ADD column record_id SERIAL before visit_id;
ALTER TABLE  form.quadrat_samples ADD PRIMARY KEY (record_id);
ALTER TABLE  form.quadrat_samples DROP INDEX ix_quadrat;

ALTER TABLE form.quadrat_samples ALTER COLUMN visit_id TYPE varchar(30);

ALTER TABLE form.quadrat_samples
  DROP CONSTRAINT quadrat_samples_visit_id_fkey;
ALTER TABLE form.quadrat_samples
 ADD CONSTRAINT quadrat_samples_visit_id_fkey
 FOREIGN KEY (visit_id)
 REFERENCES form.field_visit(visit_id)
 ON DELETE CASCADE ON UPDATE CASCADE;

--CREATE PRIMARY KEY ix_quadrat ON form.quadrat_samples (record_id);
--CONSTRAINT rec_quadrat PRIMARY KEY(column_1, column_2,...);

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


CREATE TABLE IF NOT EXISTS litrev.traits(
   species VARCHAR(255),
   species_code int,
   resprouting resprouting_types,
   regenerative_organ resprout_organ,
   -- regenerative_organ text[],
   seedbank_type seedbank_type,
   postfire_seedling_recruitment post_seed_recruit,
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


-- https://epsg.io/28356
-- GDA94 / MGA zone 56
-- EPSG:28356
