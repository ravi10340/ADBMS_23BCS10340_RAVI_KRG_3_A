-- HR-Analytics: Employee count based on dynamic gender (Medium)

CREATE TABLE emp (
    eid SERIAL PRIMARY KEY,
    ename VARCHAR(100),
    gender VARCHAR(10)
);

INSERT INTO emp (ename, gender) VALUES
('Ravi Kumar', 'Male'),
('Tanya Verma', 'Female'),
('Alok Kumar', 'Male'),
('Neha Singh', 'Female'),
('Devanshu Ranjan', 'Male');

-- Procedure: count employees by gender
CREATE OR REPLACE PROCEDURE get_emp_count(
    IN in_gender VARCHAR,
    OUT gcount INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*)
    INTO gcount
    FROM emp
    WHERE LOWER(gender) = LOWER(in_gender);

    RAISE NOTICE 'Total employees with gender % = %', in_gender, gcount;
END;
$$;

-- Calls
CALL get_emp_count('Male', NULL);
CALL get_emp_count('Female', NULL);




-- SmartStore: Automated Purchase System (Hard)

CREATE TABLE prod (
    pid SERIAL PRIMARY KEY,
    pname VARCHAR(100),
    price NUMERIC(10,2),
    qty_rem INT,
    qty_sold INT DEFAULT 0
);

CREATE TABLE sale (
    sid SERIAL PRIMARY KEY,
    pid INT REFERENCES prod(pid),
    qty INT,
    total NUMERIC(10,2),
    sdate TIMESTAMP DEFAULT NOW()
);

INSERT INTO prod (pname, price, qty_rem) VALUES
('Smartphone', 25000, 10),
('Tablet', 18000, 5),
('Laptop', 55000, 3);

-- Procedure: process order
CREATE OR REPLACE PROCEDURE order_proc(
    IN in_pid INT,
    IN in_qty INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    avail INT;
    uprice NUMERIC(10,2);
    tot NUMERIC(10,2);
BEGIN
    -- Fetch stock and price
    SELECT qty_rem, price
    INTO avail, uprice
    FROM prod
    WHERE pid = in_pid;

    IF avail IS NULL THEN
        RAISE NOTICE 'Product not found!';
        RETURN;
    END IF;

    -- Check stock
    IF avail >= in_qty THEN
        tot := uprice * in_qty;

        -- Log sale
        INSERT INTO sale(pid, qty, total)
        VALUES (in_pid, in_qty, tot);

        -- Update stock
        UPDATE prod
        SET qty_rem = qty_rem - in_qty,
            qty_sold = qty_sold + in_qty
        WHERE pid = in_pid;

        RAISE NOTICE 'Product sold successfully!';
    ELSE
        RAISE NOTICE 'Insufficient stock!';
    END IF;
END;
$$;

-- Test
SELECT * FROM prod;

CALL order_proc(1, 2);
SELECT * FROM prod;

CALL order_proc(3, 10);
