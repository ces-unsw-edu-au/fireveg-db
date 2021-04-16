INSERT INTO litrev.traits (species,species_code,resprouting,ref_code,refs)
SELECT species,species_code,'none',ref_code,refs
FROM litrev.raw_annotations
WHERE attribute='Fireresponse' AND value='S' AND species_code is NOT NULL
ON CONFLICT (species,species_code) DO UPDATE SET resprouting=EXCLUDED.resprouting;

INSERT INTO litrev.traits (species,species_code,resprouting,ref_code,refs)
SELECT species,species_code,'few',ref_code,refs
FROM litrev.raw_annotations
WHERE attribute='Fireresponse' AND value='Sr' AND species_code is NOT NULL
ON CONFLICT (species,species_code) DO UPDATE SET resprouting=EXCLUDED.resprouting;

INSERT INTO litrev.traits (species,species_code,resprouting,ref_code,refs)
SELECT species,species_code,'half',ref_code,refs
FROM litrev.raw_annotations
WHERE attribute='Fireresponse' AND value='S/R' AND species_code is NOT NULL
ON CONFLICT (species,species_code) DO UPDATE SET resprouting=EXCLUDED.resprouting;

INSERT INTO litrev.traits (species,species_code,resprouting,ref_code,refs)
SELECT species,species_code,'most',ref_code,refs
FROM litrev.raw_annotations
WHERE attribute='Fireresponse' AND value='Rs' AND species_code is NOT NULL
ON CONFLICT (species,species_code) DO UPDATE SET resprouting=EXCLUDED.resprouting;

INSERT INTO litrev.traits (species,species_code,resprouting,ref_code,refs)
SELECT species,species_code,'all',ref_code,refs
FROM litrev.raw_annotations
WHERE attribute='Fireresponse' AND value='R' AND species_code is NOT NULL
ON CONFLICT (species,species_code) DO UPDATE SET resprouting=EXCLUDED.resprouting;
