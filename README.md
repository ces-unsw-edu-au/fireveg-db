# fireveg-db
Vegetation response to fire in New South Wales, Australia

## Set up database in PostgreSQL

```sh
createdb -O jferrer fireveg
psql -d fireveg -c "CREATE EXTENSION postgis;"
psql -d fireveg -c "CREATE EXTENSION postgis_topology;"
```
Update file ~/.pgpass


Make sure we have a link between web repo and working repo:

```sh
ls -lah /var/www/html/fireveg/

```

## Data model

## test site
ln -s ~/proyectos/UNSW/fireveg-db/web /var/www/html/fireveg
ls -l /var/www/html/fireveg

## test .NET
https://docs.microsoft.com/en-gb/dotnet/core/install/linux-package-manager-ubuntu-1904

wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-3.1

Learn more about .NET Core: https://aka.ms/dotnet-docs
Use 'dotnet --help' to see available commands or visit: https://aka.ms/dotnet-cli-docs


sudo apt-get install aspnetcore-runtime-3.1
sudo apt-get install dotnet-runtime-3.1

## graph database for data model:


Translate information from NSW fire data
Clean up data from literature (references)
split multiple records from different sources

variability in the data ?

pragmatic - capture essential data

Examples from Mark
Tonny

References per species


## documentation:


Render R markdown file using `Rscript`:

```sh
RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/MacOS/pandoc"
Rscript -e "rmarkdown::render('~/proyectos/UNSW/fireveg-db/documentation/supplementary-methods-1.Rmd',output_format='pdf_document')"
```

```sh
psql -h terra.ad.unsw.edu.au -d fireveg -c '\d "Species_list" ' >> ~/proyectos/UNSW/fireveg-db/documentation/database-schemata.Rmd 
psql -h terra.ad.unsw.edu.au -d fireveg -c "\d simple_ref_list " >> ~/proyectos/UNSW/fireveg-db/documentation/database-schemata.Rmd
psql -h terra.ad.unsw.edu.au -d fireveg -c "\d form. " >> ~/proyectos/UNSW/fireveg-db/documentation/database-schemata.Rmd
psql -h terra.ad.unsw.edu.au -d fireveg -c "\d litrev. " >> ~/proyectos/UNSW/fireveg-db/documentation/database-schemata.Rmd
```
