-- Create student table
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    class VARCHAR(50)
);

-- Create trigger function
CREATE OR REPLACE FUNCTION fn_student_audit()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        RAISE NOTICE 'Inserted Row -> ID: %, Name: %, Age: %, Class: %', NEW.id, NEW.name, NEW.age, NEW.class;
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        RAISE NOTICE 'Deleted Row -> ID: %, Name: %, Age: %, Class: %', OLD.id, OLD.name, OLD.age, OLD.class;
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

-- Create the trigger
CREATE TRIGGER trg_student_audit
AFTER INSERT OR DELETE
ON student
FOR EACH ROW
EXECUTE FUNCTION fn_student_audit();

-- Test data insertion
INSERT INTO student(name, age, class) VALUES ('Ravi', 22, 'B.Tech CSE');
INSERT INTO student(name, age, class) VALUES ('Rias', 21, 'BCA');
INSERT INTO student(name, age, class) VALUES ('Hinata', 20, 'B.Sc IT');

-- Delete one record
DELETE FROM student WHERE name = 'Rias';

-- Display remaining records
SELECT * FROM student;
