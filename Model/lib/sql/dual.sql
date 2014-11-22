-- create an Oracle-style DUAL table in PostgreSQL, for the convenience of SQL that references it.

create table dual as select cast ('X' as varchar(1)) as dummy;

