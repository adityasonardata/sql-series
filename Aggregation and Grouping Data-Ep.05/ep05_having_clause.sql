-- ================================================
-- SQL for Data Analysts — Zero to Advanced
-- Episode 05 | Aggregation and Grouping Data
-- Topic: HAVING Clause
-- ================================================
-- YouTube : [YOUR CHANNEL LINK]
-- GitHub  : [YOUR REPO LINK]
-- ================================================

USE store_db;

-- ─────────────────────────────────────
-- WHERE vs HAVING
-- WHERE  → filters ROWS   → runs BEFORE GROUP BY
-- HAVING → filters GROUPS → runs AFTER  GROUP BY
-- ─────────────────────────────────────

-- Cities with more than 3 customers
SELECT   city,
         COUNT(*) AS total_customers
FROM     customers
GROUP BY city
HAVING   COUNT(*) > 3
ORDER BY total_customers DESC;

-- Categories with average price above ₹10,000
SELECT   category,
         ROUND(AVG(price), 2) AS avg_price
FROM     products
GROUP BY category
HAVING   AVG(price) > 10000
ORDER BY avg_price DESC;

-- Products ordered more than 2 times
SELECT   product_id,
         COUNT(*)      AS times_ordered,
         SUM(quantity) AS total_sold
FROM     orders
GROUP BY product_id
HAVING   COUNT(*) > 2
ORDER BY times_ordered DESC;

-- ─────────────────────────────────────
-- WHERE + GROUP BY + HAVING together
-- Execution order:
-- 1. FROM   → identify the table
-- 2. WHERE  → filter rows
-- 3. GROUP BY → group filtered rows
-- 4. HAVING → filter groups
-- 5. SELECT → return result
-- 6. ORDER BY → sort final result
-- ─────────────────────────────────────

-- Electronics only, grouped, avg price > ₹50,000
SELECT   category,
         COUNT(*)              AS total_products,
         ROUND(AVG(price), 2)  AS avg_price
FROM     products
WHERE    category = 'Electronics'    -- Step 2: filter rows first
GROUP BY category                    -- Step 3: group them
HAVING   AVG(price) > 50000          -- Step 4: filter groups
ORDER BY avg_price DESC;             -- Step 6: sort

-- Months with more than 15 orders
SELECT   MONTH(order_date) AS order_month,
         COUNT(*)           AS total_orders
FROM     orders
GROUP BY MONTH(order_date)
HAVING   COUNT(*) > 15
ORDER BY total_orders DESC;

-- Statuses where total quantity sold > 20
SELECT   status,
         SUM(quantity) AS total_qty
FROM     orders
GROUP BY status
HAVING   SUM(quantity) > 20
ORDER BY total_qty DESC;

-- ─────────────────────────────────────
-- REAL ANALYST QUERIES
-- ─────────────────────────────────────

-- Top 3 cities by customer count
SELECT   city,
         COUNT(*) AS customers
FROM     customers
WHERE    city IS NOT NULL
GROUP BY city
ORDER BY customers DESC
LIMIT 3;

-- Busiest month by orders
SELECT   MONTH(order_date) AS month,
         COUNT(*)           AS orders,
         SUM(quantity)      AS items_sold
FROM     orders
GROUP BY MONTH(order_date)
ORDER BY orders DESC
LIMIT 1;

-- Which status dominates?
SELECT   status,
         COUNT(*)      AS total_orders,
         SUM(quantity) AS total_items,
         ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS pct
FROM     orders
GROUP BY status
ORDER BY total_orders DESC;
