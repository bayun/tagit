BEGIN TRANSACTION;
CREATE TABLE objects (
oid INTEGER PRIMARY KEY asc,
hash TEXT UNIQUE, 
source TEXT,
addtime INTEGER, 
name TEXT, 
description TEXT);
CREATE TABLE tags (
tid INTEGER PRIMARY KEY asc,
name TEXT UNIQUE);

CREATE TABLE attrs (
aid INTEGER PRIMARY KEY asc,
oid INTEGER NOT NULL,
name TEXT NOT NULL,
value TEXT
);
CREATE TABLE links (
lid INTEGER PRIMARY KEY asc,
oid INTEGER NOT NULL,
tid INTEGER NOT NULL);
CREATE TABLE attach (aid INTEGER PRIMARY KEY asc,
pid INTEGER NOT NULL,
cid INTEGER NOT NULL);
CREATE UNIQUE INDEX hash on objects (hash);
CREATE INDEX oid on links (oid);
CREATE INDEX tid on links (tid);
CREATE INDEX pid on attach (pid);
CREATE INDEX attr_obj on attrs(oid);
CREATE INDEX attr_name on attrs(name);
CREATE UNIQUE INDEX obj_attr on attrs (oid, name);
COMMIT;
