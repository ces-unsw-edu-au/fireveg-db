CREATE SCHEMA vegetation;

-- the table nsw_units contains Keith classes for vegetation formations in NSW

CREATE TABLE vegetation.nsw_units(
  vegetation_formation text,
  vegetation_class text,
  FormNum SMALLINT,
  MapUnitNo SMALLINT,
  PRIMARY KEY (vegetation_formation,vegetation_class)
);
