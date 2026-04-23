
SELECT UPPER(full_name), LOWER(city)
FROM students;



CREATE SCHEMA nairobi_academy1;
SET search_path TO nairobi_academy1;

CREATE TABLE students (
    student_id      INT          PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    gender          VARCHAR(1),
    date_of_birth   DATE,
    class           VARCHAR(10),
    city            VARCHAR(50)
);

CREATE TABLE subjects (
    subject_id    INT           PRIMARY KEY,
    subject_name  VARCHAR(100)  NOT NULL UNIQUE,
    department    VARCHAR(50),
    teacher_name  VARCHAR(100),
    credits       INT
);

CREATE TABLE exam_results (
    result_id   INT   PRIMARY KEY,
    student_id  INT   NOT NULL,
    subject_id  INT   NOT NULL,
    marks       INT   NOT NULL,
    exam_date   DATE,
    grade       VARCHAR(2)
);

INSERT INTO students (student_id, first_name, last_name, gender, date_of_birth, class, city)
VALUES
    (1, 'Amina',  'Wanjiku', 'F', '2008-03-12', 'Form 3', 'Nairobi'),
    (2, 'Brian',  'Ochieng', 'M', '2007-07-25', 'Form 4', 'Mombasa'),
    (3, 'Cynthia','Mutua',   'F', '2008-11-05', 'Form 3', 'Kisumu'),
    (4, 'David',  'Kamau',   'M', '2007-02-18', 'Form 4', 'Nairobi'),
    (5, 'Esther', 'Akinyi',  'F', '2009-06-30', 'Form 2', 'Nakuru'),
    (6, 'Felix',  'Otieno',  'M', '2009-09-14', 'Form 2', 'Eldoret'),
    (7, 'Grace',  'Mwangi',  'F', '2008-01-22', 'Form 3', 'Nairobi'),
    (8, 'Hassan', 'Abdi',    'M', '2007-04-09', 'Form 4', 'Mombasa'),
    (9, 'Ivy',    'Chebet',  'F', '2009-12-01', 'Form 2', 'Nakuru'),
    (10,'James',  'Kariuki', 'M', '2008-08-17', 'Form 3', 'Nairobi');
INSERT INTO subjects (subject_id, subject_name, department, teacher_name, credits)
VALUES
    (1,  'Mathematics',     'Sciences',   'Mr. Njoroge',  4),
    (2,  'English',         'Languages',  'Ms. Adhiambo', 3),
    (3,  'Biology',         'Sciences',   'Ms. Otieno',   4),
    (4,  'History',         'Humanities', 'Mr. Waweru',   3),
    (5,  'Kiswahili',       'Languages',  'Ms. Nduta',    3),
    (6,  'Physics',         'Sciences',   'Mr. Kamande',  4),
    (7,  'Geography',       'Humanities', 'Ms. Chebet',   3),
    (8,  'Chemistry',       'Sciences',   'Ms. Muthoni',  4),
    (9,  'Computer Studies','Sciences',   'Mr. Oduya',    3),
    (10, 'Business Studies','Humanities', 'Ms. Wangari',  3);
INSERT INTO exam_results (result_id, student_id, subject_id, marks, exam_date, grade)
VALUES
    (1,  1, 1, 78, '2024-03-15', 'B'),
    (2,  1, 2, 85, '2024-03-16', 'A'),
    (3,  2, 1, 92, '2024-03-15', 'A'),
    (4,  2, 3, 55, '2024-03-17', 'C'),
    (5,  3, 2, 49, '2024-03-16', 'D'),
    (6,  3, 4, 71, '2024-03-18', 'B'),
    (7,  4, 1, 88, '2024-03-15', 'A'),
    (8,  4, 6, 63, '2024-03-19', 'C'),
    (9,  5, 5, 39, '2024-03-20', 'F'),
    (10, 6, 9, 95, '2024-03-21', 'A');
-- part 1
-- Q1 Write a query to display each student's full name in UPPERCASE and their city in lowercase. Name the columns upper_name and lower_city.
SELECT 
    UPPER(CONCAT(first_name, ' ', last_name)) AS upper_name,
    LOWER(city) AS lower_city
FROM students;

-- Q2 Write a query to show each student's first name and the LENGTH of their first name. Order the results from longest to shortest name.
select first_name, length(first_name) desc
from students;

