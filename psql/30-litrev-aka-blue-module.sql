-- Schema for storing information from the field (field forms)
CREATE SCHEMA litrev;

CREATE TABLE IF NOT EXISTS litrev.ref_list (
    ref_code varchar(50) PRIMARY KEY,
    ref_cite text,
    alt_code varchar(30)
);

CREATE TABLE litrev.trait_info (
  code VARCHAR(10) PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  value_type VARCHAR(30),
  life_stage VARCHAR(30),
  life_history_process VARCHAR(30),
  priority VARCHAR(30),
  category_vocabulary VARCHAR(30),
  method_vocabulary  VARCHAR(30)
);

INSERT INTO litrev.trait_info (code,name,value_type,description,life_stage,life_history_process,priority) VALUES
-- Trait code	Trait name	Trait type	Description	Life stage	Life history process	priority
('surv1','Resprouting - full canopy scorch','categorical', 'Ordinal categories of survival and resprouting proportions for plants subjected to 100% canopy scorch', 'Standing plant', 'Survival', '3rd tranche'),
('surv4', 'Regenerative Organ', 'categorical', NULL, 'Standing plant', 'Survival', '3rd tranche'),
('surv5', 'Standing plant longevity (Max)', 'numerical', 'Age at which 50% of individuals in a cohort (excluding outliers) have died from senescence', 'Standing plant', 'Survival', '3rd tranche'),
('surv6', 'Seedbank half-life', 'numerical', 'Age at which 50% of a seed cohort in an in situ seedbank have decayed or become inviable', 'Seed', 'Survival', '3rd tranche'),
('surv7', 'Seed longevity', 'numerical', 'Age at which all seeds in a cohort (excluding outliers, e.g. 95th percentile) have decayed or become inviable', 'Seed', 'Survival', '3rd tranche'),
('grow1', 'Age to develop regenerative/resistance organs', 'numerical', 'The time taken to develop organs or tissues enabling at least 50% of cohort survival when fully scorched in a fire', 'Standing plant', 'Growth', '2nd tranche'),

('repr2', 'Post-fire flowering response', 'categorical', NULL, 'Standing plant', 'Reproduction', '2nd tranche'),
('repr3', 'Age at first flower production (from seed)', 'numerical', 'The time taken for first individual in a recruitment cohort to produce their first reproductive organs (e.g. flowers, sporophylls)', 'Standing plant', 'Reproduction', '1st tranche'),

('repr3a', 'Time to first postfire reproduction (from resprouts)', 'numerical', 'The time taken after fire for first reproductive organs (e.g. flowers, sporophylls) to be produced in a population of resprouting individuals', 'Standing plant', 'Reproduction', '3rd tranche'),
('repr4', 'Maturation age', 'numerical', 'The time taken for 50% of individuals in a cohort [even aged recruits] to produce their first viable seed', 'Standing plant', 'Reproduction', '1st tranche'),
('germ1', 'Seedbank Type', 'categorical', NULL, 'Seed', 'Germination', '2nd tranche'),
('germ8', 'Seed dormancy type', 'categorical', NULL, 'Seed', 'Germination', '1st tranche'),
('rect2', 'Establishment pattern', 'categorical', 'The temporal pattern of seedling or clonal establishment through the fire cycle', 'Seedling', 'Recruitment', '3rd tranche')
ON CONFLICT ON CONSTRAINT trait_info_pkey DO UPDATE set name=EXCLUDED.name, description=EXCLUDED.description;

INSERT INTO litrev.trait_info (code,name,value_type,description,life_stage,life_history_process) VALUES
('surv2', 'Basal scorch response (scorch height < 50% of plant height)', 'TO DO', 'Non-ordinal categories of survival response for plants subjected to basal scorch', 'Standing plant', 'Survival'),
('surv3', 'Survival - basal scorch', 'TO DO', 'Ordinal categories of survival and resprouting proportions for plants subjected to LESS THAN 100% canopy scorch', 'Standing plant', 'Survival'),
('grow2', 'Age to reach maximum growth stage', 'TO DO', 'Age of a cohort at which 50% of individuals reach their maximum growth stage', 'Standing plant', 'Growth'),

('grow2a', 'Maximum growth stage', 'text', 'Taxon-specific definition of maximum growth stage (e.g. specify a minimum plant height, canopy diam. organ development (e.g. rhizome), dbh, presence of hollows, etc.)', 'Standing plant', 'Growth'),
('grow3', 'Maximum bark thickness', 'numeric', 'Maximum bark thickness [mm]', 'Standing plant', 'Growth'),
('grow4', 'Maximum plant height', 'numeric', 'Maximum plant height [m]', 'Standing plant', 'Growth'),
('repr1', 'Flowering time', 'TBA', 'Earliest (1st decile of individuals) and latest (10th decile of individuals) month flowering was observed', 'Standing plant', 'Reproduction'),
('repr5', 'Age at maximum seed production', 'numeric', 'Age of a cohort at which seed production reaches a peak, before declining with age', 'Standing plant', 'Reproduction'),
('repr6', 'Age of maximum seed bank size', 'numeric', 'Age of a cohort at which the accumulated seedbank reaches a peak (usually derived from models of seedbank dynamics)', 'Standing plant', 'Reproduction'),
('repr7a', 'Resprout flowering response to summer fire', 'TBA', 'Proportion of surviving resprouting individuals that produce a seed/spore crop within the first five years after a summer (Dec-Feb sth hemisphere) fire', 'Standing plant', 'Reproduction'),
('repr7b', 'Flowering response to autumn fire', 'TBA', 'Proportion of surviving resprouting individuals that produce a seed/spore crop within the first five years after an autumn (Mar-May sth hemisphere) fire', 'Standing plant', 'Reproduction'),
('repr7c', 'Flowering response to winter fire', 'TBA', 'Proportion of surviving resprouting individuals that produce a seed/spore crop within the first five years after a winter (Jun-Aug sth hemisphere) fire', 'Standing plant', 'Reproduction'),
('repr7d', 'Flowering response to spring fire', 'TBA', 'Proportion of surviving resprouting individuals that produce a seed/spore crop within the first five years after a winter (Jun-Aug sth hemisphere) fire', 'Standing plant', 'Reproduction'),

