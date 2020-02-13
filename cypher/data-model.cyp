// Example with information from one site

CREATE (exampleVisit:Visit {sample_id: 'roy001', description:'2-6 km w of bert stephens :: garie rd interseption stop gully :: mild slope', date: '2019-10-25'})

CREATE (exampleSite:Location {sample_id: 'roy001',location: '2-6 km w of  bert stephans drive :: garie rd intersection',lat:'6218620',lon:'318608',proj:'gda97 zone 56',elev:'126'})

CREATE (dkeith:Person {name:'d keith'})
CREATE (FH:fireHistory)

CREATE (:RecentFire { date:'2018-02-20', how_inferred:'npws records', cause_ignition:'human :: backburn :: arson',type:'recent'})-[:HAD_RECENT_FIRE]->(FH)
CREATE (:AntecedentFire { date:'1997-01-08', how_inferred:'npws records', cause_ignition:'human :: wildfire :: arson',type:'antecedent'})-[:HAD_ANTECEDENT_FIRE]->(FH)
CREATE (:AntecedentFire { date:'1988-10-08', how_inferred:'npws records', cause_ignition:'human :: wildfire :: arson',type:'antecedent'})-[:HAD_ANTECEDENT_FIRE]->(FH)

CREATE (PFV:PreFireVegetation)

CREATE (dkeith)-[:IS_OBSERVER]->(exampleVisit)
CREATE (exampleVisit)-[:LOCATED_IN]->(exampleSite)
CREATE (exampleVisit)-[:WITH_FIRE_HISTORY]->(FH)
CREATE (exampleVisit)-[:WITH_PREFIRE_VEGETATION]->(PFV)


CREATE (:PlantCommunityType { name:'wet schlerophyll forest :: Eucalyptus pilularis :: Eucalyptus peniculata'})-[:FOUND_AT]->(PFV)
CREATE (:ThreatenedEcologicalCommunity { name:'NONE'})-[:FOUND_AT]->(PFV)


CREATE (:VegetationStratum { class:'tree',height_best:'47',height_lower:'39',height_upper:'52',scorch_best:'5',scorch_lower:'4',scorch_upper:'8', cover_percentage:'60',foliage_biomass_consumed_best:'1',foliage_biomass_consumed_lower:'0',foliage_biomass_consumed_upper:'2'})-[:FOUND_AT]->(PFV)

CREATE (:VegetationStratum { class:'shrub',height_best:'10',height_lower:'NOT RECORDED',height_upper:'15',scorch_best:'10',scorch_lower:'NOT RECORDED',scorch_upper:'15', cover_percentage:'15',foliage_biomass_consumed_best:'80',foliage_biomass_consumed_lower:'75',foliage_biomass_consumed_upper:'90',largest_twigs_consummed_best:'1',largest_twigs_consummed_best:'0.5',largest_twigs_consummed_best:'1.5'})-[:FOUND_AT]->(PFV)


CREATE (:VegetationStratum { class:'ground layer', cover_percentage:'50',foliage_biomass_consumed_best:'90',foliage_biomass_consumed_lower:'100',foliage_biomass_consumed_upper:'85'})-[:FOUND_AT]->(PFV)

CREATE (:Peat { area:'NONE', max_depth:'NONE'})-[:FOUND_AT]->(PFV)

CREATE (PRS:PlantResponseSample)
CREATE (exampleVisit)-[:WITH_PLANT_RESPONSE_SAMPLE]->(PRS)

CREATE (SR:SpeciesRecord {name:'Hibbertia dentata',seedbank_type:''})<-[:HAS_SPECIES_RECORD_OF]-(PRS)

CREATE (:Resprouts {age_class:'adult',resprout_organ:'',live:'',dead:'',killed_by_fire:'',reproductive:''})<-[:HAS_RESPROUTS]-(SR)
CREATE (:Recruits {live:'',dead:'',reproductive:''})<-[:HAS_RECRUITS]-(SR)
