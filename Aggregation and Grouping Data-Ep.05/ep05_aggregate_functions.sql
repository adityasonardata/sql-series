
-- Topic: Aggregate Functions — COUNT, SUM, AVG, MAX, MIN

USE store_db;

-- ─────────────────────────────────────
-- COUNT — how many rows?
-- ─────────────────────────────────────

-- Count all rows
SELECT COUNT(*) AS total_customers FROM customers;

-- COUNT(*) vs COUNT(column)
-- COUNT(*)       → counts ALL rows including NULLs
-- COUNT(column)  → counts only NON-NULL values

SELECT COUNT(phone) AS customers_with_phone FROM customers;

SELECT COUNT(*) - COUNT(phone) AS customers_without_phone FROM customers;

-- Count with WHERE filter
SELECT COUNT(*) AS delivered_orders
FROM orders
WHERE status = 'Delivered';

-- Count unique values
SELECT COUNT(DISTINCT city) AS unique_cities FROM customers;
SELECT COUNT(DISTINCT category) AS unique_categories FROM products;


-- ─────────────────────────────────────
-- SUM — add up values
-- ─────────────────────────────────────

-- Total inventory value
SELECT SUM(price * stock) AS total_inventory_value FROM products;

-- Total items ordered
SELECT SUM(quantity) AS total_items_ordered FROM orders;

-- Total items in delivered orders only
SELECT SUM(quantity) AS delivered_items
FROM orders
WHERE status = 'Delivered';


-- ─────────────────────────────────────
-- AVG — calculate average
-- ─────────────────────────────────────

-- Average product price
SELECT ROUND(AVG(price), 2) AS avg_price FROM products;

-- Average price per category filter
SELECT ROUND(AVG(price), 2) AS avg_electronics_price
FROM products
WHERE category = 'Electronics';

-- Average quantity per order
SELECT ROUND(AVG(quantity), 1) AS avg_order_quantity FROM orders;


-- ─────────────────────────────────────
-- MAX & MIN — highest and lowest
-- ─────────────────────────────────────

-- Most and least expensive products
SELECT
    MAX(price) AS most_expensive,
    MIN(price) AS least_expensive
FROM products;

-- Date range of orders
SELECT
    MAX(order_date) AS latest_order,
    MIN(order_date) AS earliest_order
FROM orders;

-- Largest single order quantity
SELECT MAX(quantity) AS biggest_order FROM orders;


-- ─────────────────────────────────────
-- ALL FIVE TOGETHER — summary queries
-- ─────────────────────────────────────

-- Full product summary
SELECT
    COUNT(*)               AS total_products,
    ROUND(AVG(price), 2)   AS avg_price,
    SUM(stock)             AS total_stock,
    MAX(price)             AS highest_price,
    MIN(price)             AS lowest_price
FROM products;

-- Full orders summary
SELECT
    COUNT(*)                  AS total_orders,
    SUM(quantity)             AS total_items,
    ROUND(AVG(quantity), 1)   AS avg_items_per_order,
    MAX(quantity)             AS largest_order,
    MIN(quantity)             AS smallest_order
FROM orders;
