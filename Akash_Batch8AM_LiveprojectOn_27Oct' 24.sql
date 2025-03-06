create database Student_Databaseuse

use Student_Database


DROP TABLE Student_Info
Create table Student_Info (STUDENT_ID int, FIRST_NAME varchar(max),	LAST_NAME varchar(max),	GPA FLOAT,
ENROLLMENT_DATE datetime, MAJOR varchar(max))

truncate table Student_Info

INSERT INTO Student_Info(STUDENT_ID, FIRST_NAME, LAST_NAME, GPA, ENROLLMENT_DATE, MAJOR) 
VALUES
(201, 'Shivansh', 'Mahajan', 8.79, '2021-09-01 09:30', 'Computer Science'),
(202, 'Umesh', 'Sharma', 8.44, '2021-09-01 08:30', 'Mathematics'),
(203, 'Rakesh', 'Kumar', 5.6, '2021-09-01 10:00', 'Biology'),
(204, 'Radha', 'Sharma', 9.2, '2021-09-01 12:45', 'Chemistry'),
(205, 'Kush', 'Kumar', 7.85, '2021-09-01 08:30', 'Physics'),
(206, 'Prem', 'Chopra', 9.56, '2021-09-01 09:24', 'History'),
(207, 'Pankaj', 'Vats', 9.78, '2021-09-01 02:30', 'English'),
(208, 'Navleen', 'Kaur', 7, '2021-09-01 06:30', 'Mathematics');

SELECT * FROM Student_Info


select * from Student_Info

-- 1. Write a SQL query to fetch "FIRST_NAME" from the Student table in upper case and use ALIAS name as STUDENT_NAME.
--Solution

Select UPPER (first_name) 'STUDENT_NAME' from Student_Info

--2. Write a SQL query to fetch unique values of MAJOR Subjects from Student table.
--Solution

select distinct (major) from student_info 

--3. Write a SQL query to print the first 3 characters of FIRST_NAME from Student table.
--Solution

select LEFT (first_name, 3) from Student_Info


--4. Write a SQL query that fetches the unique values of MAJOR Subjects from Student table and print its length.
--Solution

SELECT DISTINCT MAJOR, LEN(MAJOR)'Lenght'  FROM Student_Info


--5. Write a SQL query to print the FIRST_NAME and LAST_NAME from Student table into single column COMPLETE_NAME.
--Solution

select CONCAT(first_name, ' ', last_name) 'COMPLETE_NAME' from Student_Info

--6. Write a SQL query to print details of the Students with the FIRST_NAME as 'Prem' and 'Shivansh' from Student table.
--Solution

SELECT * FROM Student_Info WHERE FIRST_NAME IN ('Prem', 'Shivansh');


--7. Write a SQL query to print details of the Students excluding FIRST_NAME as 'Prem' and 'Shivansh' from Student table.
--Solution

SELECT * FROM Student_Info WHERE FIRST_NAME not in ('Prem', 'Shivansh');


--8. Write a SQL query to print details of the Students whose FIRST_NAME ends with 'a'.
--Solution

SELECT * FROM Student_Info WHERE FIRST_NAME LIKE '%a';


--9. Write an SQL query to fetch Students full names with GPA >= 8.5 and <= 9.5.
--Solution

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) 'FULL_NAME' FROM Student_Info
WHERE GPA >= 8.5 AND GPA <= 9.5


--10. Write an SQL query to fetch the no. of Students for each MAJOR subject in the descending order.
--Solution
---1.
SELECT MAJOR, COUNT(*) AS NUMBER_OF_STUDENTS FROM Student_Info
GROUP BY MAJOR
ORDER BY NUMBER_OF_STUDENTS DESC;

---2.

SELECT MAJOR, COUNT(*) AS NUMBER_OF_STUDENTS FROM Student_Info
GROUP BY MAJOR
ORDER BY MAJOR DESC;


--11. Display the details of students who have received scholarships, including their names, scholarship amounts, 
--and scholarship dates.
--Solution

