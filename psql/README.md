# `psql` directory

This directory contains SQL code to create types and tables for the database in `postgresql`.

## Files

- 00-vocabularies.sql
- 10-spp-table.sql
- 20-field-form-aka-green-module.sql
- 30-litrev-aka-blue-module.sql
   - 31-litrev-categorical.sql
   - 32-litrev-fuzzy-numbers.sql
   - 33-litrev-methods.sql
- 40-derived-tables.sql


```sh
psql -h $DBHOST -d $DBNAME -c "\d species " >> database-schemata.Rmd
psql -h $DBHOST -d $DBNAME -c "\d form. " >> database-schemata.Rmd
psql -h $DBHOST -d $DBNAME -c "\d litrev. " >> database-schemata.Rmd
```