('germ2', 'Heat-pulse-cued germination', 'categorical','Germination response to heat pulse', 'Seed', 'Germination'),
('germ3', 'Smoke-cued germination', 'categorical', 'Germination response to smoke treatments', 'Seed', 'Germination'),
('germ4', 'Heat shock-smoke interactive germination cue', 'categorical', 'Germination response to combined heat and smoke treatments', 'Seed', 'Germination'),
('germ5', 'H50', 'numerical', 'Minimum temperature of heat pulse (exposure time up to 10 mins) producing 50% germination from viable fraction', 'Seed', 'Germination'),
('germ6', 'H-max', 'numerical', 'Temperature of heat pulse (exposure time up to 10 mins) producing maximum % germination from dormant fraction', 'Seed', 'Germination'),
('germ7', 'H-lethal', 'numerical', 'Minimum temperature of heat pulse (exposure time up to 10 mins) at which all seeds are killed', 'Seed', 'Germination'),
('germ9', 'TBA', 'TBA','TBA','Seed', 'Germination'),

('rect1', 'Postfire seedling recruitment', 'categorical', 'The observed incidence of post-fire (within first 5 years after fire) seedling recruitment', 'Seedling', 'Recruitment'),
('rect3', 'Seedling emergence phenology', 'categorical', 'The  month(s) of seedling emergence event. Enter either: i) square brackets with comma-separated first month, peak month and last month of seedling emergence event; or ii) single month of observed emergence if first, peak & last unknown)', 'Seedling', 'Recruitment'),
('rect3a', 'Seedling emergence phenology - rainfall context', 'categorical', 'Occurrence of significant dry spell (>3 months with <10 mm in any week) during the period between fire and seedling emergence', 'Seedling', 'Recruitment'),
('disp1', 'Propagule dispersal mode', 'categorical', 'Propagule dispersal mode', 'Seed', 'Dispersal')
ON CONFLICT ON CONSTRAINT trait_info_pkey DO UPDATE set name=EXCLUDED.name, description=EXCLUDED.description, value_type=EXCLUDED.value_type;


INSERT INTO litrev.trait_info (code,name,value_type,life_stage,life_history_process) VALUES
('germ10', 'Postfire residual seedbank', 'categorical','Seed', 'Germination') ON CONFLICT DO NOTHING;

UPDATE litrev.trait_info set category_vocabulary = 'resprouting_vocabulary' WHERE code='surv1';
UPDATE litrev.trait_info set category_vocabulary = 'resprout_organ_vocabulary' WHERE code='surv4';
UPDATE litrev.trait_info set category_vocabulary = 'postfire_response' WHERE code='repr2';
UPDATE litrev.trait_info set category_vocabulary = 'establishment_vocabulary' WHERE code='rect2';
UPDATE litrev.trait_info set category_vocabulary = 'seedbank_vocabulary' WHERE code='germ1';
UPDATE litrev.trait_info set category_vocabulary = 'seed_dormancy_vocabulary' WHERE code='germ8';

UPDATE litrev.trait_info set method_vocabulary = 'method_surv1_vocabulary' WHERE code='surv1';
UPDATE litrev.trait_info set method_vocabulary = 'method_surv2_vocabulary' WHERE code='surv2';
UPDATE litrev.trait_info set method_vocabulary = 'method_surv3_vocabulary' WHERE code='surv3';
UPDATE litrev.trait_info set method_vocabulary = 'method_grow1_vocabulary' WHERE code='grow1';
UPDATE litrev.trait_info set method_vocabulary = 'method_grow2_vocabulary' WHERE code='grow2';

UPDATE litrev.trait_info set method_vocabulary = 'method_repr3_vocabulary' WHERE code='repr3';
UPDATE litrev.trait_info set method_vocabulary = 'method_repr3a_vocabulary' WHERE code='repr3a';
UPDATE litrev.trait_info set method_vocabulary = 'method_repr4_vocabulary' WHERE code='repr4';


UPDATE litrev.trait_info set method_vocabulary = 'method_germ8_vocabulary' WHERE code='germ8';

UPDATE litrev.trait_info set method_vocabulary = 'method_rect3_vocabulary' WHERE code='rect3';


UPDATE litrev.trait_info set method_vocabulary = 'method_disp1_vocabulary' WHERE code='disp1';


update litrev.trait_info set value_type='categorical',priority='needed for VA group',category_vocabulary='propagule_dispersal_vocabulary' WHERE code='disp1'
;

-- CREATE TABLE IF NOT EXISTS litrev.nsw_status (
-- species VARCHAR(255),
-- species_code int PRIMARY KEY,
-- common_name VARCHAR(255),
-- nsw_status varchar(50),
-- source text,
-- access_date DATE
-- );
--
-- --ALTER TABLE litrev.nsw_status   ADD CONSTRAINT nsw_status_code_fkey  FOREIGN KEY (species_code)  REFERENCES ...(...)  ON DELETE CASCADE ON UPDATE CASCADE;
