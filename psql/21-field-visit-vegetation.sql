CREATE TABLE IF NOT EXISTS form.field_visit_veg_description (
  visit_id VARCHAR(30),
  visit_date date,
  vegetation_description text,
  vegetation_formation text,
  vegetation_class text,
  -- VegCategoryID int,
  -- ConfidenceID int,
  -- ThreatenedEcologicalCommunity text,
  PRIMARY KEY (visit_id,visit_date)
);

ALTER TABLE form.field_visit_veg_description
    ADD CONSTRAINT field_visit_date_fkey
    FOREIGN KEY (visit_id,visit_date)
    REFERENCES form.field_visit(visit_id,visit_date)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE form.field_visit_veg_description
    ADD CONSTRAINT field_formation_class_fkey
    FOREIGN KEY (vegetation_formation,vegetation_class)
    REFERENCES vegetation.nsw_units(vegetation_formation,vegetation_class)
    ON DELETE CASCADE ON UPDATE CASCADE;




CREATE TABLE IF NOT EXISTS form.field_visit_vegetation_estimates (
  visit_id VARCHAR(30),
  visit_date date,
  measured_var vegvars,
  units varunits,
  best numeric,
  lower numeric,
  upper numeric,
  CHECK (best >= lower AND best <= upper),
  PRIMARY KEY (visit_id,visit_date,measured_var)
);
ALTER TABLE form.field_visit_vegetation_estimates add comment text[];
ALTER TABLE form.field_visit_vegetation_estimates
  DROP CONSTRAINT field_visit_date_fkey;

ALTER TABLE form.field_visit_vegetation_estimates
  ADD CONSTRAINT field_visit_date_fkey
  FOREIGN KEY (visit_id,visit_date)
  REFERENCES form.field_visit(visit_id,visit_date)
  ON DELETE CASCADE ON UPDATE CASCADE;
