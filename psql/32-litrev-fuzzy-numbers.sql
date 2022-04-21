-- Schema for storing information from the field (field forms)
CREATE SCHEMA litrev;

-- first flower production (primary juvenile period)
CREATE TABLE IF NOT EXISTS litrev.repr3 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  best int,
  lower int,
  upper int,
  method_of_estimation method_repr3_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  CHECK (best >= lower AND best <= upper),
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN litrev.repr3.best IS '{"years": "The time taken for first individual in a recruitment cohort to produce their first reproductive organs (e.g. flowers, sporophylls)"}';


-- first flower production (secondary juvenile period)

CREATE TABLE IF NOT EXISTS litrev.repr3a (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  best int,
  lower int,
  upper int,
  method_of_estimation method_repr3a_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  CHECK (best >= lower AND best <= upper),
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN litrev.repr3a.best IS '{"years": "The time taken after fire for first reproductive organs (e.g. flowers, sporophylls) to be produced in a population of resprouting individuals"}';


CREATE TABLE IF NOT EXISTS litrev.repr4 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  best int,
  lower int,
  upper int,
  method_of_estimation method_repr4_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  CHECK (best >= lower AND best <= upper),
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON COLUMN litrev.repr4.best IS '{"years": "The time taken for 50% of individuals in a cohort [even aged recruits] to produce their first viable seed"}';

CREATE TABLE IF NOT EXISTS litrev.grow1 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  best int,
  lower int,
  upper int,
  method_of_estimation method_grow1_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  CHECK (best >= lower AND best <= upper),
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON COLUMN litrev.grow1.best IS '{"years": "The time taken to develop organs or tissues enabling at least 50% of cohort survival when fully scorched in a fire"}';


CREATE TABLE IF NOT EXISTS litrev.surv5 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  best int,
  lower int,
  upper int,
  method_of_estimation method_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  CHECK (best >= lower AND best <= upper),
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN litrev.surv5.best IS '{"years": "Age at which 50% of individuals in a cohort (excluding outliers) have died from senescence"}';

CREATE TABLE IF NOT EXISTS litrev.surv6 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  best int,
  lower int,
  upper int,
  method_of_estimation method_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  CHECK (best >= lower AND best <= upper),
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);


COMMENT ON COLUMN litrev.surv6.best IS '{"years": "Age at which 50% of a seed cohort in an in situ seedbank have decayed or become inviable"}';


CREATE TABLE IF NOT EXISTS litrev.surv7 (
  record_id SERIAL PRIMARY KEY,
  species VARCHAR(255),
  species_code VARCHAR(10),
  main_source VARCHAR(50) ,
  original_sources text[],
  best int,
  lower int,
  upper int,
  method_of_estimation method_vocabulary,
  raw_value text[],
  original_notes text[],
  additional_notes text[],
  weight smallint NOT NULL DEFAULT 1,
  weight_notes text[],
  CHECK (best >= lower AND best <= upper),
  FOREIGN KEY (main_source) REFERENCES litrev.ref_list (ref_code) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON COLUMN litrev.surv7.best IS '{"years": "Age at which all seeds in a cohort (excluding outliers, e.g. 95th percentile) have decayed or become inviable"}';
