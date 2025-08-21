-- EASY LEVEL PROBLEM SOLUTION 
create table employee(
emp_id int);

INSERT INTO EMPLOYEE VALUES(2),(4),(4),(6),(6),(7),(8),(8),(8);

SELECT MAX(Emp_Id) AS MaxEmpId
FROM (
    SELECT Emp_Id
    FROM Employee
    GROUP BY Emp_Id
    HAVING COUNT(Emp_Id) = 1
) AS Unique_Employees;


-- MEDIUM LEVEL PROBLEM SOLUTION
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);


SELECT D.dept_name, E.name, E.SALARY
FROM EMPLOYEE AS E
INNER JOIN
DEPARTMENT AS D
ON 
E.department_id = D.id
WHERE E.SALARY IN   
(
	SELECT MAX(E2.SALARY)
	FROM EMPLOYEE AS E2
	WHERE E2.department_id = E.department_id 
)
ORDER BY D.dept_name;


-- HARD LEVEL PROBLEM SOLUTION

CREATE TABLE A (
    EmpId INT,
    EName VARCHAR(50),
    Salary INT
);

CREATE TABLE B (
    EmpId INT,
    EName VARCHAR(50),
    Salary INT
);

INSERT INTO A VALUES(1,'AA',1000),(2,'BB',300);
INSERT INTO B VALUES(2,'BB',400),(3,'CC',100);

SELECT EMPID, ENAME, MIN(SALARY) AS SALARY
FROM
(
SELECT *FROM A
UNION ALL
SELECT *FROM B 
) AS INTERMEDIATE_RESULT
GROUP BY EMPID, ENAME;



