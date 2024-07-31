# `psql` directory

This directory contains SQL code to create types/vocabularies and tables for the database in `postgresql`.

## Files

- `00-vocabularies.sql`: types/vocabularies for categorical variables and methods
- `10-spp-table.sql`: taxonomic component
   - ~~`10-veg-table.sql`:~~ currently not implemented
- `20-field-form-aka-green-module.sql`: main tables for field information
   - `21-field-form-vegetation-variables.sql`: additional tables for vegetation information
- `30-litrev-aka-blue-module.sql`: trait information
   - `31-litrev-categorical.sql`: tables for categorical traits
   - `32-litrev-fuzzy-numbers.sql`: tables for numeric traits
   - `33-litrev-methods.sql`: vocabularies for methods
- `40-derived-tables.sql`: code for creating temporary table with union of trait tables


