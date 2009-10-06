BEGIN TRANSACTION;
CREATE TABLE objects (
oid INTEGER PRIMARY KEY asc,
md5 TEXT UNIQUE, 
source TEXT,
title TEXT,
description TEXT,
date INTEGER);
CREATE TABLE tags (
tid INTEGER PRIMARY KEY asc,
name TEXT);
CREATE TABLE links (
lid INTEGER PRIMARY KEY asc,
oid INTEGER NOT NULL,
tid INTEGER NOT NULL);
CREATE UNIQUE INDEX md5 on objects (md5);
CREATE INDEX oid on links (oid);
CREATE INDEX tid on links (tid);
COMMIT;
