BEGIN TRANSACTION;
CREATE TABLE objects (
oid INTEGER PRIMARY KEY asc,
md5 TEXT UNIQUE, 
source TEXT,
date INTEGER, title TEXT, description TEXT);
INSERT INTO "objects" VALUES(1,'cbb2af01694d7deaa351cbe2bc06ffc0','/home/alex/playground/tagit/a.pl',1254873788,'a.pl',NULL);
CREATE TABLE tags (
tid INTEGER PRIMARY KEY asc,
name TEXT);
INSERT INTO "tags" VALUES(1,'a');
INSERT INTO "tags" VALUES(2,'b');
INSERT INTO "tags" VALUES(3,'c');
INSERT INTO "tags" VALUES(4,'a');
INSERT INTO "tags" VALUES(5,'b');
INSERT INTO "tags" VALUES(6,'c');
CREATE TABLE links (
lid INTEGER PRIMARY KEY asc,
oid INTEGER NOT NULL,
tid INTEGER NOT NULL);
INSERT INTO "links" VALUES(1,1,4);
INSERT INTO "links" VALUES(2,1,5);
INSERT INTO "links" VALUES(3,1,6);
CREATE TABLE attach (aid INTEGER PRIMARY KEY asc,
pid INTEGER NOT NULL,
cid INTEGER NOT NULL);
CREATE UNIQUE INDEX hash on objects (hash);
CREATE INDEX oid on links (oid);
CREATE INDEX tid on links (tid);
CREATE INDEX pid on attach (pid);
COMMIT;
