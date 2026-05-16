What is UPDATE?
-- ------------------------------------------------
-- UPDATE modifies existing data in a table.
-- Use it when data changes — price updates,
-- address changes, order status changes etc.
--
-- SYNTAX:
-- UPDATE table_name
-- SET    column1 = value1, column2 = value2
-- WHERE  condition;
--
-- ⚠️  ALWAYS use WHERE with UPDATE.
-- Without WHERE — every single row gets updated.
-- ------------------------------------------------

USE store_db;


-- ================================================
-- BASIC UPDATE — single column
-- ================================================

-- Rahul changed his phone number
UPDATE customers
SET    phone = '9999999999'
WHERE  customer_id = 1;

-- Verify the change
SELECT * FROM customers WHERE customer_id = 1;


-- ================================================
-- UPDATE — multiple columns at once
-- ================================================

-- iPhone 15 price dropped + stock was restocked
UPDATE products
SET    price = 72000.00,
       stock = 60
WHERE  product_id = 1;

-- Verify
SELECT * FROM products WHERE product_id = 1;


-- ================================================
-- UPDATE — using a condition on text
-- ================================================

-- All products in 'Furniture' category get 10% price cut
UPDATE products
SET    price = price * 0.90
WHERE  category = 'Furniture';

-- Verify
SELECT * FROM products WHERE category = 'Furniture';


-- ================================================
-- UPDATE — order status change
-- ================================================

-- Order 1 has been delivered
UPDATE orders
SET    status = 'Delivered'
WHERE  order_id = 1;

-- Multiple orders shipped at once
UPDATE orders
SET    status = 'Shipped'
WHERE  order_id IN (2, 3, 4);

-- Verify
SELECT * FROM orders;


-- ================================================
-- UPDATE — using calculation
-- ================================================

-- Reduce stock by quantity ordered for order_id 5
UPDATE products
SET    stock = stock - 1
WHERE  product_id = 5;

-- Increase stock after a restock delivery
UPDATE products
SET    stock = stock + 100
WHERE  product_id = 8;

SELECT * FROM products WHERE product_id IN (5, 8);


-- ================================================
-- ⚠️  DANGEROUS: UPDATE WITHOUT WHERE
-- ================================================
-- This updates EVERY row in the table.
-- There is no undo in MySQL by default.
-- Always double check your WHERE clause first.

-- DO NOT run this unless you intend to:
-- UPDATE orders SET status = 'Cancelled';
-- This would set ALL orders to Cancelled

-- SAFE PRACTICE: Run SELECT first to preview
-- what rows will be affected before you UPDATE

SELECT * FROM orders WHERE status = 'Pending';
-- If the output looks right — then run UPDATE

UPDATE orders
SET    status = 'Processing'
WHERE  status = 'Pending';

SELECT * FROM orders;


-- ================================================
-- UPDATE — with multiple conditions
-- ================================================

-- Only update orders that are Pending AND placed before Feb 2024
UPDATE orders
SET    status = 'Cancelled'
WHERE  status  = 'Pending'
AND    order_date < '2024-02-01';

SELECT * FROM orders;


-- ================================================
-- UPDATE — THINGS TO REMEMBER
-- ================================================

-- 1. Always use WHERE — otherwise all rows are updated
-- 2. Run SELECT first to preview affected rows
-- 3. You can update multiple columns in one SET
-- 4. You can use math: SET price = price * 0.9
-- 5. You can use IN for multiple specific rows
-- 6. Changes are immediate — no undo by default
