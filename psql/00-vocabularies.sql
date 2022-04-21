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
