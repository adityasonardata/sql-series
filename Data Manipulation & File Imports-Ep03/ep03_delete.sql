What is DELETE?
-- ------------------------------------------------
-- DELETE removes rows from a table permanently.
-- Unlike DROP (which removes the whole table),
-- DELETE only removes specific rows of data.
-- The table structure remains intact.
--
-- SYNTAX:
-- DELETE FROM table_name
-- WHERE condition;
--
-- ⚠️  ALWAYS use WHERE with DELETE.
-- Without WHERE — every single row gets deleted.
-- ------------------------------------------------

USE store_db;


-- ================================================
-- BASIC DELETE — remove a specific row
-- ================================================

-- Delete a specific order
DELETE FROM orders
WHERE order_id = 10;

-- Verify it's gone
SELECT * FROM orders;


-- ================================================
-- DELETE — remove multiple rows with condition
-- ================================================

-- Delete all cancelled orders
DELETE FROM orders
WHERE status = 'Cancelled';

SELECT * FROM orders;


-- ================================================
-- DELETE — with multiple conditions
-- ================================================

-- Delete pending orders placed before February 2024
DELETE FROM orders
WHERE  status = 'Pending'
AND    order_date < '2024-02-01';

SELECT * FROM orders;


-- ================================================
-- ⚠️  FK CONSTRAINT — you cannot delete a parent
--     row if child rows still reference it
-- ================================================

-- Try deleting customer Rahul (customer_id = 1)
-- who still has orders in the orders table

-- This will FAIL
-- DELETE FROM customers WHERE customer_id = 1;
-- ERROR: Cannot delete or update a parent row:
--        a foreign key constraint fails

-- WHY? Because orders table has rows where
-- customer_id = 1. Deleting Rahul would leave
-- orphan orders with no customer.

-- CORRECT WAY: Delete child rows first, then parent

-- Step 1 — delete Rahul's orders first
DELETE FROM orders
WHERE customer_id = 1;

-- Step 2 — now delete Rahul safely
DELETE FROM customers
WHERE customer_id = 1;

-- Verify
SELECT * FROM customers;
SELECT * FROM orders WHERE customer_id = 1;

-- Re-insert Rahul so our dataset stays complete
INSERT INTO customers (first_name, last_name, email, phone, city)
VALUES ('Rahul', 'Sharma', 'rahul.sharma@gmail.com', '9876543210', 'Pune');

INSERT INTO orders (customer_id, product_id, quantity, order_date, status)
VALUES
    (7, 1, 1, '2024-01-05', 'Delivered'),
    (7, 3, 2, '2024-02-01', 'Processing');


-- ================================================
-- ⚠️  DANGEROUS: DELETE WITHOUT WHERE
-- ================================================
-- This deletes ALL rows from the table.
-- The table structure remains but it is empty.

-- DO NOT run this:
-- DELETE FROM orders;
-- This would wipe all 100 orders

-- SAFE PRACTICE: Run SELECT first to see
-- exactly what rows will be deleted

SELECT * FROM orders WHERE status = 'Pending';
-- If output looks correct — then DELETE

DELETE FROM orders
WHERE status = 'Pending';


-- ================================================
-- DELETE vs TRUNCATE vs DROP
-- ================================================

-- DELETE   → removes specific rows (use WHERE)
--            table structure stays
--            can be used with WHERE condition
--            slower on large tables

-- TRUNCATE → removes ALL rows instantly
--            table structure stays
--            cannot use WHERE
--            faster than DELETE for wiping all data
--            resets AUTO_INCREMENT counter

-- DROP     → removes the entire table
--            structure + data both gone
--            cannot be undone

-- Example:
-- TRUNCATE TABLE orders;   -- wipes all orders, keeps table
-- DROP TABLE orders;       -- deletes the orders table entirely


-- ================================================
-- DELETE — THINGS TO REMEMBER
-- ================================================

-- 1. Always use WHERE — otherwise all rows are deleted
-- 2. Run SELECT first to preview what will be deleted
-- 3. Delete child rows before parent rows (FK order)
-- 4. DELETE removes rows — table still exists
-- 5. TRUNCATE is faster but cannot use WHERE
-- 6. DROP removes the entire table permanently
