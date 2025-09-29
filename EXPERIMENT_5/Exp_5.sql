-- Performance Benchmarking (Medium Level)

CREATE TABLE txn_data (
    id INT,
    val INT
);

-- Insert 1 million rows for id=1
INSERT INTO txn_data (id, val)
SELECT 1, (random() * 1000)
FROM generate_series(1, 1000000);

-- Insert 1 million rows for id=2
INSERT INTO txn_data (id, val)
SELECT 2, (random() * 1000)
FROM generate_series(1, 1000000);

SELECT COUNT(*) FROM txn_data;

-- Normal View
CREATE OR REPLACE VIEW v_sales AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(val) AS total_sales,
    AVG(val) AS avg_txn
FROM txn_data
GROUP BY id;

SELECT * FROM v_sales;

-- Check Performance (Normal View)
EXPLAIN ANALYZE SELECT * FROM v_sales;


-- Materialized View
CREATE MATERIALIZED VIEW mv_sales AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(val) AS total_sales,
    AVG(val) AS avg_txn
FROM txn_data
GROUP BY id;

SELECT * FROM mv_sales;

-- Check Performance (Materialized View)
EXPLAIN ANALYZE SELECT * FROM mv_sales;




-- Securing Data Access with Views and Role-Based Permissions (Hard Level)

CREATE TABLE cust (
    cid SERIAL PRIMARY KEY,
    cname VARCHAR(100)
);

CREATE TABLE prod (
    pid SERIAL PRIMARY KEY,
    pname VARCHAR(100),
    price NUMERIC(10,2)
);

CREATE TABLE orders (
    oid SERIAL PRIMARY KEY,
    cid INT REFERENCES cust(cid),
    pid INT REFERENCES prod(pid),
    odate DATE,
    qty INT,
    disc NUMERIC(5,2)
);

INSERT INTO cust (cname) VALUES
('Ravi Kumar'),
('Tanya Verma'),
('Alok Kumar'),
('Neha Sharma');

INSERT INTO prod (pname, price) VALUES
('Laptop', 60000),
('Keyboard', 1200),
('Monitor', 15000),
('Mouse', 800);

INSERT INTO orders (cid, pid, odate, qty, disc) VALUES
(1, 1, '2025-09-01', 1, 10),
(2, 2, '2025-09-02', 2, 5),
(3, 3, '2025-09-03', 1, 20),
(4, 4, '2025-09-05', 3, 15);


-- Create View
CREATE OR REPLACE VIEW v_order AS
SELECT 
    o.oid,
    o.odate,
    p.pname,
    c.cname,
    (p.price * o.qty) - ((p.price * o.qty) * o.disc / 100) AS final_cost
FROM cust AS c
JOIN orders AS o ON o.cid = c.cid
JOIN prod AS p ON p.pid = o.pid;

-- Create Restricted role/user (ravi)
CREATE ROLE ravi LOGIN PASSWORD '1234';

-- ravi logs in and runs (In new query window)
SELECT * FROM v_order; -- permission denied initially

-- Grant access to ravi
GRANT SELECT ON v_order TO ravi;
SELECT * FROM v_order; -- now ravi can view

SELECT * FROM cust; -- ravi can't view base tables

-- Revoke access from ravi
REVOKE SELECT ON v_order FROM ravi;
SELECT * FROM v_order; -- now ravi can't view
