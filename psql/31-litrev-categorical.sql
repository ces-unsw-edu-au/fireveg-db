-- Schema for storing information from the field (field forms)


CREATE TYPE resprouting_vocabulary AS ENUM ('None','Few','Half','Most','All', 'Unknown');
COMMENT ON TYPE resprouting_vocabulary IS '{"None":	"< 5 % individuals in a population resprout after 100% canopy scorch",
"Few":	"> 5 and < 30 % individuals in a population resprout after 100% canopy scorch",
"Half":	"> 30 and < 70 % individuals in a population resprout after 100% canopy scorch",
"Most":	"> 70 and < 90 % individuals in a population resprout after 100% canopy scorch",
"All":	"> 90 % individuals in a population resprout after 100% canopy scorch",
"Unknown":	"No data"}';

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

CREATE TYPE postfire_response AS ENUM ('Exclusive','Facultative','Negligible','Unknown');
COMMENT ON TYPE postfire_response IS '{
"Exclusive":	"Flowering occurs exclusively in the first 5 years after fire (excluding outliers, e.g roadsides)",
"Facultative":	"Flowering occurs most prolifically in the first 5 years after fire",
"Negligible":	"Flowering similar or variable throughout the fire cycle",
"Unknown":	"No data"}';

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

CREATE TYPE establishment_vocabulary AS ENUM ('Intolerant', 'Intolerant-Tolerant', 'Tolerant', 'Tolerant-Requiring', 'Requiring', 'Unknown');
COMMENT ON TYPE establishment_vocabulary IS
'{"Intolerant":	"I- intolerant of conditions in established communities (i.e. unburnt for some years) and largely restricted to early post-fire years (open conditions, notionally within 5 yrs of previous fire). See Noble & Slatyer (1980, Vegetatio)",
"Intolerant-Tolerant":	"I/T- intolerant or tolerant of conditions in established communities (i.e. unburnt for some years) , variable or uncertain. See Noble & Slatyer (1980, Vegetatio)",
"Tolerant":	"T- tolerant of conditions through the fire cycle (i.e. new recruits observed in both burnt and unburnt sites). See Noble & Slatyer (1980, Vegetatio)",
"Tolerant-Requiring":	"T/R- tolerant or requiring of conditions in established communities, uncertain or variable. See Noble & Slatyer (1980, Vegetatio)",
"Requiring":	"R- requiring of of conditions in established communities (i.e. new recruits only observed at sites unburnt for some years). See Noble & Slatyer (1980, Vegetatio)",
"Unknown":	"No data"}';

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

CREATE TYPE seedbank_vocabulary AS ENUM ('Soil-persistent', 'Transient', 'Canopy','Non-canopy','Other');

COMMENT ON TYPE seedbank_vocabulary IS
'{"Canopy": "Seeds withheld for >1yr within woody fruits in the plant canopy that release seeds when scorched",
"Soil-persistent": "Seeds released at maturity with a fraction (min 10%) remaining viable in the soil for >1yr",
"Transient": "Seeds released from woody or fleshy fruits at maturity with a negligible fraction (max 1%) remaining viable in the soil for >1yr",
"Non-canopy": "Seedbanks uncertain but not canopy type (either Soil-persistent or Transient seedbank type)"}';

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

CREATE TYPE resprout_organ_vocabulary AS ENUM ('Epicormic', 'Apical', 'Lignotuber', 'Basal','Tuber','Tussock','Short rhizome', 'Long rhizome or root sucker', 'Stolon', 'None', 'Other');

COMMENT ON TYPE resprout_organ_vocabulary IS
'{"Epicormic":	"Resprouting from epicormic meristematic tissues or buds beneath bark on woody aerial stems",
"Apical":	"Resprouting from active shoots protected by crowded leaf bases on woody stems",
"Lignotuber":	"Resprouting from meristematic tissues or buds on lignotubers (swollen woody organ) at or just below the soil surface",
"Basal":	"Resprouting from meristematic tissues or buds at the base of woody stems at or just below the soil surface",
"Tuber":	"Resprouting from non-woody nodular subsoil organs (bulbs, corms, tubers, taproots) with active shoots or dormant buds",
"Tussock":	"Shoots protected and resprouting within tightly clustered tillers and resprouting  without significant lateral spread",
"Long rhizome or root sucker":	"Resprouting from buried woody or non-woody horizontal organs capable of lateral spread, typically >0.5m. Includes root suckers.",
"Short rhizome":	"Resprouting from buried woody or non-woody horizontal organs, but not capable of significant lateral spread, typically <0.5m.",
"Stolon":	"Resprouting from non-woody horizontal organs on or just below the soil surface",
"None":	"No vegetative recovery - killed by fire"}';

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

CREATE TYPE seed_dormancy_vocabulary AS ENUM ('PY','PD','PY-PD','MPD','MD','ND');

COMMENT ON TYPE seed_dormancy_vocabulary IS
'{"PY":	"Physical dormancy (PY) is caused by a water-impermeable seed coat. Typically overcome by scarification, fire-related heat pulse and/or high temperatures",
"PD":	"Physiological dormancy (PD) is caused by a chemical or physiological block within the seed, driven by the balance between the growth inhibiting and growth promoting hormones ABA and GA. It is overcome by cold or warm stratification or dry after-ripening, environmental conditions which are experienced after seed dispersal over the seasons. Often related to having seasonal germination cues",
"PY-PD":	"A combination of physical dormancy (PY) and physiological dormancy (PD) (see definitions above). Both forms of dormancy must be overcome for germination to result.",
"MPD":	"A combination of morphological dormancy (MD), caused by an underdeveloped embryo, and physiological dormancy (PD) (see definition above). Both forms of dormancy must be overcome for germination to result, with both dormancy types potentially broken down under the same environmental conditions.",
"MD":	"Morphological dormancy (MD) is caused by an underdeveloped embryo in seeds that do not have physiological dormancy (PD). Embryos need to grow to the full length of the seed before germination can occur, so this embryo growth period delays germination.",
"ND":	"Non-dormant (ND) species are able to germinate upon release, across a wide range of environmental conditions."}';

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

CREATE TYPE propagule_dispersal_vocabulary AS ENUM ('wind-hairs','wind-wing', 'wind-unspec.','animal-ingestion','animal-cohesion', 'animal-unspec.', 'ant', 'water', 'ballistic', 'passive', 'other');

COMMENT ON TYPE propagule_dispersal_vocabulary IS
'{"wind-hairs":	"Diaspores with wings large enough to significantly reduce terminal velocity",
"wind-wing":	"Diaspores with hairs long and dense enough to significantly reduce terminal velocity",
"wind-unspec.": "Wind dispersal by unspecified mechanism",
"animal-ingestion":	"Diaspores with fleshy pericarp ingestable by vertebrates",
"animal-cohesion": "Diaspores with external structures/substances promoting adhesion to vertebrate fur/feathers by vertebrates",
"animal-unspec.":	"Animal dispersal by unspecified mechanism",
"ant":	"Diaspores with elaiosome (various structures including epicarp) harvested by ants",
"water":	"Buoyancy in water (e.g. >24 hrs). Primarily relevant to species in riparian, floodplain or littoral habitats (buoyancy/saltation in sheet flow interpreted as ''passive'' dispersal",
"ballistic":	"Diaspores with explosive release from parent plant",
"passive":	"Diaspores with no specialised structures for dispersal",
"other": "Other"}';

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
