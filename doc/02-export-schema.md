

```sh
psql -h $DBHOST -d $DBNAME -c "\d species " >> database-schemata.md
psql -h $DBHOST -d $DBNAME -c "\d form. " >> database-schemata.md
psql -h $DBHOST -d $DBNAME -c "\d litrev. " >> database-schemata.md
```

## Dump database to file

Once data has been imported into the database we create a SQL dump using `pg_dump`. 

```sh
mkdir -p dump
TODAY=$(date "+%Y-%m-%d")
pg_dump -h $host $database  -U $user > dump/${TODAY}-firevegdb.sql
bzip2 dump/${TODAY}-firevegdb.sql
```

We uploaded this compressed dump file as a backup of the database content in a open access repository:

> Ferrer-Paris, José R.; Keith, David A. (2023). Fire Ecology Traits for Plants: Database snapshot (SQL dump). figshare. Dataset. https://doi.org/10.6084/m9.figshare.23361002.v1