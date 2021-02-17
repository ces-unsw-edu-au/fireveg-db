-- test one simple for loop

DO $$
BEGIN
FOR counter IN 1..20
 LOOP
   INSERT INTO form.field_samples (visit_id,sample_nr,sample_method,quadrat_area)
   SELECT 'BS1',counter,'quadrat',1
   ON CONFLICT DO NOTHING;
END LOOP;
END;
$$;

-- now i/terate over rows of results
DO $$
DECLARE
    temprow RECORD;
BEGIN
FOR temprow IN select visit_id,max(sample_nr) as n,max(quadrat_area) as qarea from form.field_samples where sample_method='quadrat' group by visit_id
    LOOP
     FOR counter IN 1..temprow.n
      LOOP
        INSERT INTO form.field_samples (visit_id,sample_nr,sample_method,quadrat_area)
        SELECT temprow.visit_id,counter,'quadrat',
        temprow.qarea
        ON CONFLICT DO NOTHING;
        END LOOP;
    END LOOP;
  END;
$$;
