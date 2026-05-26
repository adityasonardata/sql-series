 WHERE — filter rows by condition
-- WHERE runs BEFORE columns are selected
-- Only rows matching the condition come back
-- ─────────────────────────────────────

-- 
Customers from Mumbai only
SELECT * FROM customers
WHERE city = 'Mumbai';

-- 

Products under ₹10,000
SELECT product_name, price
FROM products
WHERE price < 10000;

-- Delivered orders only
SELECT * FROM orders
WHERE status = 'Delivered';

-- Specific date
SELECT * FROM orders
WHERE order_date = '2024-01-05';

-- ─────────────────────────────────────
-- 

COMPARISON OPERATORS
-- ─────────────────────────────────────
-- =      equal
-- != <>  not equal
-- >      greater than
-- <      less than
-- >=     greater than or equal
-- <=     less than or equal

SELECT product_name, price FROM products WHERE price = 75000;
SELECT product_name, price FROM products WHERE price != 75000;
SELECT product_name, price FROM products WHERE price > 50000;
SELECT product_name, price FROM products WHERE price < 10000;
SELECT product_name, price FROM products WHERE price >= 50000;
SELECT product_name, price FROM products WHERE price <= 10000;

-- Orders NOT cancelled
SELECT * FROM orders
WHERE status <> 'Cancelled';

-- ─────────────────────────────────────
-- 

AND — both conditions must be true
-- ─────────────────────────────────────
SELECT product_name, category, price
FROM products
WHERE category = 'Electronics'
AND   price < 50000;

SELECT * FROM orders
WHERE status    = 'Delivered'
AND   order_date < '2024-02-01';

-- ─────────────────────────────────────
-- 

OR — at least one condition must be true
-- ─────────────────────────────────────
SELECT * FROM customers
WHERE city = 'Mumbai'
OR    city = 'Pune';

SELECT * FROM orders
WHERE status = 'Pending'
OR    status = 'Processing';

-- ─────────────────────────────────────
-- 

NOT — reverses the condition
-- ─────────────────────────────────────
SELECT * FROM orders
WHERE NOT status = 'Delivered';

SELECT * FROM products
WHERE NOT category = 'Electronics';

-- ─────────────────────────────────────
-- 

COMBINING AND + OR — always use brackets!
-- ─────────────────────────────────────

-- Without brackets — risky, MySQL picks the order
SELECT * FROM products
WHERE category = 'Electronics' OR category = 'Books'
AND price < 10000;

-- 

With brackets — clear and predictable
SELECT * FROM products
WHERE (category = 'Electronics' OR category = 'Books')
AND    price < 10000;
