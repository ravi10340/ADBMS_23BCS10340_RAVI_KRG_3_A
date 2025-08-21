CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID INT NULL
);

ALTER TABLE Employee
ADD CONSTRAINT FK_Manager FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID);

INSERT INTO Employee (EmpID, EmpName, Department, ManagerID)
VALUES
(1, 'Ravi', 'HR', NULL),
(2, 'Sneha', 'Finance', 1),
(3, 'Karan', 'IT', 1),
(4, 'Meena', 'Finance', 2),
(5, 'Arjun', 'IT', 3),
(6, 'Pooja', 'HR', 1);

SELECT 
    E1.EmpName AS [Employee Name],
    E1.Department AS [Employee Dept],
    E2.EmpName AS [Manager Name],
    E2.Department AS [Manager Dept]
FROM Employee AS E1
LEFT JOIN Employee AS E2
ON E1.ManagerID = E2.EmpID;

