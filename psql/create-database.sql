
CREATE TABLE IF NOT EXISTS form.field_visit (
visit_id VARCHAR(10) ,
visit_date date,
visit_description text,
location_description text,
geom geometry,
elevation numeric,
VegType text,
VegCategoryID int,
ConfidenceID int,
ThreatenedEcologicalCommunity text,
mainObserver INT REFERENCES form.observerID ON DELETE RESTRICT,
otherObserver VARCHAR(20),
tree_canopy_height_best numeric,
tree_canopy_height_lower numeric,
tree_canopy_height_upper numeric,
tree_canopy_cover numeric,
tree_canopy_scorch_best numeric,
tree_canopy_scorch_lower numeric,
tree_canopy_scorch_upper numeric,
CHECK (tree_canopy_height_best >= tree_canopy_height_lower AND tree_canopy_height_best <= tree_canopy_height_upper),
CHECK (tree_canopy_scorch_best >= tree_canopy_scorch_lower AND tree_canopy_scorch_best <= tree_canopy_scorch_upper),
CHECK (tree_canopy_scorch_upper  <= tree_canopy_height_upper),
mid_canopy_height_best numeric,
mid_canopy_height_lower numeric,
mid_canopy_height_upper numeric,
mid_canopy_cover numeric,
mid_canopy_scorch_best numeric,
mid_canopy_scorch_lower numeric,
mid_canopy_scorch_upper numeric,
CHECK (mid_canopy_height_best >= mid_canopy_height_lower AND mid_canopy_height_best <= mid_canopy_height_upper),
CHECK (mid_canopy_scorch_best >= mid_canopy_scorch_lower AND mid_canopy_scorch_best <= mid_canopy_scorch_upper),
CHECK (mid_canopy_scorch_upper  <= mid_canopy_height_upper),
shrub_height_best numeric,
shrub_height_lower numeric,
shrub_height_upper numeric,
shrub_cover numeric,
shrub_scorch_best numeric,
shrub_scorch_lower numeric,
shrub_scorch_upper numeric,
CHECK (shrub_height_best >= shrub_height_lower AND shrub_height_best <= shrub_height_upper),
CHECK (shrub_scorch_best >= shrub_scorch_lower AND shrub_scorch_best <= shrub_scorch_upper),
CHECK (shrub_scorch_upper  <= shrub_height_upper),
ground_burnt_best numeric,
ground_burnt_lower numeric,
ground_burnt_upper numeric,
ground_cover numeric,
CHECK (ground_burnt_best >= ground_burnt_lower AND ground_burnt_best <= ground_burnt_upper),
tree_foliage_biomass_consumed_best numeric,
tree_foliage_biomass_consumed_lower numeric,
tree_foliage_biomass_consumed_upper numeric,
CHECK (tree_foliage_biomass_consumed_best >= tree_foliage_biomass_consumed_lower AND tree_foliage_biomass_consumed_best <= tree_foliage_biomass_consumed_upper),
shrub_foliage_biomass_consumed_best numeric,
shrub_foliage_biomass_consumed_lower numeric,
shrub_foliage_biomass_consumed_upper numeric,
CHECK (shrub_foliage_biomass_consumed_best >= shrub_foliage_biomass_consumed_lower AND shrub_foliage_biomass_consumed_best <= shrub_foliage_biomass_consumed_upper),
ground_foliage_biomass_consumed_best numeric,
ground_foliage_biomass_consumed_lower numeric,
ground_foliage_biomass_consumed_upper numeric,
CHECK (ground_foliage_biomass_consumed_best >= ground_foliage_biomass_consumed_lower AND ground_foliage_biomass_consumed_best <= ground_foliage_biomass_consumed_upper),
largest_twigs_consumed_best numeric,
largest_twigs_consumed_lower numeric,
largest_twigs_consumed_upper numeric,
largest_twigs_consumed_raw varchar(255),
CHECK (largest_twigs_consumed_best >= largest_twigs_consumed_lower AND largest_twigs_consumed_best <= largest_twigs_consumed_upper),
peat_consumption_area numeric,
peat_consumption_maxdepth numeric,
CreatedBySystemUserID int NOT NULL,
DateCreated timestamp NOT NULL,
UpdatedBySystemUserID int NOT NULL,
DateUpdated timestamp NOT NULL,
PRIMARY KEY (visit_id)

);

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

--
-- Test tables:

