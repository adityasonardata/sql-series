Topic: ALTER TABLE
--  What is ALTER TABLE?
-- ------------------------------------------------
-- ALTER TABLE is a DDL command.
-- It modifies the STRUCTURE of an existing table.
-- Use it when you need to:
--   → Add a new column
--   → Remove a column
--   → Change a column's data type or size
--   → Rename a column
--   → Rename the table itself
--
-- IMPORTANT: ALTER TABLE changes structure,
-- not the data inside rows.
-- ------------------------------------------------

USE store_db;


-- ================================================
-- 1. ADD a new column
-- ================================================

-- Add a city column to customers
ALTER TABLE customers
ADD COLUMN city VARCHAR(50);

-- Verify — new column appears at the end
DESCRIBE customers;

-- Existing rows will have NULL in the new column
SELECT * FROM customers;

-- Fill in the city for existing customers
UPDATE customers SET city = 'Pune'      WHERE customer_id = 1;
UPDATE customers SET city = 'Mumbai'    WHERE customer_id = 2;
UPDATE customers SET city = 'Delhi'     WHERE customer_id = 3;
UPDATE customers SET city = 'Nagpur'    WHERE customer_id = 4;
UPDATE customers SET city = 'Bangalore' WHERE customer_id = 5;
UPDATE customers SET city = 'Hyderabad' WHERE customer_id = 6;

SELECT * FROM customers;


-- ================================================
-- ADD column at a specific position
-- ================================================

-- Add discount column AFTER price in products
ALTER TABLE products
ADD COLUMN discount DECIMAL(5,2) DEFAULT 0.00 AFTER price;

DESCRIBE products;

DROP TABLE IF EXISTS demo_position; -- cleanup if exists


-- ================================================
-- 2. MODIFY a column — change type or size
-- ================================================

-- Increase phone number size from VARCHAR(20) to VARCHAR(15)
ALTER TABLE customers
MODIFY COLUMN phone VARCHAR(15);

DESCRIBE customers;

-- Change stock from INT to SMALLINT (saves space)
ALTER TABLE products
MODIFY COLUMN stock SMALLINT DEFAULT 0;

DESCRIBE products;


-- ================================================
-- 3. RENAME a column
-- ================================================

-- Rename 'city' to 'customer_city' in customers
ALTER TABLE customers
RENAME COLUMN city TO customer_city;

DESCRIBE customers;

-- Rename it back
ALTER TABLE customers
RENAME COLUMN customer_city TO city;

DESCRIBE customers;


-- ================================================
-- 4. DROP a column — permanent removal
-- ================================================

-- Remove the discount column we added earlier
ALTER TABLE products
DROP COLUMN discount;

DESCRIBE products;

-- ⚠️ DROP COLUMN is permanent.
-- The column AND all its data are gone.
-- No undo. Always be sure before running this.


-- ================================================
-- 5. RENAME the table itself
-- ================================================

-- Rename customers to clients
ALTER TABLE customers
RENAME TO clients;

SHOW TABLES;

-- Rename it back
ALTER TABLE clients
RENAME TO customers;

SHOW TABLES;


-- ================================================
-- 6. ADD a constraint to existing table
-- ================================================

-- Add a NOT NULL constraint to city column
ALTER TABLE customers
MODIFY COLUMN city VARCHAR(50) NOT NULL;

-- Add a CHECK constraint to an existing column
ALTER TABLE products
ADD CONSTRAINT chk_stock CHECK (stock >= 0);

DESCRIBE customers;
DESCRIBE products;


-- ================================================
-- 7. DROP a constraint
-- ================================================

-- Drop the check constraint we just added
ALTER TABLE products
DROP CONSTRAINT chk_stock;


-- ================================================
-- ALTER TABLE — QUICK REFERENCE
-- ================================================

-- ADD column      → ALTER TABLE t ADD COLUMN col datatype;
-- MODIFY column   → ALTER TABLE t MODIFY COLUMN col new_datatype;
-- RENAME column   → ALTER TABLE t RENAME COLUMN old TO new;
-- DROP column     → ALTER TABLE t DROP COLUMN col;
-- RENAME table    → ALTER TABLE t RENAME TO new_name;
-- ADD constraint  → ALTER TABLE t ADD CONSTRAINT name CHECK (...);
-- DROP constraint → ALTER TABLE t DROP CONSTRAINT name;


-- ================================================
-- ALTER TABLE — THINGS TO REMEMBER
-- ================================================

-- 1. ALTER TABLE is DDL — it changes structure, not data
-- 2. Adding a column fills existing rows with NULL by default
-- 3. MODIFY can change data type — be careful with data loss
-- 4. DROP COLUMN is permanent — no undo
-- 5. Always run DESCRIBE after ALTER to verify the change
-- 6. On large tables, ALTER TABLE can be slow — plan carefully
