#!R --vanilla
require(readxl)
require("RPostgreSQL")
require(ggplot2)
require(dplyr)

drv <- dbDriver("PostgreSQL") ## remember to update .pgpass file
con <- dbConnect(drv, dbname = "fireveg",
                 host = "localhost", port = 5432,
                 user = "jferrer")

# plot 1: N total live resprouts (N1 integer)
# plot 1: N reprod live resprouts (N2 integer)
# plot 1: N total live escapes (N3 integer)
# plot 1: N reprod live escapes (N4 integer)
# plot 1: N total live recruit s (N5 integer)
# plot 1: N reprod live recruit s (N6 integer)
# plot 1: N dead sprout s (N7 integer)
# plot 1: N dead recruits  (N8 integer)
# plot 1: N fire killed (N9 integer)


#Species traits (field derived)
#SpeciesID
#FieldsampleID
#% Fire mortality of established plants (100*(N9)/(N1+N7+N9)
#N fire mortality (N1+N7+N9)
#% Post-fire sprouter survival (100*(N1/N1+N7)) annualise?
#N sprouter survival (N1+N7)
#Seedling/adult ratio (N5+N8)/(N1+N3+N7)
#% Postfire recruit survival (100*(N5)/(N5+N8)) annualise?
#N recruit survival (N5+N8)
#% resprouts reproductive (100*N2/(N12))
#N reproductive resprouts (N1)
#% recruits reproductive (100*N6/(N5))
#N reproductive recruits (N5)
#Survivor density ((N2)/A)
#Live recruit density (N5/A)

## post fire sprouter survival
#N1: total live resprouts
#N7:  dead sprouts
#100 * (N1/(N1+N7))
qry <- "
SELECT visit_id,MAX(v.visit_date)-MAX(f.fire_date) as dayslastfire, species_code, SUM(COALESCE(resprouts_live,0) ) as N1, SUM(COALESCE(resprouts_died,0) ) as N7 , SUM(COALESCE(resprouts_live,0)  + COALESCE(resprouts_died,0) ) as total
FROM form.quadrat_samples s
LEFT JOIN form.field_visit v USING(visit_id)
LEFT JOIN form.fire_history f USING(visit_id)
GROUP BY visit_id,species_code"
res <- dbGetQuery(con,qry)

res %>% filter(total>0) %>% mutate(survival=100*n1/total) %>% ggplot() -> p

p %>% geom_point(aes(dayslastfire, survival))

dbDisconnect(con)