CREATE TABLE IF NOT EXISTS form.fire_history (
visit_id VARCHAR(10) REFERENCES form.field_visit ON DELETE CASCADE,
fire_name varchar(100),
fire_date date,
fire_date_uncertain interval,
how_inferred varchar(100),
cause_of_ignition varchar(100),
PRIMARY KEY (visit_id, fire_date)
);

CREATE TYPE sampling_method AS ENUM ('quadrat', 'transect', 'other');
CREATE TABLE IF NOT EXISTS form.field_samples (
visit_id VARCHAR(10) REFERENCES form.field_visit ON DELETE CASCADE,
sample_nr SMALLINT,
sample_method sampling_method,
quadrat_area numeric,
transect_length numeric,
comments text,
PRIMARY KEY (visit_id, sample_nr)
);

CREATE TYPE resprout_type AS ENUM ('epicormic', 'ligno', 'crown','basal','tuber','rhizoma','stolon', 'none', 'other');
CREATE TYPE seedbank_type AS ENUM ('soil-persistent', 'transient', 'canopy','non-canopy','other');
-- DROP TYPE seedbank_type CASCADE;
-- ALTER TYPE seedbank_type ADD VALUE 'non-canopy' AFTER 'canopy';
-- ALTER TYPE seedbank_type RENAME VALUE 'soil' TO 'soil-persistent';
-- \dT
CREATE TYPE age_group AS ENUM ('adult','juvenile', 'other');

CREATE TABLE IF NOT EXISTS form.quadrat_samples (
visit_id VARCHAR(10),
sample_nr SMALLINT,
species VARCHAR(255),
species_code int,
-- confidenceID int,
agegroup age_group,
resprout_organ resprout_type,
seedbank seedbank_type,
resprouts_live numeric,
resprouts_died numeric,
resprouts_kill numeric,
resprouts_reproductive numeric,
recruits_live numeric,
recruits_reproductive numeric,
recruits_died numeric,
comments text,
FOREIGN KEY (visit_id, sample_nr) REFERENCES form.field_samples (visit_id,sample_nr) ON DELETE CASCADE
);




--
-- old/bad code:


CREATE TABLE IF NOT EXISTS form.field_visit (
visit_id VARCHAR(10),
visit_date date,
visit_description text,
observer INT REFERENCES form.observerID ON DELETE RESTRICT,
CreatedBySystemUserID int NOT NULL,
DateCreated timestamp NOT NULL,
UpdatedBySystemUserID int NOT NULL,
DateUpdated timestamp NOT NULL,
 PRIMARY KEY (visit_id)
);

CREATE TABLE IF NOT EXISTS field_sample (
fsid BIGINT PRIMARY KEY,
sample_date datetime,
location text,
xy geometry(Point),
site_description text,
method_inference text,
pct text
);

CREATE TABLE IF NOT EXISTS fire_event (
fsid BIGINT PRIMARY KEY,
date_fire date,
tree_canopy_height int,
tree_foliage_consumed int,
tree_foliage_scorch_height int,
shrub_height
shrub_foliage_consumed int,
shrub_foliage_scorch_height int,
smallest_burnt_twigs
groundlayer_scorched
peat_consumption
ignition_source
how_inferred
);

CREATE TABLE IF NOT EXISTS species_observations (
fsid BIGINT PRIMARY KEY,
spid ,
plotnr,
vegetative_recovery_type
seedbank_type
total live resprouts
reprod live resprouts
total live escapes
reprod live escapes
total live recruit
reprod live recruit
dead resprouts
dead recruits
fire killed
);


CREATE TABLE IF NOT EXISTS efg_authors (
code varchar(100),
name varchar(100));

CREATE TABLE IF NOT EXISTS efg_references (
code varchar(100),
ref_code varchar(100));

CREATE TABLE IF NOT EXISTS map_references (
map_version varchar(100),
ref_code varchar(100));

CREATE TABLE IF NOT EXISTS efg_maps (
code varchar(100),
map_version varchar(100),
occurrence int,
wkb_geometry geometry(MultiPolygon,4326));

CREATE INDEX ix_spatial_primary ON efg_maps USING GIST (wkb_geometry);

CREATE TABLE IF NOT EXISTS map_metadata (
map_version varchar(100),
map_details text
);

CREATE TABLE IF NOT EXISTS ref_list (
ref_code varchar(100) PRIMARY KEY,
ref_cite text,
ref_json text
);

delete from functional_groups;
   delete from efg_authors;
      delete from efg_references;
         delete from map_references;
delete from ref_list;
   delete from efg_maps;
      delete from map_metadata;

https://epsg.io/28356
GDA94 / MGA zone 56
EPSG:28356
