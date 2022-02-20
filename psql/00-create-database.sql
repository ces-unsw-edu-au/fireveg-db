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
  ThreatenedEcologicalCommunity text,
  PRIMARY KEY (visit_id,visit_date)
);
  ALTER TABLE form.field_visit_vegetation
    ADD CONSTRAINT field_visit_date_fkey
    FOREIGN KEY (visit_id,visit_date)
    REFERENCES form.field_visit(visit_id,visit_date)
    ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TYPE vegvars AS ENUM ('tree canopy height', 'tree canopy scorch', 'tree canopy cover',
  'mid canopy height', 'mid canopy scorch', 'mid canopy cover',
  'shrub height', 'shrub scorch', 'shrub cover',
  'ground cover','ground burnt', 'tree foliage biomass consumed', 'shrub foliage biomass consumed', 'ground foliage biomass consumed',  'largest twigs consumed', 'peat cons+umption area', 'peat consumption max depth');
  CREATE TYPE varunits AS ENUM('mm','cm','m');
  -- ALTER TYPE varunits ADD VALUE '%' AFTER 'm';
ALTER TYPE vegvars RENAME VALUE 'peat cons+umption area' TO 'peat consumption area';

CREATE TABLE IF NOT EXISTS form.field_visit_vegetation_estimates (
  visit_id VARCHAR(30),
  visit_date date,
  measured_var vegvars,
  units varunits,
  best numeric,
  lower numeric,
  upper numeric,
  CHECK (best >= lower AND best <= upper),
  PRIMARY KEY (visit_id,visit_date,measured_var)
);
  ALTER TABLE form.field_visit_vegetation_estimates
    ADD CONSTRAINT field_visit_date_fkey
    FOREIGN KEY (visit_id,visit_date)
    REFERENCES form.field_visit(visit_id,visit_date)
    ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS form.field_visit_vegetation_raw_values (
  visit_id VARCHAR(30),
  visit_date date,
  measured_variable vegvars,
  units varunits,
  single_value numeric
);

ALTER TABLE form.field_visit_vegetation_raw_values
  ADD CONSTRAINT field_visit_date_fkey
  FOREIGN KEY (visit_id,visit_date)
  REFERENCES form.field_visit(visit_id,visit_date)
  ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS form.fire_history (
visit_id VARCHAR(30) REFERENCES form.field_visit ON DELETE CASCADE,
fire_name varchar(100),
fire_date date,
fire_date_uncertain interval,
how_inferred varchar(100),
cause_of_ignition varchar(100),
PRIMARY KEY (visit_id, fire_date)
);

-- ALTER TABLE form.field_samples RENAME TO old_field_samples;
CREATE TABLE IF NOT EXISTS form.field_samples (
visit_id VARCHAR(30),
visit_date date,
sample_nr SMALLINT,
sample_method sampling_method,
quadrat_area numeric,
transect_length numeric,
comments text,
PRIMARY KEY (visit_id, visit_date, sample_nr)
);

ALTER TABLE form.field_samples
  ADD CONSTRAINT field_samples_visit_id_fkey
  FOREIGN KEY (visit_id, visit_date)
  REFERENCES form.field_visit(visit_id,visit_date)
  ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE IF NOT EXISTS form.quadrat_samples (
  record_id SERIAL PRIMARY KEY,
visit_id VARCHAR(30),
visit_date date,
sample_nr SMALLINT,
species VARCHAR(255),
species_code int,
species_notes text,
-- confidenceID int,
resprout_organ resprout_type,
seedbank seedbank_type,
adults_unburnt numeric,
resprouts_live numeric,
resprouts_died numeric,
resprouts_kill numeric,
resprouts_reproductive numeric,
recruits_live numeric,
recruits_reproductive numeric,
recruits_died numeric,
comments text,
FOREIGN KEY (visit_id, visit_date, sample_nr) REFERENCES form.field_samples (visit_id,visit_date, sample_nr) ON DELETE CASCADE ON UPDATE CASCADE
);
