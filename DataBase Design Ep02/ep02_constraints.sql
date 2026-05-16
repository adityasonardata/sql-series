Database Design & Table Creation
-- Topic: Constraints
--
What are Constraints?
-- ------------------------------------------------
-- Constraints are rules applied to columns.
-- They control what data is allowed in a table.
-- They protect your data quality automatically.
-- MySQL enforces them — bad data gets rejected.
-- ------------------------------------------------

USE store_db;


-- ================================================
-- 1. NOT NULL
-- ================================================
-- The column must always have a value.
-- Empty / NULL is not allowed.
-- ------------------------------------------------

CREATE TABLE demo_notnull (
    customer_id  INT          NOT NULL,
    first_name   VARCHAR(50)  NOT NULL,   -- required
    last_name    VARCHAR(50)  NOT NULL,   -- required
    phone        VARCHAR(20)             -- optional — NULL is allowed here
);

-- This INSERT will work fine
INSERT INTO demo_notnull (customer_id, first_name, last_name)
VALUES (1, 'Rahul', 'Sharma');

-- This INSERT will FAIL — first_name cannot be NULL
-- INSERT INTO demo_notnull (customer_id, first_name, last_name)
-- VALUES (2, NULL, 'Mehta');
-- ERROR: Column 'first_name' cannot be null

DROP TABLE demo_notnull;


-- ================================================
-- 2. UNIQUE
-- ================================================
-- All values in the column must be different.
-- No two rows can share the same value.
-- ------------------------------------------------

CREATE TABLE demo_unique (
    customer_id  INT          NOT NULL,
    email        VARCHAR(100) UNIQUE      -- no duplicate emails allowed
);

-- This will work
INSERT INTO demo_unique VALUES (1, 'rahul@gmail.com');
INSERT INTO demo_unique VALUES (2, 'priya@gmail.com');

-- This will FAIL — email already exists
-- INSERT INTO demo_unique VALUES (3, 'rahul@gmail.com');
-- ERROR: Duplicate entry 'rahul@gmail.com' for key 'email'

DROP TABLE demo_unique;


-- ================================================
-- 3. DEFAULT
-- ================================================
-- If no value is provided, MySQL automatically
-- fills in the default value you defined.
-- ------------------------------------------------

CREATE TABLE demo_default (
    order_id    INT          NOT NULL,
    status      VARCHAR(20)  DEFAULT 'Pending',           -- auto fills 'Pending'
    order_date  DATE         DEFAULT (CURRENT_DATE)       -- auto fills today's date
);

-- No status or order_date provided — defaults kick in
INSERT INTO demo_default (order_id)
VALUES (101);

-- Check what was stored
SELECT * FROM demo_default;
-- status     = 'Pending'  (filled automatically)
-- order_date = today's date (filled automatically)

-- You can still override the default
INSERT INTO demo_default (order_id, status)
VALUES (102, 'Shipped');

SELECT * FROM demo_default;

DROP TABLE demo_default;


-- ================================================
-- 4. CHECK
-- ================================================
-- Only allows values that satisfy a condition.
-- Rows that fail the condition are rejected.
-- ------------------------------------------------

CREATE TABLE demo_check (
    product_id  INT            NOT NULL,
    price       DECIMAL(10,2)  NOT NULL CHECK (price > 0),    -- must be positive
    quantity    INT            NOT NULL CHECK (quantity > 0), -- must be at least 1
    discount    DECIMAL(5,2)   CHECK (discount BETWEEN 0 AND 100) -- 0% to 100% only
);

-- This will work
INSERT INTO demo_check VALUES (1, 75000.00, 2, 10.00);

-- This will FAIL — price cannot be negative
-- INSERT INTO demo_check VALUES (2, -500.00, 1, 0);
-- ERROR: Check constraint 'demo_check_chk_1' is violated

-- This will FAIL — quantity cannot be 0
-- INSERT INTO demo_check VALUES (3, 1000.00, 0, 5);
-- ERROR: Check constraint 'demo_check_chk_2' is violated

DROP TABLE demo_check;


-- ================================================
-- 5. PRIMARY KEY
-- ================================================
-- Uniquely identifies every row in the table.
-- Combines NOT NULL + UNIQUE automatically.
-- Each table can have only ONE primary key.
-- ------------------------------------------------

CREATE TABLE demo_primarykey (
    customer_id  INT  AUTO_INCREMENT,
    first_name   VARCHAR(50) NOT NULL,
    PRIMARY KEY  (customer_id)    -- unique + not null enforced automatically
);

INSERT INTO demo_primarykey (first_name) VALUES ('Rahul');
INSERT INTO demo_primarykey (first_name) VALUES ('Priya');
INSERT INTO demo_primarykey (first_name) VALUES ('Ankit');

SELECT * FROM demo_primarykey;
-- customer_id auto fills as 1, 2, 3 — never repeats

DROP TABLE demo_primarykey;


-- ================================================
-- 6. FOREIGN KEY
-- ================================================
-- Links a column to the PRIMARY KEY of another table.
-- Prevents invalid references — referential integrity.
-- ------------------------------------------------

-- Parent table
CREATE TABLE demo_customers (
    customer_id  INT  AUTO_INCREMENT,
    name         VARCHAR(50) NOT NULL,
    PRIMARY KEY  (customer_id)
);

-- Child table with FK
CREATE TABLE demo_orders (
    order_id     INT  AUTO_INCREMENT,
    customer_id  INT  NOT NULL,
    item         VARCHAR(100),
    PRIMARY KEY  (order_id),
    FOREIGN KEY  (customer_id) REFERENCES demo_customers(customer_id)
);

-- Insert a customer first
INSERT INTO demo_customers (name) VALUES ('Rahul Sharma');

-- This works — customer_id 1 exists
INSERT INTO demo_orders (customer_id, item) VALUES (1, 'iPhone 15');

-- This will FAIL — customer_id 99 does not exist
-- INSERT INTO demo_orders (customer_id, item) VALUES (99, 'MacBook');
-- ERROR: Cannot add or update a child row: foreign key constraint fails

DROP TABLE demo_orders;
DROP TABLE demo_customers;


-- ================================================
-- CONSTRAINTS SUMMARY
-- ================================================

-- NOT NULL    → column must always have a value
-- UNIQUE      → all values in column must be different
-- DEFAULT     → auto fills value when none is provided
-- CHECK       → only allows values meeting a condition
-- PRIMARY KEY → NOT NULL + UNIQUE, identifies each row
-- FOREIGN KEY → links to PK of another table
