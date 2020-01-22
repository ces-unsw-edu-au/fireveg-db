
-- Clean up the reference list
select ref_code from ref_list order by ref_code;
select * from ref_list where ref_code like 'Beck MW%';
update map_references set ref_code='Beck MW, Brumbaugh RD, Airoldi L, Carranza A, Coen LD, Crawford C, Defeo O, Edgar GJ, Hanc... 2011' where ref_code like 'Beck MW%';
select * from ref_list where ref_code like 'Chester%';
update efg_references set ref_code='Chester ET, Robson BJ  2013' where ref_code like 'Chester%';
select * from ref_list where ref_code like 'Monfreda%';
update efg_references set ref_code='Monfreda CN, Ramankutty N, Foley JA  2008' where ref_code like 'Monfreda%';
update map_references set ref_code='Monfreda CN, Ramankutty N, Foley JA  2008' where ref_code like 'Monfreda%';
select * from ref_list where ref_code like 'Rossi S,%';
update efg_references set ref_code='Rossi S, Bramanti L, Gori, A, Orejas C  2017' where ref_code like 'Rossi S,%';
select * from ref_list where ref_code like 'Steneck%';
update efg_references set ref_code='Steneck RS, Graham MH, Bourque BJ, Corbett D, Erlandson JM, Estes JA, Tegner MJ  2002' where ref_code like 'Steneck%';
update map_references set ref_code='Steneck RS, Graham MH, Bourque BJ, Corbett D, Erlandson JM, Estes JA, Tegner MJ  2002' where ref_code like 'Steneck%';

select r.ref_code,e.code,m.map_version from ref_list as r
left join efg_references as e on r.ref_code=e.ref_code
left join map_references as m on r.ref_code=m.ref_code
order by e.code,map_version
;

delete from ref_list where ref_code IN ('Chester ET, Robson BJ  2013.',
 'Monfreda C, Ramankutty N, Foley JA  2008',
 'Steneck RS, Graham MH, Bourque BJ, Corbett D et al.  2002',
 'Beck MW, Brumbaugh RD, Airoldi L, Carranza A,. Coen LD, Crawford C, Defeo O, Edgar GJ, Han... 2011',
 'Rossi S, Bramanti L, Gori, A, Orejas C,  2017');

 -- Clean up the Author's list

select distinct name from efg_authors order by name;

update efg_authors set name='D Faber-Langendoen' where name in ('D Faber-Landendoen','D Faber-Langendoen,');
update efg_authors set name='RC Mac Nally' where name in ('R Mac Nally','RC Mac Nally');
update efg_authors set name='NA Brummitt' where name in ('NA Brummit','NA Brummitt');
