# fireveg-db

Vegetation response to fire in New South Wales, Australia

## PostgreSQL

We implemented the database using PostgreSQL. Learn more about installation and features here:
<https://www.postgresql.org/about/>

### Manual set up 

Check the PostgreSQL documentation: <https://www.postgresql.org/docs/current/tutorial-createdb.html>

We create the database and added the postGIS extension:

```sh
createdb -O $USERNAME fireveg
psql -d fireveg -c "CREATE EXTENSION postgis;"
psql -d fireveg -c "CREATE EXTENSION postgis_topology;"
```

For managing an instance of the database using the `psql` interactive terminal you will need the database credentials (server or host address and port, username and password, and database name).This information can be stored in a `~/.pgpass` file. Check the documentation here: <https://www.postgresql.org/docs/current/app-psql.html>.

### Manually create tables

Run SQL code in folder `/psql`.

## Replicate database using SQL dump

### Dump database schema to file

This will create a dump file of the PostgreSQL schema without the data using `pg_dump`:

```sh
pg_dump -h $DBHOST -d $DBNAME -p $DBPORT -U $DBUSER \
  --schema-only \
  --format=p \ # or use --format=c for custom format
  --no-owner \
  --no-privileges \
  --clean \
  --create \
  --if-exists \
  --file=fireveg-schema-database.dump
```

### Dump database conent to file

Once data has been imported into the database we can create a SQL dump of schema and data. To keep versioned copies of the files, we can run the following lines of code. 

```sh
mkdir -p dump
TODAY=$(date "+%Y-%m-%d")
pg_dump -h $host $database  -U $user > dump/${TODAY}-firevegdb.sql
bzip2 dump/${TODAY}-firevegdb.sql
```

We uploaded this compressed dump file as a backup of the database content in a open access repository:

> Ferrer-Paris, José R.; Keith, David A. (2023). Fire Ecology Traits for Plants: Database snapshot (SQL dump). figshare. Dataset. https://doi.org/10.6084/m9.figshare.23361002.v1

