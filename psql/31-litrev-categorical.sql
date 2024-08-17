-- Schema for storing information from the field (field forms)

-- SELECT pg_catalog.obj_description(t.oid, 'pg_type')::json->>'Few' from pg_type t where typname = 'resprouting_vocabulary';

CREATE TABLE IF NOT EXISTS litrev.surv1 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value resprouting_vocabulary,
  method_of_estimation method_surv1_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS litrev.repr2 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value postfire_response,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS litrev.rect2 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value establishment_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS litrev.germ1 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value seedbank_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS litrev.surv4 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value resprout_organ_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS litrev.germ8 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value seed_dormancy_vocabulary,
  method_of_estimation method_germ8_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE IF NOT EXISTS litrev.disp1 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value propagule_dispersal_vocabulary,
  method_of_estimation method_disp1_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);
