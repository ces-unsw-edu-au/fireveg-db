
## Entity Relationship Diagrams

Ada had a go at a large diagram but has to be edited online.

We can create shareable, textbased Entity Relationship Diagrams using [mermaid.js](https://mermaid.js.org/syntax/entityRelationshipDiagram.html) but customising colours is not straightforward:

- https://github.com/mermaid-js/mermaid/issues/2673
- https://codepen.io/huynhicode/pen/eYLqmQJ

Other options include ERD format (`.er` files)  or the bigER modeling tool (`.erd` files). 

## Lucid charts

Register user with unsw email to activate EDU account.

To create a ERD document, run this query to export schema from postgresql database:

```{sql}
SET enable_nestloop=0;

\copy (SELECT 'postgresql' AS dbms,t.table_catalog,t.table_schema,t.table_name,c.column_name,c.ordinal_position,c.data_type,c.character_maximum_length,n.constraint_type,k2.table_schema,k2.table_name,k2.column_name FROM information_schema.tables t NATURAL LEFT JOIN information_schema.columns c LEFT JOIN(information_schema.key_column_usage k NATURAL JOIN information_schema.table_constraints n NATURAL LEFT JOIN information_schema.referential_constraints r)ON c.table_catalog=k.table_catalog AND c.table_schema=k.table_schema AND c.table_name=k.table_name AND c.column_name=k.column_name LEFT JOIN information_schema.key_column_usage k2 ON k.position_in_unique_constraint=k2.ordinal_position AND r.unique_constraint_catalog=k2.constraint_catalog AND r.unique_constraint_schema=k2.constraint_schema AND r.unique_constraint_name=k2.constraint_name WHERE t.TABLE_TYPE='BASE TABLE' AND t.table_schema NOT IN('information_schema','pg_catalog')) to 'ERD-export-fireveg.csv' csv header;

```

[Published document](https://lucid.app/lucidchart/537633dc-56b0-4b21-b6ec-377c3b6771e0/view?page=0_0&invitationId=inv_f7598dc3-a309-4e98-9439-fb73b540f7c4#) includes two traits as examples.