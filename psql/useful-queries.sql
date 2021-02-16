
\x
select * from functional_groups ;
select distinct name from efg_authors;
select names from functional_groups order by names;
select biome_code,code,name from functional_groups order by biome_code,code;
select typarray,typname,enumsortorder,enumlabel from pg_type typ left join pg_enum enu on enu.enumtypid=typ.oid where typname ='sampling_method'


UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.12337 -33.63982)',4326) where visit_id='BER1';

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(237789.51251 6304112.19457)',4326)  where visit_id='SS1'       ;
 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(318608 6218620) ',28356)
 where visit_id='ROY001'   ;
 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.03314 -34.14428) ',4326) where visit_id='ROY003'    ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(6302325.42882999 6302325.42882999)',4326) where visit_id='GGE1'      ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(6303023.53275 6303023.53275)',4326) where visit_id='GGW2'      ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(6303038.17324 6303038.17324)',4326) where visit_id='GGW1'      ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(239327.459364999 6303195.67528999)',4326) where visit_id='GW2'       ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(318472 6219681)',28356) where visit_id='ROY002'    ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.10181 -33.75539)',4326) where visit_id='LC2'       ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(6299342 6299342)',4326) where visit_id='MW1'       ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.24815 -33.6632)',4326) where visit_id='Ka3'       ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.20192 -33.72486)',4326) where visit_id='Ka5'       ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.18056 -33.713776)',4326) where visit_id='Ka4'       ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.18826 -33.66391)',4326) where visit_id='LC1'       ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.24805 -33.66299)',4326) where visit_id='Duffy'     ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.15633 -33.68913)',4326) where visit_id='Ka3_b'     ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.00566 -34.1455)',4326)where visit_id='ROY004'    ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(151.06018 -33.72733)',4326)where visit_id='BER2'      ;

 UPDATE form.field_visit SET geom=ST_GeomFromText('POINT(6297045.91112 241682.834307999)',4326)where visit_id='HV2'       ;
