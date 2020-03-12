#!R --vanilla
require("RPostgreSQL")
drv <- dbDriver("PostgreSQL") ## remember to update .pgpass file
con <- dbConnect(drv, dbname = "fireveg",
                 host = "localhost", port = 5432,
                 user = "jferrer")

qry <- "SELECT * FROM form.quadrat_samples"
dbGetQuery(con,qry)
