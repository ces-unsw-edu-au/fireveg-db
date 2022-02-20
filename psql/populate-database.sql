-- import from the old tables before deleting

INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'tree canopy height','m', tree_canopy_height_best, tree_canopy_height_lower, tree_canopy_height_upper FROM form.old_field_visit WHERE tree_canopy_height_best is not NULL
ON CONFLICT DO NOTHING;

INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'tree canopy scorch','m', tree_canopy_scorch_best, tree_canopy_scorch_lower, tree_canopy_scorch_upper FROM form.old_field_visit WHERE tree_canopy_scorch_best is not NULL
ON CONFLICT DO NOTHING;

INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'mid canopy height','m', mid_canopy_height_best, mid_canopy_height_lower, mid_canopy_height_upper FROM form.old_field_visit WHERE mid_canopy_height_best is not NULL
ON CONFLICT DO NOTHING;

INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'mid canopy scorch','m', mid_canopy_scorch_best, mid_canopy_scorch_lower, mid_canopy_scorch_upper FROM form.old_field_visit WHERE mid_canopy_scorch_best is not NULL
ON CONFLICT DO NOTHING;


INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'shrub height','m', shrub_height_best, shrub_height_lower, shrub_height_upper FROM form.old_field_visit WHERE shrub_height_best is not NULL
ON CONFLICT DO NOTHING;

INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'shrub scorch','m', shrub_scorch_best, shrub_scorch_lower, shrub_scorch_upper FROM form.old_field_visit WHERE shrub_scorch_best is not NULL
ON CONFLICT DO NOTHING;


INSERT INTO form.field_visit_vegetation_estimates(visit_id,visit_date,measured_var,units,best)
SELECT visit_id,visit_date,'tree canopy cover','%', tree_canopy_cover FROM form.old_field_visit WHERE tree_canopy_cover is not NULL
ON CONFLICT DO NOTHING;


INSERT INTO form.field_visit_vegetation_estimates(visit_id,visit_date,measured_var,units,best)
SELECT visit_id,visit_date,'mid canopy cover','%', mid_canopy_cover FROM form.old_field_visit WHERE mid_canopy_cover is not NULL
ON CONFLICT DO NOTHING;


INSERT INTO form.field_visit_vegetation_estimates(visit_id,visit_date,measured_var,units,best)
SELECT visit_id,visit_date,'shrub cover','%', shrub_cover FROM form.old_field_visit WHERE shrub_cover is not NULL
ON CONFLICT DO NOTHING;

INSERT INTO form.field_visit_vegetation_estimates(visit_id,visit_date,measured_var,units,best)
SELECT visit_id,visit_date,'ground cover','%', ground_cover FROM form.old_field_visit WHERE ground_cover is not NULL
ON CONFLICT DO NOTHING;


INSERT INTO form.field_visit_vegetation_estimates(visit_id,visit_date,measured_var,units,best)
SELECT visit_id,visit_date,'peat consumption area','%', peat_consumption_area FROM form.old_field_visit WHERE peat_consumption_area is not NULL
ON CONFLICT DO NOTHING;

INSERT INTO form.field_visit_vegetation_estimates(visit_id,visit_date,measured_var,units,best)
SELECT visit_id,visit_date,'peat consumption max depth','cm', peat_consumption_maxdepth FROM form.old_field_visit WHERE peat_consumption_maxdepth is not NULL
ON CONFLICT DO NOTHING;


INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'tree foliage biomass consumed','%', tree_foliage_biomass_consumed_best, tree_foliage_biomass_consumed_lower, tree_foliage_biomass_consumed_upper FROM form.old_field_visit WHERE tree_foliage_biomass_consumed_best is not NULL
ON CONFLICT DO NOTHING;



INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'shrub foliage biomass consumed','%', shrub_foliage_biomass_consumed_best, shrub_foliage_biomass_consumed_lower, shrub_foliage_biomass_consumed_upper FROM form.old_field_visit WHERE shrub_foliage_biomass_consumed_best is not NULL
ON CONFLICT DO NOTHING;



INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'ground burnt','m', ground_burnt_best, ground_burnt_lower, ground_burnt_upper FROM form.old_field_visit WHERE ground_burnt_best is not NULL
ON CONFLICT DO NOTHING;


INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'ground foliage biomass consumed','%', ground_foliage_biomass_consumed_best, ground_foliage_biomass_consumed_lower, ground_foliage_biomass_consumed_upper FROM form.old_field_visit WHERE ground_foliage_biomass_consumed_best is not NULL
ON CONFLICT DO NOTHING;

INSERT INTO form.field_visit_vegetation_estimates
SELECT visit_id,visit_date,'largest twigs consumed','cm', largest_twigs_consumed_best, largest_twigs_consumed_lower, largest_twigs_consumed_upper FROM form.old_field_visit WHERE largest_twigs_consumed_best is not NULL
ON CONFLICT DO NOTHING;



INSERT INTO form.field_visit_vegetation(visit_id,visit_date,vegtype,ThreatenedEcologicalCommunity)
SELECT visit_id,visit_date,plantcommunitytype,ThreatenedEcologicalCommunity FROM form.old_field_visit
ON CONFLICT DO NOTHING;

INSERT INTO form.field_samples
SELECT visit_id,min(v.visit_date),sample_nr,sample_method,quadrat_area,transect_length,comments FROM form.old_field_samples LEFT JOIN form.field_visit v USING(visit_id) GROUP BY visit_id,sample_nr,sample_method,quadrat_area,transect_length,comments;
