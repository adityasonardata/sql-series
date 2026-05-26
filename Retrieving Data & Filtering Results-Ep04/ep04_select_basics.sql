  SELECT ALL COLUMNS
-- ─────────────────────────────────────
SELECT * FROM customers;

-- * = all columns
-- Avoid in production — always name your columns

-- ─────────────────────────────────────
-- SELECT SPECIFIC COLUMNS
-- ─────────────────────────────────────
SELECT first_name, last_name, city
FROM customers;

SELECT product_name, category, price
FROM products;

-- ─────────────────────────────────────
-- 

COLUMN ALIASES — rename output columns
-- ─────────────────────────────────────
SELECT
    first_name  AS 'First Name',
    last_name   AS 'Last Name',
    city        AS 'City'
FROM customers;



SELECT
    product_name  AS 'Product',
    price         AS 'Price (₹)',
    stock         AS 'In Stock'
FROM products;

-- ─────────────────────────────────────
-- 

ORDER BY — sort results
-- ─────────────────────────────────────

-- A to Z
SELECT first_name, city
FROM customers
ORDER BY first_name ASC;

-- Most expensive first
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- Sort by multiple columns
-- Sorts by city first, then by name within each city
SELECT first_name, last_name, city
FROM customers
ORDER BY city ASC, first_name ASC;

-- ─────────────────────────────────────
-- 

LIMIT — control number of rows returned
-- ─────────────────────────────────────

-- Top 5 most expensive products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- Skip first 5, get next 5 — useful for pagination


SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5 OFFSET 5;

-- Top 3 most recent orders
SELECT order_id, customer_id, order_date, status
FROM orders
ORDER BY order_date DESC
LIMIT 3;
