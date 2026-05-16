INSERT adds new rows of data into a table.
-- This is how you populate your tables with data.
--
-- SYNTAX:
-- INSERT INTO table_name (column1, column2, ...)
-- VALUES (value1, value2, ...);
-- ------------------------------------------------

USE store_db;


-- ================================================
-- IMPORTANT: INSERT ORDER MATTERS
-- ================================================
-- Because of FOREIGN KEYS in the orders table:
--   orders.customer_id → references customers
--   orders.product_id  → references products
--
-- You MUST insert in this order:
--   1. customers first
--   2. products second
--   3. orders last
--
-- Inserting orders before customers/products
-- will throw a FOREIGN KEY constraint error.
-- ================================================


-- ================================================
-- INSERT INTO customers
-- ================================================

-- Single row insert
INSERT INTO customers (first_name, last_name, email, phone, city)
VALUES ('Rahul', 'Sharma', 'rahul.sharma@gmail.com', '9876543210', 'Pune');

-- Note: customer_id is AUTO_INCREMENT — MySQL fills it automatically
-- Note: created_at has DEFAULT CURRENT_DATE — fills automatically too

-- Check what was inserted
SELECT * FROM customers;


-- ================================================
-- INSERT MULTIPLE ROWS — one statement
-- ================================================
-- Much more efficient than running separate INSERTs
-- All rows go in one single query

INSERT INTO customers (first_name, last_name, email, phone, city)
VALUES
    ('Priya',  'Mehta',  'priya.mehta@gmail.com',  '9823456789', 'Mumbai'),
    ('Ankit',  'Joshi',  'ankit.joshi@gmail.com',  '9812345678', 'Delhi'),
    ('Sneha',  'Patil',  'sneha.patil@gmail.com',  '9856789012', 'Nagpur'),
    ('Vikram', 'Singh',  'vikram.singh@gmail.com',  '9845678901', 'Bangalore'),
    ('Pooja',  'Rao',    'pooja.rao@gmail.com',     '9834567890', 'Hyderabad');

SELECT * FROM customers;
-- customer_id auto increments: 1, 2, 3, 4, 5, 6


-- ================================================
-- INSERT INTO products
-- ================================================

INSERT INTO products (product_name, category, price, stock)
VALUES
    ('iPhone 15',            'Electronics', 75000.00,  50),
    ('MacBook Air M2',       'Electronics', 120000.00, 30),
    ('Sony WH-1000XM5',      'Electronics', 8500.00,   100),
    ('Samsung Galaxy S23',   'Electronics', 65000.00,  45),
    ('Dell XPS 15 Laptop',   'Electronics', 110000.00, 25),
    ('Office Chair ErgoMax', 'Furniture',   12000.00,  20),
    ('Study Table Wooden',   'Furniture',   8500.00,   18),
    ('Notebook Pack 6',      'Stationery',  350.00,    500),
    ('Pen Set Parker',       'Stationery',  1200.00,   300),
    ('Atomic Habits Book',   'Books',       450.00,    180);

SELECT * FROM products;


-- ================================================
-- WHAT HAPPENS WITH A FK VIOLATION?
-- ================================================
-- Try inserting an order for a customer that
-- does not exist — MySQL will reject it

-- This will FAIL
-- INSERT INTO orders (customer_id, product_id, quantity)
-- VALUES (999, 1, 1);
-- ERROR: Cannot add or update a child row:
--        a foreign key constraint fails


-- ================================================
-- INSERT INTO orders
-- ================================================
-- Now that customers and products exist,
-- we can safely insert orders

INSERT INTO orders (customer_id, product_id, quantity, order_date, status)
VALUES
    (1, 1, 1, '2024-01-05', 'Delivered'),
    (2, 2, 1, '2024-01-06', 'Delivered'),
    (3, 3, 2, '2024-01-07', 'Delivered'),
    (4, 6, 1, '2024-01-08', 'Delivered'),
    (5, 7, 1, '2024-01-09', 'Shipped'),
    (6, 8, 5, '2024-01-10', 'Shipped'),
    (1, 3, 2, '2024-02-01', 'Processing'),
    (2, 4, 1, '2024-02-02', 'Pending'),
    (3, 9, 3, '2024-02-03', 'Pending'),
    (4, 10,2, '2024-02-04', 'Pending');

SELECT * FROM orders;

-- Notice:
-- order_id    → auto filled: 1, 2, 3 ...
-- status      → we provided it here, but DEFAULT is 'Pending'
-- order_date  → we provided it here, but DEFAULT is CURRENT_DATE


-- ================================================
-- INSERT WITHOUT OPTIONAL COLUMNS
-- ================================================
-- You don't have to specify every column.
-- Columns with DEFAULT or that allow NULL
-- can be skipped.

INSERT INTO orders (customer_id, product_id, quantity)
VALUES (5, 5, 1);

-- order_date → filled with today's date (DEFAULT)
-- status     → filled with 'Pending'    (DEFAULT)

SELECT * FROM orders WHERE order_id = 11;


-- ================================================
-- INSERT — THINGS TO REMEMBER
-- ================================================

-- 1. Column list and VALUES list must match in order and count
-- 2. Text values go in single quotes → 'Rahul'
-- 3. Numbers do NOT need quotes → 75000.00
-- 4. Dates go in single quotes → '2024-01-15'
-- 5. AUTO_INCREMENT columns — never insert manually
-- 6. DEFAULT columns — can be skipped
-- 7. NOT NULL columns — must always be provided
-- 8. FK order — customers → products → orders
