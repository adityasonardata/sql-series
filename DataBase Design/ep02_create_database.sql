Database Design & Table Creation
--
Topic: Create Database
-- ================================================
-- 
STEP 1: Create the database
-- ------------------------------------------------

CREATE DATABASE store_db;


-- ------------------------------------------------
-- STEP 2: Select the database to use
-- Always run USE before writing any queries
-- ------------------------------------------------

USE store_db;


-- ------------------------------------------------
-- STEP 3: Confirm you are in the right database
-- ------------------------------------------------

SELECT DATABASE();

-- Expected output: store_db


-- ------------------------------------------------
-- STEP 4: See all existing databases on your server
-- ------------------------------------------------

SHOW DATABASES;
