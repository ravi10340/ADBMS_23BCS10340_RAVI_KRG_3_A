CREATE TABLE DEPARTMENT (
    DEPT_ID INT PRIMARY KEY,
    DEPT_NAME VARCHAR(50)
);
CREATE TABLE COURSE (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(50),
    DEPT_ID INT,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID)
);
INSERT INTO DEPARTMENT (DEPT_ID, DEPT_NAME) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Chemistry'),
(5, 'English');
INSERT INTO COURSE (COURSE_ID, COURSE_NAME, DEPT_ID) VALUES
(101, 'Data Structures', 1),
(102, 'Operating Systems', 1),
(103, 'Calculus I', 2),
(104, 'Linear Algebra', 2),
(105, 'Classical Mechanics', 3),
(106, 'Quantum Physics', 3),
(107, 'Organic Chemistry', 4),
(108, 'Inorganic Chemistry', 4),
(109, 'English Literature', 5),
(110, 'Creative Writing', 5);
SELECT * FROM DEPARTMENT;
SELECT * FROM COURSE;
SELECT
    DEPT_NAME,
    (SELECT COUNT(*)
     FROM COURSE
     WHERE COURSE.DEPT_ID = DEPARTMENT.DEPT_ID) AS COURSE_COUNT
FROM
    DEPARTMENT
WHERE 
    (SELECT COUNT(*) 
     FROM COURSE 
     WHERE COURSE.DEPT_ID = DEPARTMENT.DEPT_ID) >= 2;