create table SCHOLARSHIP_INFO (STUDENT_REF_ID int,	SCHOLARSHIP_AMOUNT int,	SCHOLARSHIP_DATE datetime)
select * from SCHOLARSHIP_INFO

select * from Student_Info
select * from SCHOLARSHIP_INFO

SELECT Student_Info.FIRST_NAME, Student_Info.LAST_NAME, SCHOLARSHIP_INFO.SCHOLARSHIP_AMOUNT, 
SCHOLARSHIP_INFO.SCHOLARSHIP_DATE
FROM Student_Info 
left JOIN SCHOLARSHIP_INFO ON Student_Info.STUDENT_ID = SCHOLARSHIP_INFO.STUDENT_REF_ID


--12. List all students and their scholarship amounts if they have received any. 
--If a student has not received a scholarship, display NULL for the scholarship details.
----->Solution

SELECT Student_Info.FIRST_NAME, Student_Info.LAST_NAME, SCHOLARSHIP_INFO.SCHOLARSHIP_AMOUNT, 
SCHOLARSHIP_INFO.SCHOLARSHIP_DATE
FROM Student_Info 
left JOIN SCHOLARSHIP_INFO ON Student_Info.STUDENT_ID = SCHOLARSHIP_INFO.STUDENT_REF_ID


--13. Write an SQL query to show the top n (say 5) records of Student table order by descending GPA.
--Solution

SELECT TOP 5 * FROM Student_Info
ORDER BY GPA DESC


--14. Write an SQL query to fetch the list of Students with the same GPA.
--Solution

SELECT Student_Info.STUDENT_ID, Student_Info.FIRST_NAME, Student_Info.LAST_NAME, Student_Info.GPA
FROM Student_Info 
JOIN (
    SELECT GPA
    FROM Student_Info
    GROUP BY GPA
    HAVING COUNT(*) > 1
) s2 ON Student_Info.GPA = s2.GPA
ORDER BY Student_Info.GPA;


--15. Write an SQL query to show the second highest GPA from a Student table using sub-query.
--Solution

select MAX(GPA) 'Second_Highest_GPA'
from student_info
where GPA < (select MAX(GPA) from student_info)

--16. Write an SQL query to show one row twice in results from a table.
--Solution

SELECT * 
FROM student_info
WHERE STUDENT_ID = 201
UNION ALL
SELECT * 
FROM student_info
WHERE STUDENT_ID = 201

--17. Write an SQL query to list STUDENT_ID who does not get Scholarship.
--Solution

SELECT STUDENT_ID
FROM Student_Info
WHERE STUDENT_ID NOT IN (
SELECT DISTINCT STUDENT_REF_ID
FROM SCHOLARSHIP_INFO
)
--18. Write an SQL query to fetch the MAJOR subject that have less than 4 people in it.
--Solution


select MAJOR
from Student_Info
GROUP BY MAJOR
having COUNT(STUDENT_ID) < 4;


--19. Write an SQL query to show all MAJOR subject along with the number of people in there.
--Solution

select MAJOR, COUNT(STUDENT_ID) AS NumberOfpeople
from Student_Info
GROUP BY MAJOR;

--20. Write an SQL query to show the last record from a table.
--Solution

SELECT * FROM Student_Info 
WHERE ENROLLMENT_DATE = (SELECT MAX(ENROLLMENT_DATE) FROM Student_Info);

--21. Write an SQL query to fetch three max GPA from a table using co-related subquery.
--Solution


select * from Student_Info
where gpa in (
select top 3 gpa from Student_Info order by gpa desc )
order by gpa desc


--22. Write an SQL query to fetch MAJOR subjects along with the max GPA in each of these MAJOR subjects.
--Solution

SELECT MAJOR, MAX(GPA) 'max_gpa'
FROM Student_Info
GROUP BY MAJOR


--23. Write an SQL query to fetch the names of Students who has highest GPA.
--Solution

SELECT FIRST_NAME, LAST_NAME
FROM Student_Info
WHERE GPA = (SELECT MAX(GPA) FROM Student_Info);

