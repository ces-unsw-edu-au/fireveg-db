
CREATE TABLE IF NOT EXISTS form.field_visit (
visit_id VARCHAR(10),
visit_date date,
description text,
observer varchar(30),
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
