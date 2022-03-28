-- Schema for storing information from the field (field forms)
CREATE SCHEMA litrev;


CREATE TYPE resprouting_vocabulary AS ENUM ('None','Few','Half','Most','All', 'Unknown');

CREATE TABLE IF NOT EXISTS litrev.surv1 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value resprouting_vocabulary,
  method_of_estimation method_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TYPE postfire_response AS ENUM ('Exclusive','Facultative','Negligible','Unknown');

CREATE TABLE IF NOT EXISTS litrev.repr2 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value postfire_response,
  method_of_estimation method_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TYPE establishment_vocabulary AS ENUM ('Intolerant', 'Intolerant-Tolerant', 'Tolerant', 'Tolerant-Requiring', 'Requiring', 'Unknown');
CREATE TABLE IF NOT EXISTS litrev.rect2 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value establishment_vocabulary,
  method_of_estimation method_vocabulary,
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
  method_of_estimation method_vocabulary,
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
  method_of_estimation method_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TYPE seed_dormancy_vocabulary AS ENUM ('PY','PD','PY-PD','MPD','MD','ND');


CREATE TABLE IF NOT EXISTS litrev.germ8 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  norm_value seed_dormancy_vocabulary,
  method_of_estimation method_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);
