Database Design & Table Creation
-- Topic: Data Types Reference
-- SQL DATA TYPES — QUICK REFERENCE
-- ------------------------------------------------
-- Every column in a table must have a data type.
-- It tells MySQL what KIND of data the column stores.
-- Choosing the right type matters for:
--   → Storage efficiency
--   → Data integrity
--   → Query performance
-- ------------------------------------------------


-- ================================================
-- 1. INT — Whole Numbers
-- ================================================
-- Use for: IDs, age, quantity, count
-- Cannot store decimals
-- Range: -2,147,483,648 to 2,147,483,647

CREATE TABLE demo_int (
    customer_id  INT,           -- standard integer
    age          INT,           -- whole number only
    quantity     INT            -- no decimals allowed
);

-- Examples of valid INT values
-- 1, 25, 100, 9999

-- Examples of INVALID INT values
-- 1.5, 'hello', '25'

DROP TABLE demo_int;


-- ================================================
-- 2. DECIMAL(p, s) — Numbers with Decimals
-- ================================================
-- Use for: price, salary, weight, percentage
-- p = total digits, s = digits after decimal
-- DECIMAL(10, 2) → up to 99,999,999.99

CREATE TABLE demo_decimal (
    price        DECIMAL(10, 2),   -- e.g. 75000.00
    salary       DECIMAL(12, 2),   -- e.g. 150000.00
    percentage   DECIMAL(5, 2)     -- e.g. 98.75
);

-- Examples of valid DECIMAL(10,2) values
-- 75000.00, 1200.50, 0.99

-- Do NOT use INT for prices — you will lose decimal data
-- Do NOT use VARCHAR for prices — you cannot do math on it

DROP TABLE demo_decimal;


-- ================================================
-- 3. VARCHAR(n) — Variable Length Text
-- ================================================
-- Use for: names, emails, addresses, descriptions
-- n = maximum number of characters allowed
-- Only uses as much space as needed (variable)

CREATE TABLE demo_varchar (
    first_name   VARCHAR(50),    -- max 50 characters
    email        VARCHAR(100),   -- max 100 characters
    address      VARCHAR(255)    -- max 255 characters
);

-- Examples of valid VARCHAR values
-- 'Rahul', 'rahul@gmail.com', 'Flat 4B, MG Road, Pune'

-- CHAR(n) vs VARCHAR(n)
-- CHAR(n)    → fixed length, always uses n characters (use for codes like 'IN', 'US')
-- VARCHAR(n) → variable length, uses only what it needs (use for names, emails)

DROP TABLE demo_varchar;


-- ================================================
-- 4. DATE / DATETIME — Dates and Times
-- ================================================
-- DATE     → date only          format: YYYY-MM-DD
-- DATETIME → date + time        format: YYYY-MM-DD HH:MM:SS
-- TIME     → time only          format: HH:MM:SS
-- YEAR     → year only          format: YYYY

CREATE TABLE demo_dates (
    order_date       DATE,         -- e.g. 2024-01-15
    created_at       DATETIME,     -- e.g. 2024-01-15 10:30:00
    delivery_time    TIME,         -- e.g. 14:30:00
    joining_year     YEAR          -- e.g. 2024
);

-- Do NOT store dates as VARCHAR — you cannot sort or compare them properly
-- Always use DATE/DATETIME for anything related to time

DROP TABLE demo_dates;


-- ================================================
-- 5. BOOLEAN — True or False
-- ================================================
-- Use for: flags, yes/no fields, active/inactive
-- Stores TRUE (1) or FALSE (0)
-- MySQL stores BOOLEAN as TINYINT(1) internally

CREATE TABLE demo_boolean (
    is_active        BOOLEAN,     -- TRUE or FALSE
    is_verified      BOOLEAN,     -- 1 or 0
    has_premium      BOOLEAN
);

-- Examples of valid BOOLEAN values
-- TRUE, FALSE, 1, 0

DROP TABLE demo_boolean;


-- ================================================
-- SUMMARY — When to use what
-- ================================================

-- INT          → IDs, age, quantity, counts
-- DECIMAL      → price, salary, any number with decimals
-- VARCHAR      → names, emails, text of variable length
-- CHAR         → fixed codes like country code 'IN', gender 'M'
-- DATE         → order date, date of birth
-- DATETIME     → created_at timestamps, login time
-- BOOLEAN      → is_active, is_verified, has_paid
