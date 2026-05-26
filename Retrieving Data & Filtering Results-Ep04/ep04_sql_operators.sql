BETWEEN — range filter (inclusive)
-- Includes BOTH the start and end values
-- ─────────────────────────────────────
SELECT product_name, price
FROM products
WHERE price BETWEEN 5000 AND 50000
ORDER BY price;

-- Orders placed in January 2024
SELECT * FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31';

-- NOT BETWEEN
SELECT product_name, price
FROM products
WHERE price NOT BETWEEN 5000 AND 50000
ORDER BY price;


-- ─────────────────────────────────────
-- 

IN — match against a list of values
-- Cleaner replacement for multiple ORs
-- ─────────────────────────────────────

-- Without IN — messy
SELECT * FROM customers
WHERE city = 'Mumbai'
OR    city = 'Pune'
OR    city = 'Delhi';

-- With IN — clean
SELECT * FROM customers
WHERE city IN ('Mumbai', 'Pune', 'Delhi')
ORDER BY city;

-- NOT IN
SELECT * FROM orders
WHERE status NOT IN ('Delivered', 'Cancelled');

-- IN with numbers
SELECT * FROM products
WHERE product_id IN (1, 3, 5, 7);


-- ─────────────────────────────────────
-- 

LIKE — pattern matching on text
-- %  = zero or more characters (wildcard)
-- _  = exactly one character
-- ─────────────────────────────────────

-- Starts with R
SELECT first_name, email FROM customers
WHERE first_name LIKE 'R%';

-- Ends with 'l'
SELECT first_name FROM customers
WHERE first_name LIKE '%l';

-- Contains 'an' anywhere
SELECT first_name FROM customers
WHERE first_name LIKE '%an%';

-- Gmail users only
SELECT first_name, email FROM customers
WHERE email LIKE '%@gmail.com';

-- Exactly 5 characters long
SELECT first_name FROM customers
WHERE first_name LIKE '_____';

-- 2nd character is 'a'
SELECT first_name FROM customers
WHERE first_name LIKE '_a%';

-- NOT LIKE
SELECT first_name, email FROM customers
WHERE email NOT LIKE '%gmail%';


-- ─────────────────────────────────────
-- 

IS NULL / IS NOT NULL
-- NULL = no value — not zero, not empty
-- CANNOT use = for NULL — must use IS NULL
-- ─────────────────────────────────────

-- Customers with no city entered
SELECT customer_id, first_name, email
FROM customers
WHERE city IS NULL;

-- Customers who DO have a city
SELECT customer_id, first_name, city
FROM customers
WHERE city IS NOT NULL;

-- Find incomplete records — missing phone
SELECT customer_id, first_name, email
FROM customers
WHERE phone IS NULL;


-- ─────────────────────────────────────
-- 

DISTINCT — remove duplicate values
-- ─────────────────────────────────────

-- All unique cities
SELECT DISTINCT city
FROM customers
ORDER BY city;

-- All unique categories
SELECT DISTINCT category
FROM products;

-- All unique order statuses
SELECT DISTINCT status
FROM orders;

-- Count of unique cities
SELECT COUNT(DISTINCT city) AS unique_cities
FROM customers;


-- ─────────────────────────────────────
-- 

PUTTING IT ALL TOGETHER
-- ─────────────────────────────────────

-- Electronics products between ₹5k and ₹80k
-- sorted by price, top 5 only
SELECT product_name, category, price
FROM products
WHERE  category = 'Electronics'
AND    price BETWEEN 5000 AND 80000
ORDER BY price DESC
LIMIT 5;

-- Customers from major cities
-- whose email is from gmail
-- sorted by name
SELECT first_name, last_name, city, email
FROM customers
WHERE city    IN ('Mumbai', 'Delhi', 'Bangalore', 'Hyderabad')
AND   email   LIKE '%@gmail.com'
ORDER BY first_name ASC;

-- All pending or processing orders
-- placed in Q1 2024
SELECT order_id, customer_id, status, order_date
FROM orders
WHERE status     IN ('Pending', 'Processing')
AND   order_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY order_date;
