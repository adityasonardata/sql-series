Database Design & Table Creation
-- Topic: Creating All 3 Tables
-- Make sure you are using the right database
-- ------------------------------------------------

USE store_db;


-- ================================================
-- TABLE 1: customers
-- ================================================
-- Stores information about each customer.
-- customer_id is the PRIMARY KEY — uniquely
-- identifies every customer in this table.
-- ------------------------------------------------

CREATE TABLE customers (
    customer_id  INT           AUTO_INCREMENT,  -- unique ID, increases automatically
    first_name   VARCHAR(50)   NOT NULL,        -- required field
    last_name    VARCHAR(50)   NOT NULL,        -- required field
    email        VARCHAR(100)  NOT NULL UNIQUE, -- required + no duplicates
    phone        VARCHAR(20),                   -- optional
    city         VARCHAR(50),                   -- optional
    created_at   DATE          DEFAULT (CURRENT_DATE), -- auto fills today's date
    PRIMARY KEY  (customer_id)
);

-- Verify the table was created correctly
DESCRIBE customers;


-- ================================================
-- TABLE 2: products
-- ================================================
-- Stores all products available in the store.
-- product_id is the PRIMARY KEY.
-- price has a CHECK constraint — must be > 0
-- ------------------------------------------------

CREATE TABLE products (
    product_id   INT            AUTO_INCREMENT,
    product_name VARCHAR(100)   NOT NULL,
    category     VARCHAR(50),
    price        DECIMAL(10, 2) NOT NULL CHECK (price > 0), -- no negative prices
    stock        INT            DEFAULT 0,                  -- starts at 0
    PRIMARY KEY  (product_id)
);

-- Verify the table was created correctly
DESCRIBE products;


-- ================================================
-- TABLE 3: orders
-- ================================================
-- Links customers to products.
-- Has TWO foreign keys:
--   → customer_id references customers table
--   → product_id  references products table
--
-- IMPORTANT: Create customers + products FIRST
-- before creating orders — because of the FK references
-- ------------------------------------------------

CREATE TABLE orders (
    order_id     INT          AUTO_INCREMENT,
    customer_id  INT          NOT NULL,
    product_id   INT          NOT NULL,
    quantity     INT          NOT NULL CHECK (quantity > 0),
    order_date   DATE         DEFAULT (CURRENT_DATE),
    status       VARCHAR(20)  DEFAULT 'Pending',
    PRIMARY KEY  (order_id),
    FOREIGN KEY  (customer_id) REFERENCES customers(customer_id),  -- FK to customers
    FOREIGN KEY  (product_id)  REFERENCES products(product_id)     -- FK to products
);

-- Verify the table was created correctly
DESCRIBE orders;


-- ------------------------------------------------
-- See all tables in the database
-- ------------------------------------------------

SHOW TABLES;

-- Expected output:
-- customers
-- products
-- orders


-- ------------------------------------------------
-- DROP tables if you want to start over
-- (run in this order because of foreign keys)
-- ------------------------------------------------

-- DROP TABLE orders;
-- DROP TABLE products;
-- DROP TABLE customers;
