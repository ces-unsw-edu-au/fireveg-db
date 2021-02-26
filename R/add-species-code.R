#!R --vanilla
require("RPostgreSQL")
drv <- dbDriver("PostgreSQL") ## remember to update .pgpass file
con <- dbConnect(drv, dbname = "fireveg",
                 host = "localhost", port = 5432,
                 user = "jferrer")

 prg <- 'select "ScientificName",MIN("SpeciesCode") from "Species_list" where "ScientificName" IN ( select distinct species from form.quadrat_samples where species_code is NULL) group by "ScientificName"';

res <- dbGetQuery(con,prg)

require(dplyr)
res %>% filter(!is.na(min)) %>% transmute(qry=sprintf("UPDATE form.quadrat_samples SET species_code=%s WHERE species='%s' AND species_code is NULL", min, ScientificName)) %>% pull(qry) -> qries

for (qry in qries)
   dbSendQuery(con,qry)

 spcode <- 3574
 spname <- "Thysanotus tuberosis"
qry <- sprintf("UPDATE form.quadrat_samples SET species_code=%s WHERE species='%s' AND species_code is NULL",spcode,spname)
   dbSendQuery(con,qry)

dbDisconnect(con)
