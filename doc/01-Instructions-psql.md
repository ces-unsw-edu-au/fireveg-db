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

