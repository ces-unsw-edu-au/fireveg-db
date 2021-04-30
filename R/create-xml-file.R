#!R --vanilla
require(dplyr)
require(readxl)
require(xml2)
require(readr)
require(magrittr)
dts <- read_excel("~/proyectos/UNSW/fireveg-db/input/NSWFFRDv2.1.xlsx",sheet=2,skip=1)
 colnames(dts)
   dts %<>% filter(!`Species Code` %in% "n/a")


 btab <- read_csv("~/proyectos/UNSW/fireveg-db/input/blue-table-v0.0.2.csv")

btab %>% pull(trait_name) %>% table
btab %>% filter(trait_name %in% "bark_thickness") %>% pull(value) %>% as.numeric(.) %>% summary
btab %>% filter(trait_name %in% "soil_seedbank") %>% pull(value) %>% table

btab %>% filter(trait_name %in% "dispersal_syndrome")   %>% pull(value) %>% table
btab %>% filter(trait_name %in% "fire_and_establishing") %>% pull(value)%>% table
btab %>% filter(trait_name %in% "fire_cued_seeding") %>% pull(value) %>% table
btab %>% filter(trait_name %in% "fire_response") %>% pull(value) %>% table
btab %>% filter(trait_name %in% "fire_response_juvenile" ) %>% pull(value) %>% table
btab %>% filter(trait_name %in% "fire_response_on_maturity") %>% pull(value) %>%  table
btab %>% filter(trait_name %in% "germination_treatment") %>% pull(value) %>% table
btab %>% filter(trait_name %in% "lifespan" ) %>% pull(value) %>% table
btab %>% filter(trait_name %in% "regen_strategy" ) %>% pull(value) %>%  table
btab %>% filter(trait_name %in% "seed_mass"  ) %>% pull(value) %>%  as.numeric(.) %>% summary
btab %>% filter(trait_name %in% "seed_storage_location" ) %>% pull(value) %>% table
btab %>% filter(trait_name %in% "serotiny"    ) %>% pull(value) %>%    table
btab %>% filter(trait_name %in% "time_from_fire_to_fruit" ) %>% pull(value) %>% table


 Resprouting <- c("S"="None","Sr"="Few","S/R"="Half","Rs"="Most","R"="All")
 RegenerativeOrgan <- c("epicormic"="Epicormic",
 "stemp buds"="Epicormic",
 "apical"="Apical",
 "lignotuber"="Lignotuber",
 "rootstock"="Lignotuber",
 "root stock"="Lignotuber",
 "basal"="Basal",
 "coppice"="Basal",
 "tuber"="Tuber",
 "taproot"="Tuber",
 "tussock"="Tussock",
 "rhizome"="Long rhizome or root sucker",
 "root sucker"="Long rhizome or root sucker",
 "rootucker"="Long rhizome or root sucker",
 "root buds"="Long rhizome or root sucker",
 "rhizome"="Short rhizome",
 "stolon"="Stolon",
 "stolons"="Stolon")

for (k in c(20:209)) {
   dts %>% slice(k) -> spp

   xroot <- xml_new_root("spplist",.version = "1.0", .encoding = "UTF-8")


   xroot %>% xml_add_child("species",name=spp$`Current Scientific Name`, code=spp$`Species Code`)

   x1 <- xroot %>% xml_children() %>% .[[1]]

   x1 %>% xml_add_child("Resprouting") %>% xml_add_child("value",Resprouting[spp$`Fireresponse`],ref="Auld_2014",show_as="default",original=spp$`Fireresponse`,input="DAK-xwalk")

   x1 %>% xml_add_child("RegenerativeOrgan") %>% xml_add_child("value",RegenerativeOrgan[spp$`Resprout location`],ref="Auld_2014",show_as="default",original=spp$`Resprout location`,input="DAK-xwalk")

   # xml_remove(x1)
   # rm(x1)
   # gc()

   btab %>% filter(taxon_name %in% spp$`Current Scientific Name`)

   btab %>% filter(taxon_name %in% spp$`Current Scientific Name`) %>% pull(trait_name) %>% table

   btab %>% filter(taxon_name %in% spp$`Current Scientific Name` & trait_name %in% "fire_response" & ! dataset_id %in% "Auld_2014") -> adata

   if(nrow(adata)>0) {
      for (k in 1:nrow(adata)) {
         t1  <- xml_child(x1,1) %>% xml_add_child("value",adata$value[k])
         xml_attr(t1, "ref") <- adata$dataset_id[k]
         if (!is.na(adata$site_name[k]))
            xml_attr(t1, "site_id") <- adata$site_name[k]
         if (!is.na(adata$observation_id[k]))
            xml_attr(t1, "observation_id") <- adata$observation_id[k]
         if (!is.na(adata$value_type[k]))
            xml_attr(t1, "value_type") <- adata$value_type[k]
         xml_attr(t1, "input") <- "Austraits-import"

      }
   }


   write_xml(xroot, file=sprintf("~/proyectos/UNSW/fireveg-db/xml/spp-%s.xml",spp$`Species Code`))
   rm(xroot)
   rm(x1)
   rm(t1)

   gc()
}
