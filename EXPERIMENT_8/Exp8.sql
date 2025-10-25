CREATE TABLE students (
 id SERIAL PRIMARY KEY,
 name VARCHAR(50),
 age INT,
 class INT
);
DO $$
BEGIN
 BEGIN
 INSERT INTO students(name, age, class) VALUES ('Ravi', 22, 12);
 INSERT INTO students(name, age, class) VALUES ('Sohneyo', 21, 12);
 INSERT INTO students(name, age, class) VALUES ('Rias', 18, 11);
 RAISE NOTICE 'Transaction Successfully Done ';
 EXCEPTION
 WHEN OTHERS THEN
 RAISE NOTICE 'Transaction Failed..! Rolling back all changes ';
 RAISE;
DEPARTMENT OF
COMPUTER SCIENCE & ENGINEERING
 END;
END;
$$;
SELECT * FROM students;
BEGIN;
SAVEPOINT sp1;
INSERT INTO students(name, age, class) VALUES ('Hinata', 19, 12);
DO $$ BEGIN RAISE NOTICE 'Inserted Hinata successfully '; END $$;
SAVEPOINT sp2;
DO $$
BEGIN
 BEGIN
 INSERT INTO students(name, age, class) VALUES ('Rohan', 'wrong', 10);
 EXCEPTION
 WHEN OTHERS THEN
 RAISE NOTICE 'Failed to insert Rohan, rolling back to savepoint sp2 ';
 END;
END;
$$;
ROLLBACK TO SAVEPOINT sp2;
SAVEPOINT sp3;
INSERT INTO students(name, age, class) VALUES ('Aditya', 17, 10);
DO $$ BEGIN RAISE NOTICE 'Inserted Aditya successfully '; END $$;
COMMIT;
SELECT * FROM students;
