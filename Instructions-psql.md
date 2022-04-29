# fireveg-db
Vegetation response to fire in New South Wales, Australia

## Set up database in PostgreSQL

```sh
createdb -O $USERNAME fireveg
psql -d fireveg -c "CREATE EXTENSION postgis;"
psql -d fireveg -c "CREATE EXTENSION postgis_topology;"
```

Update file ~/.pgpass
