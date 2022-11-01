-- Schema for storing information from the field (field forms)
CREATE SCHEMA form;

-- This was originally copied from tblObserver of Atlas data model, but we just need a core of columns
CREATE TABLE IF NOT EXISTS form.observerID (
UserKey SERIAL PRIMARY KEY,
GivenNames varchar(60) NULL,
Surname varchar(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS form.field_site (
site_label VARCHAR(30) ,
location_description text,
geom geometry,
gps_uncertainty_m int,
gps_geom_description text,
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


CREATE TABLE IF NOT EXISTS form.field_visit (
visit_id VARCHAR(30),
visit_date date,
replicate_nr smallint,
visit_description text,
mainObserver INT REFERENCES form.observerID ON DELETE RESTRICT,
observerlist text[],
survey_name VARCHAR(40) DEFAULT 'TO BE CLASSIFIED',
PRIMARY KEY (visit_id,visit_date)
);

ALTER TABLE form.field_visit
  ADD CONSTRAINT field_visit_survey_fkey
  FOREIGN KEY (survey_name)
  REFERENCES form.surveys(survey_name)
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE form.field_visit ADD CONSTRAINT field_visit_mainobserver_fkey2 FOREIGN KEY (mainobserver) REFERENCES form.observerid(userkey) ON DELETE RESTRICT


CREATE TABLE IF NOT EXISTS form.fire_history (
site_label VARCHAR(30) REFERENCES form.field_site ON DELETE CASCADE,
fire_name varchar(100),
fire_date VARCHAR(30),
earliest_date date,
latest_date date,
how_inferred varchar(100),
cause_of_ignition varchar(100),
notes text[],
PRIMARY KEY (site_label, fire_date)
);

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
  resprout_organ resprout_organ_vocabulary,
  seedbank seedbank_vocabulary, -- updated, capital values
  adults_unburnt numeric,
  resprouts_live numeric,
  resprouts_died numeric,
  resprouts_kill numeric,
  resprouts_reproductive numeric,
  recruits_live numeric,
  recruits_reproductive numeric,
  recruits_died numeric,
  scorch scorch_vocabulary,
  life_stage age_group,
  comments text[],
  FOREIGN KEY (visit_id, visit_date, sample_nr) REFERENCES form.field_samples (visit_id,visit_date, sample_nr) ON DELETE CASCADE ON UPDATE CASCADE
);
