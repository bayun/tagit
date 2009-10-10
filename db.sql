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
name TEXT);
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
COMMIT;
