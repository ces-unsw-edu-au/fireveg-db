#!R --vanilla
require(readxl)
require(readODS)
require("RPostgreSQL")
drv <- dbDriver("PostgreSQL") ## remember to update .pgpass file
con <- dbConnect(drv, dbname = "fireveg",
                 host = "localhost", port = 5432,
                 user = "jferrer")

## data from first samples

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

 colnames(dts)
 dts[dts %in% "nr"] <- NA
dts$SpeciesCode[dts$SpeciesCode %in% "lookup"] <- NA
dts[dts$resp_out_type2 %in% c("basal scorch","basal stens","nr"),"resp_out_type2"] <- NA


## new quadrat data:

dts <- read_ods("~/proyectos/UNSW/fireveg-db/input/database_fire_20200302.ods",sheet=4)
dts$organ <- dts$resprout_organ
dts$organ[dts$resprout_organ %in% c("rhizome","short rhizome","long rhizome","large rhizome")] <- "rhizoma"
dts$seedbank <- dts$seedbank_type
dts$seedbank[dts$seedbank %in% c("soil")] <- "soil-persistent"
dts$seedbank[dts$seedbank %in% c("canopy :: transient")] <- "other"
dts$seedbank[dts$seedbank %in% c("serothem")] <- "other"
dts$ecode <- as.numeric(dts$SpeciesCode)

for (k in 1:nrow(dts)) {
qry <- sprintf("INSERT INTO form.quadrat_samples values ('%s',%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
      dts[k,"sample_id"],
      dts[k,"subplot#"],
      InsVal(dts[k,"species"]),
      InsVal(dts[k,"ecode"]),
      InsVal(dts[k,"adult_juvenile"]),  ## adult or juvenile
      InsVal(dts[k,"organ"]),
      InsVal(dts[k,"seedbank"]),
      InsVal(dts[k,"resprout_live"]),
      InsVal(dts[k,"resprout_died_postfire"]),
      InsVal(dts[k,"resprout_killedfire"]),
      InsVal(dts[k,"resprout_reproductive"]),
      InsVal(dts[k,"recruit_live"]),
      InsVal(dts[k, "recruits_diedpostfire_"]),
      InsVal(dts[k,"recruit_reproductive"]),
      InsVal(dts[k,"transcription_comments"]))


   dbSendQuery(con,qry)
}


dbDisconnect(con)