-- Q3
SELECT 
    subject_name,
    SUBSTRING(subject_name FROM 1 FOR 4) AS short_name,
    LENGTH(subject_name) AS name_length
FROM subjects;

-- Q4
SELECT 
    CONCAT(first_name, ' ', last_name, 
           ' is in ', class, 
           ' and comes from ', city) AS student_summary
FROM students;


-- Part 2
-- 1)	Write a query to show each exam result alongside the mark rounded to 1 decimal place, the mark rounded UP to the nearest 10 using CEIL, and the mark rounded DOWN using FLOOR.

select result_id, grade,round(marks,1), ceil(marks), floor(marks)
from exam_results;


-- 2)	Write a query to calculate the following summary statistics for exam_results in one query: total number of results (COUNT), average mark (AVG rounded to 2 decimal places), highest mark (MAX), lowest mark (MIN), and total marks added together (SUM).
SELECT 
   count(result_id) as number_of_results, round(avg(marks),2), max(marks) as highest_mark, min(marks) as lowest_mark, sum (marks) as total_marks
   from exam_results;

--3)	The school wants to apply a 10% bonus to all marks. Write a query to show each result_id, the original marks, and the new boosted_mark rounded to the nearest whole number.

select result_id, marks,round(((1+0.1)*marks),0) as new_boosted_mark
from exam_results;
select result_id, marks,ceil(1.1*marks) as new_boosted_mark
from exam_results;


-- Part 3 – Date & Time Functions(PostgreSQL) – using: nairobi_academy
-- 1)	Write a query to extract the birth year, birth month, and birth day from each student's date_of_birth as three separate columns. Show first_name alongside them.
select first_name,
extract(year from date_of_birth)::text as year,
extract(month from date_of_birth) as month,
extract(day from date_of_birth) as day
from students;



--2)	Write a query to show each student's full name, their date_of_birth, and their age in complete years. Order from oldest to youngest.
select concat(first_name, '', last_name) as full_name, date_of_birth, extract (year from(age(current_date, date_of_birth))) as current_age 
from students
order by current_age desc;



-- 3)	Write a query to display each exam date in this exact format: 'Friday, 15th March 2024'.. Call the column formatted_date.

select exam_date,
TO_CHAR(exam_date, 'Day, DDth Month YYYY') as formatted_date
from exam_results;

select * from students;
select * from subjects;
select * from exam_results;

-- Part 5 - Window Functions (using: nairobi_academy)
-- 1)	Write a query using ROW_NUMBER() to assign a unique rank to each exam result, ordered from highest mark to lowest. Show result_id, student_id, marks, and row_num.

select  result_id, student_id, marks, row_number() over(order by marks desc) as row_number
from exam_results;


-- 2)	Write a query using RANK() and DENSE_RANK() on exam results ordered by marks descending. Show both columns side by side so the difference between them is visible.

select result_id, student_id,subject_id, marks,
  RANK() OVER (order by marks desc) as rank_position,
  dense_rank() over (order by marks desc) AS dense_rank_position
from exam_results;



-- 3)	Write a query using NTILE(3) to divide all exam results into 3 performance bands (1 = top, 2 = middle, 3 = bottom). Show result_id, marks, and band.
select result_id,marks,
    NTILE(3) OVER (order by marks desc) as band,
    case 
    	when NTILE(3) OVER (order by marks desc) = 1 then 'top'
    	when NTILE(3) OVER (order by marks desc) = 2 then 'middle'
    	when NTILE(3) OVER (order by marks desc) = 3 then 'bottom'
    end
from exam_results;


-- 4)	Write a query using AVG() OVER(PARTITION BY student_id) to show each exam result alongside that student's personal average mark. Show student_id, marks, and student_avg rounded to 2 decimal places.

select result_id,student_id,marks,
ROUND(AVG(marks) OVER (partition by student_id), 2) as student_avg
from exam_results;

-- 5)	Write a query using LAG() to show each exam result alongside the previous result's marks for the same student. Also calculate the improvement (current marks minus previous marks). Use PARTITION BY student_id.

select result_id,student_id,marks,
lag(marks) OVER (partition by  student_id order by exam_date) as prev_marks,
marks - LAG(marks) OVER (partition by  student_id order by exam_date) as improvement
from exam_results;




-- Part 6 - SET Operators (using both databases)
1)	Write a UNION query to show a combined list of all unique cities from the students table and the patients table. Order alphabetically.


















