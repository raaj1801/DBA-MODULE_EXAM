-- 1. Create table DEPT with the following structure:-

create table DEPT(
DEPTNO INT(2),
DNAME VARCHAR(15),
LOC VARCHAR(10)
);
-- Insert the following rows into the DEPT table:

INSERT INTO DEPT(DEPTNO,DNAME,LOC)VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');
SELECT * FROM DEPT;

-- 2. Create table EMP with the following structure:

CREATE TABLE EMP(
EMPNO INT(4),
ENAME VARCHAR(10),
JOB VARCHAR(9),
HIREDATE DATE,
SAL FLOAT(7,2),
COMM FLOAT(7,2),
DEPTNO INT(2)
);


-- Insert the following rows into the EMP table:-
INSERT INTO EMP(EMPNO,ENAME,JOB,HIREDATE,SAL,COMM,DEPTNO)VALUES
(7839,'KING','MANAGER','1991-11-17', 5000, NULL, 10),
(7698, 'BLAKE',' CLERK', '1981-05-01', 2850, NULL, 30),
(7782,' CLARK',' MANAGER', '1981-06-09', 2450, NULL, 10),
(7566,' JONES',' CLERK', '1981-04-02', 2975, NULL ,20),
(7654,' MARTIN',' SALESMAN ','1981-09-28', 1250, 1400 ,30),
(7499, 'ALLEN',' SALESMAN',' 1981-02-20', 1600, 300, 30);
SELECT * FROM EMP;

-- 3. Display all the employees where SAL between 2500 and 5000 (inclusive of both).*\
SELECT  * FROM EMP WHERE SAL BETWEEN 2500 AND 5000;

-- 4. Display all the ENAMEs in descending order of ENAME.
SELECT * FROM EMP ORDER BY EMP.ENAME DESC;

-- 5. Display all the JOBs in lowercase.
SELECT LOWER(JOB) FROM EMP;

-- 6. Display the ENAMEs and the lengths of the ENAMEs
SELECT ENAME, LENGTH(ENAME) FROM EMP;

-- 7. Display the DEPTNO and the count of employees who belong to that DEPTNO .
SELECT DEPTNO,COUNT(*) AS 'ALL EMPLOYEES' FROM EMP GROUP BY DEPTNO;

-- 8. Display the DNAMEs and the ENAMEs who belong to that DNAME.
SELECT DNAME,ENAME FROM DEPT,EMP WHERE DEPT.DEPTNO=EMP.DEPTNO;

-- 9. Display the position at which the string ‘AR’ occurs in the ename.
SELECT INSTR(ENAME,'AR') AS POSITION FROM EMP;

-- 10. Display the HRA for each employee given that HRA is 20% of SAL.
SELECT ENAME,SAL*0.2 AS HRA FROM EMP;



-- 1. Write a stored procedure by the name of PROC1 that accepts two varchar strings
-- as parameters. Your procedure should then determine if the first varchar string 
-- exists inside the varchar string. For example, if string1 = ‘DAC’ and string2 = 
-- ‘CDAC, then string1 exists inside string2. The stored procedure should insert the 
-- appropriate message into a suitable TEMPP output table. Calling program for the 
-- stored procedure need not be written

DROP TABLE TEMPP;
CREATE TABLE TEMPP(
STRING1 VARCHAR(50),
STRING2 VARCHAR(50), 
MSG VARCHAR(50)

);


DELIMITER //
CREATE PROCEDURE PROC1(STRING1 VARCHAR(50),STRING2 VARCHAR(50))
BEGIN
DECLARE MSG VARCHAR(25);
DECLARE NUM INT;
SELECT LOCATE(STRING1,STRING2) INTO NUM;
IF NUM>0 THEN
INSERT INTO TEMPP VALUES(STRING1,STRING2,'STRING1 EXISTS IN STRING2');
ELSE
INSERT INTO TEMPP VALUES(STRING1,STRING2,'STRING1 DOES NOT EXISTS IN STRING2');
END IF;

END; //
DELIMITER ;
CALL PROC1('DAC','CDAC');
CALL PROC1('DAC','MUMBAI');
SELECT * FROM TEMPP;

-- 2. Create a stored function by the name of FUNC1 to take three parameters, the 
-- sides of a triangle. The function should return a Boolean value:- TRUE if the 
-- triangle is valid, FALSE otherwise. A triangle is valid if the length of each side is 
-- less than the sum of the lengths of the other two sides. Check if the dimensions 
-- entered can form a valid triangle. Calling program for the stored function need not 
-- be written.alter

DELIMITER //
CREATE FUNCTION FUNC1(S1 INT , S2 INT, S3 INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
IF S1<(S2+S3) AND S2<(S1+S3) AND S3<(S1+S2) THEN
RETURN TRUE;
else
RETURN FALSE;
END IF;
END //
DELIMITER ;

CREATE TABLE TRIANGLE(

S1 INT,
S2 INT,
S3 INT,
RESULT VARCHAR(30)
);

DELIMITER //
CREATE PROCEDURE TRIA(X INT, Y INT,Z INT)
BEGIN
IF FUNC1(X,Y,Z) THEN
INSERT INTO TRIANGLE VALUES(X,Y,Z,'VALID TRIANGLE');
ELSE
INSERT INTO TRIANGLE VALUES(X,Y,Z,'INVALID TRIANGLE');
END IF;
END; //
DELIMITER ;
CALL TRIA(15,25,35);
SELECT * FROM TRIANGLE;
CALL TRIA(95,25,35);
DROP TABLE TRIANGLE;
