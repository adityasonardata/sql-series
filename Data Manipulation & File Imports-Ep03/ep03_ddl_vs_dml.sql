SQL COMMAND CATEGORIES — FULL MAP
-- ------------------------------------------------
-- Every SQL command belongs to a category.
-- Knowing this map helps you understand WHERE
-- each command fits in the bigger picture.
-- ------------------------------------------------

USE store_db;


-- ================================================
-- DDL — Data Definition Language
-- ================================================
-- Deals with the STRUCTURE of the database.
-- Commands: CREATE, ALTER, DROP, TRUNCATE
-- We used DDL in Episode 02 to build our tables.
-- ------------------------------------------------

-- CREATE  → creates a new database or table
-- ALTER   → modifies an existing table structure
-- DROP    → permanently deletes a table or database
-- TRUNCATE → removes all rows but keeps the table structure


-- ================================================
-- DML — Data Manipulation Language
-- ================================================
-- Deals with the DATA inside tables.
-- Commands: INSERT, UPDATE, DELETE
-- This is what we cover in Episode 03.
-- ------------------------------------------------

-- INSERT  → adds new rows into a table
-- UPDATE  → modifies existing rows
-- DELETE  → removes specific rows


-- ================================================
-- DQL — Data Query Language
-- ================================================
-- Deals with RETRIEVING data from tables.
-- Commands: SELECT
-- This is what we cover in Episode 04.
-- ------------------------------------------------

-- SELECT  → fetches data from one or more tables
-- (most used command in SQL — 80% of your time)


-- ================================================
-- DCL — Data Control Language
-- ================================================
-- Deals with ACCESS CONTROL.
-- Commands: GRANT, REVOKE
-- Used by database administrators.
-- ------------------------------------------------

-- GRANT   → gives a user permission to do something
-- REVOKE  → takes away a user's permission


-- ================================================
-- TCL — Transaction Control Language
-- ================================================
-- Deals with TRANSACTIONS — grouping queries together.
-- Commands: COMMIT, ROLLBACK, SAVEPOINT
-- ------------------------------------------------

-- COMMIT    → saves all changes made in a transaction
-- ROLLBACK  → undoes all changes if something went wrong
-- SAVEPOINT → sets a checkpoint inside a transaction


-- ================================================
-- QUICK SUMMARY
-- ================================================

-- | Category | Commands                        | What it does              |
-- |----------|---------------------------------|---------------------------|
-- | DDL      | CREATE, ALTER, DROP, TRUNCATE   | Defines/changes structure |
-- | DML      | INSERT, UPDATE, DELETE          | Manipulates data          |
-- | DQL      | SELECT                          | Retrieves data            |
-- | DCL      | GRANT, REVOKE                   | Controls access           |
-- | TCL      | COMMIT, ROLLBACK, SAVEPOINT     | Manages transactions      |

-- Episode 02 → DDL (CREATE TABLE)
-- Episode 03 → DML (INSERT, UPDATE, DELETE) + DDL (ALTER)
-- Episode 04 → DQL (SELECT)
