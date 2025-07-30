CREATE TABLE Department ( 
    DeptID INT PRIMARY KEY, 
    DeptName VARCHAR(100)
);

CREATE TABLE Course ( 
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100), 
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

INSERT INTO Department (DeptID, DeptName) VALUES 
(1, 'Science'),
(2, 'Arts'),
(3, 'Commerce'),
(4,'Law');

INSERT INTO Course VALUES
(101, 'Physics', 1),
(102, 'Chemistry', 1),
(103, 'Biology', 1),
(104, 'Mathematics', 2),
(105, 'History', 2),
(106, 'English', 2),
(107, 'Economics', 3),
(108, 'Business Studies', 3),
(109, 'Anatomy', 3),
(110, 'First Aid', 4),
(111, 'Indian Constitution', 4),
(112, 'Criminal Law', 4);

SELECT DeptName
FROM Department 
WHERE DeptID IN (
    SELECT DeptID
    FROM Course 
    GROUP BY DeptID
    HAVING COUNT(*) >2
);
