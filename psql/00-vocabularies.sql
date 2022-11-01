-- Create controlled vocabularies for some variables:

-- used in form. and litrev. tables:

CREATE TYPE scorch_vocabulary AS ENUM ('Full canopy scorch','Partial scorch','Other');

CREATE TYPE sampling_method AS ENUM ('quadrat', 'transect', 'other');
CREATE TYPE resprout_organ AS ENUM ('epicormic', 'apical', 'lignotuber', 'basal','tuber','tussock','short rhizome', 'long rhizome or root sucker', 'stolon', 'none', 'other');
CREATE TYPE post_seed_recruit AS ENUM ('abundant','present','absent','other');

CREATE TYPE age_group AS ENUM ('adult','juvenile', 'other');

-- Create controlled vocabularies for some variables:
CREATE TYPE sampling_method AS ENUM ('quadrat', 'transect', 'other');
CREATE TYPE seedbank_type AS ENUM ('soil-persistent', 'transient', 'canopy','non-canopy','other');
CREATE TYPE post_seed_recruit AS ENUM ('abundant','present','absent','other');
CREATE TYPE seedbank_type AS ENUM ('soil-persistent', 'transient', 'canopy','non-canopy','other');
-- DROP TYPE seedbank_type CASCADE;
-- ALTER TYPE seedbank_type ADD VALUE 'non-canopy' AFTER 'canopy';
-- ALTER TYPE seedbank_type RENAME VALUE 'soil' TO 'soil-persistent';
-- \dT

CREATE TYPE yes_no_indet AS ENUM ('Yes','No','Indeterminate');
CREATE TYPE heat_smoke_interaction AS ENUM ('Additive/synergistic','Compensatory','Independent','Unknown');
CREATE TYPE months AS ENUM ('January','February','March','April','May','June','July', 'August', 'September', 'October', 'November', 'December')
--
CREATE TYPE method_vocabulary AS ENUM ('Direct measure', 'Qualitative estimate', 'Inferred from plant morphology', 'Unknown');

CREATE TYPE resprouting_types AS ENUM ('none','few','half','most','all', 'unknown');

-- Vocabularies for vegetation variables and variable units:
CREATE TYPE varunits AS ENUM('mm','cm','m','%');

CREATE TYPE vegvars AS ENUM (
  'tree canopy height', 'tree canopy scorch', 'tree canopy cover',
  'mid canopy height', 'mid canopy scorch', 'mid canopy cover',
  'shrub height', 'shrub scorch', 'shrub cover',
  'ground cover','ground burnt',
  'tree foliage biomass consumed', 'shrub foliage biomass consumed', 'ground foliage biomass consumed',
  'largest twigs consumed',
);

-- ALTER TYPE varunits ADD VALUE '%' AFTER 'm';
-- ALTER TYPE vegvars RENAME VALUE 'peat cons+umption area' TO 'peat consumption area';
ALTER TYPE vegvars ADD VALUE 'stratum E height';
ALTER TYPE vegvars ADD VALUE 'stratum E cover';
ALTER TYPE vegvars ADD VALUE 'stratum E scorch';

ALTER TYPE vegvars ADD VALUE 'stratum T height';
ALTER TYPE vegvars ADD VALUE 'stratum T cover';
ALTER TYPE vegvars ADD VALUE 'stratum T scorch';
ALTER TYPE vegvars ADD VALUE 'stratum T2 height';
ALTER TYPE vegvars ADD VALUE 'stratum T2 cover';
ALTER TYPE vegvars ADD VALUE 'stratum T2 scorch';
ALTER TYPE vegvars ADD VALUE 'stratum T1 height';
ALTER TYPE vegvars ADD VALUE 'stratum T1 cover';
ALTER TYPE vegvars ADD VALUE 'stratum T1 scorch';
ALTER TYPE vegvars ADD VALUE 'stratum M1 height';
ALTER TYPE vegvars ADD VALUE 'stratum M1 cover';
ALTER TYPE vegvars ADD VALUE 'stratum M1 scorch';
ALTER TYPE vegvars ADD VALUE 'stratum M2 height';
ALTER TYPE vegvars ADD VALUE 'stratum M2 cover';
ALTER TYPE vegvars ADD VALUE 'stratum M2 scorch';
ALTER TYPE vegvars ADD VALUE 'stratum L1 height';
ALTER TYPE vegvars ADD VALUE 'stratum L1 cover';
ALTER TYPE vegvars ADD VALUE 'stratum L1 scorch';
ALTER TYPE vegvars ADD VALUE 'stratum L2 height';
ALTER TYPE vegvars ADD VALUE 'stratum L2 cover';
ALTER TYPE vegvars ADD VALUE 'stratum L2 scorch';

ALTER TYPE vegvars ADD VALUE 'scorch height';
ALTER TYPE vegvars ADD VALUE 'tree foliage scorch';
ALTER TYPE vegvars ADD VALUE 'shrub foliage scorch';
ALTER TYPE vegvars ADD VALUE 'herb foliage scorch';
ALTER TYPE vegvars ADD VALUE 'twig diameter';


ALTER TYPE vegvars ADD VALUE 'twig diameter';
ALTER TYPE vegvars ADD VALUE 'peat depth burnt';
ALTER TYPE vegvars ADD VALUE 'peat extent burnt';
