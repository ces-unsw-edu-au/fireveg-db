#!R --vanilla
require(readxl)
require("RPostgreSQL")
require(dplyr)

drv <- dbDriver("PostgreSQL") ## remember to update .pgpass file
con <- dbConnect(drv, dbname = "fireveg",
                 host = "localhost", port = 5432,
                 user = "jferrer")

dts <- read_excel("~/proyectos/UNSW/fireveg-db/input/tree_list_20191112.xlsx",sheet=1)
 colnames(dts)
 dbWriteTable(con,"Species_list",dts[,1:10])
 dbSendQuery(con,'CREATE INDEX name ON "Species_list" USING btree ("ScientificName")')

dts <- read_excel("~/proyectos/UNSW/fireveg-db/input/NSWFFRDv2.1.xlsx",sheet=3)
 colnames(dts)


dts$ESref<- NA
for (k in 1:nrow(dts)) {
   ss <- dts %>% slice(k) %>% pull(`Reference Details`)
   dts$ESref[k] <- postgresqlEscapeStrings(con,ss)
}
dts %>% filter(!is.na(`Ref. No.`)) %>% transmute(qry=sprintf("INSERT INTO simple_ref_list(ref_code,ref_cite) values ('%s','%s') ON CONFLICT DO NOTHING",`Ref. No.`, ESref)) %>% pull(qry) -> qries

for (qry in qries)
   dbSendQuery(con,qry)

dts$ESref<- NA
for (k in 1:nrow(dts)) {
   ss <- dts %>% slice(k) %>% pull(`NFRR Reference details`)
   dts$ESref[k] <- postgresqlEscapeStrings(con,ss)
}
dts %>% filter(!is.na(`NFRR Ref`) & nchar(`NFRR Ref`)<20) %>% transmute(qry=sprintf("INSERT INTO simple_ref_list(ref_code,ref_cite) values ('%s','%s') ON CONFLICT DO NOTHING",`NFRR Ref`, ESref)) %>% pull(qry) -> qries

for (qry in qries)
   dbSendQuery(con,qry)

dts %>% filter(!is.na(`Ref No.`) ) %>% transmute(qry=sprintf("INSERT INTO simple_ref_list(ref_code,ref_cite) values ('%s','Recovery Plan / Regional Forest Agreement Report for %s. Version used: %s') ON CONFLICT DO NOTHING",`Ref No.`, `Recovery Plan / Regional Forest Agreement Report`,`Version used`)) %>% pull(qry) -> qries

for (qry in qries)
   dbSendQuery(con,qry)

qry="INSERT INTO simple_ref_list(ref_code,ref_cite) values ('NSWFFRDv2.1','NSW Flora Fire Response Database. Version 2.1. February 2010 (last update May 2014)') ON CONFLICT DO NOTHING"
dbSendQuery(con,qry)

dts <- read_excel("~/proyectos/UNSW/fireveg-db/input/NSWFFRDv2.1.xlsx",sheet=2,skip=1)
 colnames(dts)


dts$ESspecies<- NA
for (k in 1:nrow(dts)) {
   ss <- dts %>% slice(k) %>% pull(`Current Scientific Name`)
   dts$ESspecies[k] <- postgresqlEscapeStrings(con,ss)
}
dts %>% filter(!is.na(Fireresponse)) %>% select(`Current Scientific Name`,`Species Code`,`Fireresponse`,ESspecies) %>% transmute(qry=sprintf("INSERT INTO litrev.raw_annotations(species,species_code,attribute,value,ref_code) values ('%s',%s,'Fireresponse','%s','NSWFFRDv2.1') ON CONFLICT DO NOTHING",`ESspecies`,ifelse(`Species Code` %in% 'n/a',"NULL",sprintf("'%s'",`Species Code`)),`Fireresponse`)) %>% pull(qry) -> qries


for (qry in qries)
   dbSendQuery(con,qry)


#error
slc.var <- "Post-fire recruitment"

#good
slc.var <- "Germination cue"
slc.var <- "Seed storage"
slc.var <- "Comments on regeneration"
slc.var <- "Resprout location"
slc.var <- "Establishment"

slc.var <- "Flowering time"
slc.var <- "Seed dispersal mechanism"

 dts %>% filter(!is.na(!!sym(slc.var))) %>% select(`Current Scientific Name`,`Species Code`,!!slc.var,ESspecies) %>% transmute(qry=sprintf("INSERT INTO litrev.raw_annotations(species,species_code,attribute,value,ref_code) values ('%s',%s,'%s','%s','NSWFFRDv2.1') ON CONFLICT DO NOTHING",`ESspecies`,ifelse(`Species Code` %in% 'n/a',"NULL",sprintf("'%s'",`Species Code`)),slc.var,!!sym(slc.var))) %>% pull(qry) -> qries

for (qry in qries)
dbSendQuery(con,qry)

dbDisconnect(con)
