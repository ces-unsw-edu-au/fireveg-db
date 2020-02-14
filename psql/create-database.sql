
CREATE TABLE IF NOT EXISTS form.field_visit (
visit_id VARCHAR(10) ,
visit_date date,
visit_description text,
location_description text,
geom geometry,
PlantCommunityType text,
ThreatenedEcologicalCommunity text,
observer INT REFERENCES form.observerID ON DELETE RESTRICT,
tree_canopy_height_best int,
tree_canopy_height_lower int,
tree_canopy_height_upper int,
tree_canopy_cover int,
tree_canopy_scorch_best int,
tree_canopy_scorch_lower int,
tree_canopy_scorch_upper int,
CHECK (tree_canopy_height_best >= tree_canopy_height_lower AND tree_canopy_height_best <= tree_canopy_height_upper),
CHECK (tree_canopy_scorch_best >= tree_canopy_scorch_lower AND tree_canopy_scorch_best <= tree_canopy_scorch_upper),
CHECK (tree_canopy_scorch_upper  <= tree_canopy_height_upper),
mid_canopy_height_best int,
mid_canopy_height_lower int,
mid_canopy_height_upper int,
mid_canopy_cover int,
mid_canopy_scorch_best int,
mid_canopy_scorch_lower int,
mid_canopy_scorch_upper int,
CHECK (mid_canopy_height_best >= mid_canopy_height_lower AND mid_canopy_height_best <= mid_canopy_height_upper),
CHECK (mid_canopy_scorch_best >= mid_canopy_scorch_lower AND mid_canopy_scorch_best <= mid_canopy_scorch_upper),
CHECK (mid_canopy_scorch_upper  <= mid_canopy_height_upper),
shrub_height_best int,
shrub_height_lower int,
shrub_height_upper int,
shrub_cover int,
shrub_scorch_best int,
shrub_scorch_lower int,
shrub_scorch_upper int,
CHECK (shrub_height_best >= shrub_height_lower AND shrub_height_best <= shrub_height_upper),
CHECK (shrub_scorch_best >= shrub_scorch_lower AND shrub_scorch_best <= shrub_scorch_upper),
CHECK (shrub_scorch_upper  <= shrub_height_upper),
ground_burnt_best numeric,
ground_burnt_lower numeric,
ground_burnt_upper numeric,
ground_cover int,
CHECK (ground_burnt_best >= ground_burnt_lower AND ground_burnt_best <= ground_burnt_upper),
tree_foliage_biomass_consumed_best int,
tree_foliage_biomass_consumed_lower int,
tree_foliage_biomass_consumed_upper int,
CHECK (tree_foliage_biomass_consumed_best >= tree_foliage_biomass_consumed_lower AND tree_foliage_biomass_consumed_best <= tree_foliage_biomass_consumed_upper),
shrub_foliage_biomass_consumed_best int,
shrub_foliage_biomass_consumed_lower int,
shrub_foliage_biomass_consumed_upper int,
CHECK (shrub_foliage_biomass_consumed_best >= shrub_foliage_biomass_consumed_lower AND shrub_foliage_biomass_consumed_best <= shrub_foliage_biomass_consumed_upper),
ground_foliage_biomass_consumed_best int,
ground_foliage_biomass_consumed_lower int,
ground_foliage_biomass_consumed_upper int,
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
