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


    CREATE TYPE vegvars AS ENUM (
      'tree canopy height', 'tree canopy scorch', 'tree canopy cover',
      'mid canopy height', 'mid canopy scorch', 'mid canopy cover',
      'shrub height', 'shrub scorch', 'shrub cover',
      'ground cover','ground burnt', 'tree foliage biomass consumed', 'shrub foliage biomass consumed', 'ground foliage biomass consumed',  'largest twigs consumed', 'peat consumption area', 'peat consumption max depth'
    );
      CREATE TYPE varunits AS ENUM('mm','cm','m','%');

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
