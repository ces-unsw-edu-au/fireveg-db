#!R --vanilla
require(readxl)
require("RPostgreSQL")
drv <- dbDriver("PostgreSQL") ## remember to update .pgpass file
con <- dbConnect(drv, dbname = "fireveg",
                 host = "localhost", port = 5432,
                 user = "jferrer")

dts <- read_excel("~/proyectos/UNSW/fireveg-db/input/database_fire_20191118+DK.xlsx",sheet=8)
 colnames(dts)
 dts[dts %in% "nr"] <- NA
dts$SpeciesCode[dts$SpeciesCode %in% "lookup"] <- NA
dts[dts$resp_out_type2 %in% c("basal scorch","basal stens","nr"),"resp_out_type2"] <- NA
InsVal <- function(x,na.val="nr") {
   return(ifelse(is.na(x) | x %in% na.val,"NULL",sprintf("'%s'",x)))
}

for (k in 54:nrow(dts)) {
   qry <- sprintf("INSERT INTO form.quadrat_samples values ('%s',%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
      toupper(dts[k,"sample_id"]),
      dts[k,"subplot#"],
      InsVal(dts[k,"species"]),
      InsVal(dts[k,"SpeciesCode"]),
      "'other'",  ## adult or juvenile
      InsVal(dts[k,"resp_out_type2"]),
      InsVal(dts[k,"seedbank_type"]),
      InsVal(dts[k,"total_liveresprouts"]),
      InsVal(dts[k,"dead_resprouts"]),
      InsVal(dts[k,"firekilled_adults"]),
      InsVal(dts[k,"n_reprod_resprouts"]),
      InsVal(dts[k,"liveseedlingrecruits_total"]),
      InsVal(dts[k, "reprod_recruits"],na.val=c("nr","n","m","f","h")),
      InsVal(dts[k,"deadseedlingrecruits"]),
      InsVal(dts[k,"observations"]))


   dbSendQuery(con,qry)

}



dbDisconnect(con)
