-- Create employee and audit tables
CREATE TABLE tbl_employee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    emp_salary NUMERIC
);

CREATE TABLE tbl_employee_audit (
    sno SERIAL PRIMARY KEY,
    message TEXT
);

-- Trigger function for audit logging
CREATE OR REPLACE FUNCTION audit_employee_changes()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO tbl_employee_audit(message)
        VALUES ('Employee name ' || NEW.emp_name || ' added with salary ' || NEW.emp_salary || ' at ' || NOW());
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO tbl_employee_audit(message)
        VALUES ('Employee name ' || OLD.emp_name || ' deleted at ' || NOW());
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

-- Create trigger
CREATE TRIGGER trg_employee_audit
AFTER INSERT OR DELETE
ON tbl_employee
FOR EACH ROW
EXECUTE FUNCTION audit_employee_changes();

-- Test data insertion
INSERT INTO tbl_employee(emp_name, emp_salary) VALUES ('Sohneyo', 120000);
INSERT INTO tbl_employee(emp_name, emp_salary) VALUES ('Ravi', 110000);
INSERT INTO tbl_employee(emp_name, emp_salary) VALUES ('Hinata', 105000);

-- Delete one record
DELETE FROM tbl_employee WHERE emp_name = 'Hinata';

-- Display results
SELECT * FROM tbl_employee;
SELECT * FROM tbl_employee_audit;
