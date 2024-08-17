-- Create controlled vocabularies for some variables
-- used in form. and litrev. tables:

CREATE TYPE scorch_vocabulary AS ENUM ('Full canopy scorch','Partial scorch','Other');
CREATE TYPE sampling_method AS ENUM ('quadrat', 'transect', 'other');
CREATE TYPE post_seed_recruit AS ENUM ('abundant','present','absent','other');
CREATE TYPE age_group AS ENUM ('adult','juvenile', 'other');
CREATE TYPE yes_no_indet AS ENUM ('Yes','No','Indeterminate');
CREATE TYPE heat_smoke_interaction AS ENUM ('Additive/synergistic','Compensatory','Independent','Unknown');
CREATE TYPE months AS ENUM ('January','February','March','April','May','June','July', 'August', 'September', 'October', 'November', 'December');

-- Vocabularies for vegetation variables and variable units:
CREATE TYPE varunits AS ENUM('mm','cm','m','%');
CREATE TYPE vegvars AS ENUM (
  'tree canopy height', 'tree canopy scorch', 'tree canopy cover',
  'mid canopy height', 'mid canopy scorch', 'mid canopy cover',
  'shrub height', 'shrub scorch', 'shrub cover',
  'ground cover','ground burnt',
  'tree foliage biomass consumed', 'shrub foliage biomass consumed', 'ground foliage biomass consumed',
  'largest twigs consumed',
  'stratum E height', 'stratum E cover', 'stratum E scorch',
  'stratum T height', 'stratum T cover', 'stratum T scorch',
  'stratum T1 height', 'stratum T1 cover', 'stratum T1 scorch',
  'stratum T2 height', 'stratum T2 cover', 'stratum T2 scorch',
  'stratum M1 height', 'stratum M1 cover', 'stratum M1 scorch',
  'stratum M2 height', 'stratum M2 cover', 'stratum M2 scorch',
  'stratum L1 height', 'stratum L1 cover', 'stratum L1 scorch',
  'stratum L2 height', 'stratum L2 cover', 'stratum L2 scorch',
  'scorch height', 'tree foliage scorch', 
  'shrub foliage scorch', 'herb foliage scorch',
  'twig diameter', 'peat depth burnt',
  'peat extent burnt'
);

-- Create controlled vocabularies for some variables:
-- CREATE TYPE ... AS ENUM (...);
-- DROP TYPE ... CASCADE;
-- ALTER TYPE ... ADD VALUE ... AFTER ...;
-- ALTER TYPE ... RENAME VALUE ... TO ...;
-- Or show all types with:
-- \dT
