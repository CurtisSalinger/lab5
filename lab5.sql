SELECT a.attname, t.typname, t.typalign, t.typlen
  FROM pg_class c
  JOIN pg_attribute a ON (a.attrelid = c.oid)
  JOIN pg_type t ON (t.oid = a.atttypid)
 WHERE c.relname = 'user_order'
   AND a.attnum >= 0
 ORDER BY t.typlen DESC;


CREATE TABLE network_connection (
    id SERIAL, -- typelen = , typealign = 
    source macaddr NOT NULL,
    dest macaddr NOT NULL,
    starttime timestamptz NOT NULL,
    bytes_sent int8 NOT NULL
);

--CORRECT ORDER FOR MINIMAL SPACE
CREATE TABLE network_connection (
	starttime timestampt NOT NULL,
	bytes_sent int8 NOT NULL,
	source macaddr NOT NULL,
	dest macaddr NOT NULL,
	id SERIAL
)
--SPACE PER LINE
24 + 8 + 8 + 6 + 6 + 4 = 56 bytes

  attname   |   typname   | typalign | typlen 
------------+-------------+----------+--------
 starttime  | timestamptz | d        |      8
 bytes_sent | int8        | d        |      8
 source     | macaddr     | i        |      6
 dest       | macaddr     | i        |      6
 id         | int4        | i        |      4



CREATE TABLE event (
    id BIGSERIAL,
    name TEXT,
    public BOOLEAN,
    max_guests SMALLINT,
    location_id INTEGER NOT NULL,
    starttime timestamp with time zone NOT NULL,
    endtime timestamp with time zone
);

--CORRECT ORDER FOR MINIMAL SPACE
CREATE TABLE event (
	endtime timestamptz NOT NULL,
	starttime timestamptz NOT NULL,
	id int8 BIGSERIAL,
	location_id INTEGER NOT NULL,
	max_guests SMALLINT,
	public BOOLEAN,
	name TEXT
);

--SPACE PER LINE ASSUMING VAR LENGTH FIELDS ARE NULL
24 + 8 + 8 + 8 + 4 + 2 + 1 + 0 = 55

   attname   |   typname   | typalign | typlen 
-------------+-------------+----------+--------
 endtime     | timestamptz | d        |      8
 starttime   | timestamptz | d        |      8
 id          | int8        | d        |      8
 location_id | int4        | i        |      4
 max_guests  | int2        | s        |      2
 public      | bool        | c        |      1
 name        | text        | i        |     -1


CREATE TABLE example (
    id SMALLSERIAL NOT NULL,
    a SMALLINT,
    b CHAR,
    c int2,
    d line,
    e JSONB
);


--CORRECT ORDER FOR MINIMAL SPACE
CREATE TABLE example (
	d line,
	id SMALLSERIAL NOT NULL,
	a SMALLINT,
	c int2,
	b CHAR,
	e JSONB
)

--SPACE PER LINE ASSUMING VAR LENGTH FIELDS ARE NULL
24 + 24 + 2 + 2 + 2 + 0 + 0 = 54


 attname | typname | typalign | typlen
---------+---------+----------+--------
 d       | line    | d        |     24
 id      | int2    | s        |      2
 a       | int2    | s        |      2
 c       | int2    | s        |      2
 b       | bpchar  | i        |     -1
 e       | jsonb   | i        |     -1
