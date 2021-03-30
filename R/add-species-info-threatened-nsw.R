#!R --vanilla
require(readr)
require(dplyr)
require("RPostgreSQL")
drv <- dbDriver("PostgreSQL") ## remember to update .pgpass file
con <- dbConnect(drv, dbname = "fireveg",
                 host = "localhost", port = 5432,
                 user = "jferrer")



spp.list <- dbReadTable(con,"Species_list")

# search at: https://www.environment.nsw.gov.au/threatenedSpeciesApp/
#download results as csv
NSW.status <- read_csv(sprintf("~/proyectos/UNSW/fireveg-db/input/ProfileSearch"))

# search at: http://www.environment.gov.au/cgi-bin/sprat/public/sprat.pl
#download results as csv
Cwth.status <- read_csv(sprintf("~/proyectos/UNSW/fireveg-db/input/30032021-052504-report.csv"),skip=1)

mtch <- match(NSW.status %>% pull(`Scientific Name`  ),spp.list$ScientificName)

NSW.status %>% mutate(code=spp.list[mtch,"SpeciesCode"]) %>% filter(!is.na(code)) %>% select( code, `Scientific Name`,  `Common Name`, `NSW Status`) -> rslts

rslts %>% transmute(qry=sprintf("insert into litrev.nsw_status (species,species_code,common_name,nsw_status,source,access_date) values('%s','%s','%s','%s','%s','%s') ON CONFLICT DO NOTHING",`Scientific Name`, code, gsub("'","''",`Common Name`),`NSW Status`,"https://www.environment.nsw.gov.au/threatenedSpeciesApp/","20210330 16:30:00")) %>% pull(qry) -> qries

for (qry in qries)
   dbSendQuery(con,qry)


Cwth.status %>% pull(Kingdom) %>% table

Cwth.status %>% filter(Kingdom %in% "Plantae") %>% select(`EPBC Threat Status`) %>% table
