#!R --vanilla
require(readxl)
require("RPostgreSQL")
drv <- dbDriver("PostgreSQL") ## remember to update .pgpass file
con <- dbConnect(drv, dbname = "fireveg",
                 host = "localhost", port = 5432,
                 user = "jferrer")

dts <- read_excel("~/proyectos/UNSW/fireveg-db/input/tree_list_20191112.xlsx",sheet=1)
 colnames(dts)
 dbWriteTable(con,"Species_list",dts[,1:10])
 dbSendQuery(con,'CREATE INDEX name ON "Species_list" USING btree ("ScientificName")')



dbDisconnect(con)
