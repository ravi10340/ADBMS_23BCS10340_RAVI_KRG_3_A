CREATE TABLE AUTHOR( 
    AUTHOR_ID INT PRIMARY KEY, 
    AUTHOR_NAME VARCHAR(20), 
    COUNTRY VARCHAR(20)
);

CREATE TABLE BOOK ( 
    BOOK_ID INT PRIMARY KEY, 
    BOOK_TITLE VARCHAR(30), 
    AUTHOR_ID INT,
    FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHOR(AUTHOR_ID)
);

INSERT INTO AUTHOR (AUTHOR_ID, AUTHOR_NAME, COUNTRY) VALUES
(1, 'Ravi', 'India'),
(2, 'Priya Mehta', 'Nepal'),
(3, 'Amit Verma', 'Sri Lanka'),
(4, 'Anjali Das', 'Bangladesh'),
(5, 'Rajeev Nair', 'Malaysia'),
(6, 'Kavita Reddy', 'Bhutan'),
(7, 'Manoj Kumar', 'Thailand');

INSERT INTO BOOK (BOOK_ID, BOOK_TITLE, AUTHOR_ID) VALUES
(101, 'Mystery of the Monsoon', 1),
(102, 'The Golden Banyan', 2),
(103, 'Whispers of the Ganges', 3),
(104, 'Songs of Sundarbans', 4),
(105, 'Spice Route Diaries', 5),
(106, 'Himalayan Echoes', 6),
(107, 'Twilight over Ayutthaya', 7);

SELECT A.AUTHOR_NAME, A.COUNTRY, B.BOOK_TITLE 
FROM AUTHOR AS A
INNER JOIN BOOK AS B ON A.AUTHOR_ID = B.AUTHOR_ID;
