
-- Topic: GROUP BY

USE store_db;

-- ─────────────────────────────────────
-- GROUP BY — aggregate PER group
-- Without GROUP BY → one result for whole table
-- With GROUP BY    → one result per group
-- ─────────────────────────────────────

-- Customers per city
SELECT   city,
         COUNT(*) AS total_customers
FROM     customers
GROUP BY city
ORDER BY total_customers DESC;

-- Orders per status
SELECT   status,
         COUNT(*) AS total_orders
FROM     orders
GROUP BY status
ORDER BY total_orders DESC;

-- Product summary per category
SELECT   category,
         COUNT(*)              AS total_products,
         ROUND(AVG(price), 2)  AS avg_price,
         MAX(price)            AS highest_price,
         MIN(price)            AS lowest_price
FROM     products
GROUP BY category
ORDER BY avg_price DESC;

-- Total quantity sold per product
SELECT   product_id,
         COUNT(*)       AS times_ordered,
         SUM(quantity)  AS total_qty_sold
FROM     orders
GROUP BY product_id
ORDER BY total_qty_sold DESC;

-- Orders per month
SELECT   MONTH(order_date)  AS order_month,
         COUNT(*)            AS total_orders,
         SUM(quantity)       AS total_items
FROM     orders
GROUP BY MONTH(order_date)
ORDER BY order_month;

-- Orders per status per month
SELECT   MONTH(order_date)  AS order_month,
         status,
         COUNT(*)            AS total_orders
FROM     orders
GROUP BY MONTH(order_date), status
ORDER BY order_month, total_orders DESC;

-- ─────────────────────────────────────
-- RULES FOR GROUP BY
-- ─────────────────────────────────────
-- 1. Every column in SELECT must either be:
--    → Inside an aggregate function (COUNT, SUM etc.)
--    → OR listed in GROUP BY
-- 2. You can GROUP BY multiple columns
-- 3. ORDER BY goes AFTER GROUP BY
-- 4. WHERE goes BEFORE GROUP BY
