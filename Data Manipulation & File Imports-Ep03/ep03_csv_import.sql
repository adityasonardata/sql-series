Why Import CSV Files?
-- ------------------------------------------------
-- Real-world data rarely comes row by row.
-- It comes as Excel exports, CSV dumps,
-- reports from other systems — bulk files.
-- Importing lets you load hundreds or thousands
-- of rows in seconds instead of writing
-- individual INSERT statements.
-- ------------------------------------------------

USE store_db;


-- ================================================
-- METHOD 1 — MySQL Workbench Import Wizard
-- ================================================
-- This is the easiest method — no code needed.
-- Best for beginners.
--
-- STEPS:
-- 1. In left panel → expand store_db → Tables
-- 2. Right-click on 'customers'
-- 3. Click → Table Data Import Wizard
-- 4. Browse → select customers.csv → Click Next
-- 5. Workbench detects columns automatically
-- 6. Map source columns to table columns
-- 7. Click Next → Next → Finish
--
-- Repeat for products.csv and orders.csv
-- Remember the order: customers → products → orders
-- ================================================


-- ================================================
-- METHOD 2 — LOAD DATA INFILE (SQL Command)
-- ================================================
-- Faster method using SQL directly.
-- Good for large files and automation.
--
-- NOTE: You may need to set the file path
-- to the correct location on your system.
-- Use forward slashes / even on Windows.
-- ================================================

-- Load customers
LOAD DATA INFILE 'C:/datasets/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, first_name, last_name, email, phone, city);

-- Load products
LOAD DATA INFILE 'C:/datasets/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id, product_name, category, price, stock);

-- Load orders (import customers + products FIRST)
LOAD DATA INFILE 'C:/datasets/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, customer_id, product_id, quantity, order_date, status);


-- ================================================
-- VERIFY THE IMPORT
-- ================================================

-- Check row counts
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products  FROM products;
SELECT COUNT(*) AS total_orders    FROM orders;

-- Preview first 10 rows of each table
SELECT * FROM customers LIMIT 10;
SELECT * FROM products  LIMIT 10;
SELECT * FROM orders    LIMIT 10;

-- Check all distinct cities imported
SELECT DISTINCT city FROM customers ORDER BY city;

-- Check all distinct categories
SELECT DISTINCT category FROM products ORDER BY category;

-- Check all distinct order statuses
SELECT DISTINCT status FROM orders ORDER BY status;


-- ================================================
-- COMMON IMPORT ERRORS & FIXES
-- ================================================

-- ERROR: File not found
-- FIX: Check the file path — use forward slashes /
--      Make sure the file is in the right location

-- ERROR: Data truncated for column
-- FIX: The data is longer than the column size
--      ALTER TABLE to increase the column size

-- ERROR: FK constraint fails during orders import
-- FIX: Import customers and products first
--      Make sure all customer_id and product_id values exist

-- ERROR: Duplicate entry for key
-- FIX: Table already has data — either clear it first
--      TRUNCATE TABLE customers;
--      or use IGNORE keyword in LOAD DATA

-- Load with IGNORE to skip duplicate rows
-- LOAD DATA INFILE 'C:/datasets/customers.csv'
-- IGNORE INTO TABLE customers ...


-- ================================================
-- TRUNCATE before re-importing (if needed)
-- ================================================
-- If you want to re-import fresh data,
-- clear the tables first (order matters due to FK)

-- TRUNCATE TABLE orders;    -- clear orders first
-- TRUNCATE TABLE products;  -- then products
-- TRUNCATE TABLE customers; -- then customers

-- Then re-import in order:
-- customers → products → orders


-- ================================================
-- CSV IMPORT — THINGS TO REMEMBER
-- ================================================

-- 1. Always import in order: customers → products → orders
-- 2. CSV first row is usually headers — use IGNORE 1 ROWS
-- 3. FIELDS TERMINATED BY ',' for standard CSV
-- 4. ENCLOSED BY '"' for fields that contain commas
-- 5. Check COUNT(*) after import to verify row counts
-- 6. Workbench Import Wizard is easier for beginners
-- 7. LOAD DATA INFILE is faster for large files
