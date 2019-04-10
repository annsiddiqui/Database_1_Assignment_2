/*
Name: Qurrat-al-Ain Siddiqui (Ann Siddiqui)
Date: October 29, 2018
Date Submitted: Wednesday November 7, 2018
Course: COMP 2521-001
Assignment #2: Complex SQL Queries
Instructor: Shoba Ittyipe
*/

--Queries:

--1
SELECT description
FROM grade_type;

--2
SELECT section_id, description, percent_of_final_grade
FROM grade_type JOIN grade_type_weight
ON grade_type.grade_type_code = grade_type_weight.grade_type_code
WHERE section_id = '148'
OR section_id = '153';

--3
SELECT section.section_id, description, percent_of_final_grade
FROM grade_type_weight JOIN grade_type ON grade_type_weight.grade_type_code = grade_type.grade_type_code
                       JOIN section ON grade_type_weight.section_id = section.section_id
WHERE course_no = "122";

--4
SELECT description, capacity
FROM course JOIN section
ON course.course_no = section.course_no
WHERE description LIKE '%Ad%'
AND description NOT LIKE '%Advanced%'
GROUP BY description;

--5 (a)
SELECT description, prerequisite
FROM course
WHERE description LIKE 'Intro to%'
AND cost < 1100
OR cost IS NULL;

--5 (b)
SELECT description, prerequisite
FROM course
WHERE description LIKE 'Intro to%'
AND cost BETWEEN 0 AND 1100
OR cost IS NULL;

--6
SELECT description, cost, prerequisite
FROM course
WHERE cost = 1195
AND prerequisite = 20
OR prerequisite = 25;

--7
SELECT student_id
FROM enrollment
GROUP BY student_id
HAVING COUNT(section_id) >= 4;

-- 7 (PROOF)
SELECT student_id, COUNT(section_id)
FROM enrollment
GROUP BY student_id
HAVING COUNT(section_id) > 3;

--8
SELECT s1.last_name, s1.student_id, s2.percent_of_final_grade, s2.grade_type_code, s3.numeric_grade
FROM student s1, grade_type_weight s2, grade s3
WHERE s2.grade_type_code = 'PJ'
AND s3.numeric_grade < 81
AND s2.section_id = s3.section_id
AND s1.student_id = s3.student_id
GROUP BY s1.last_name;

--9
SELECT description, prerequisite
From course
WHERE prerequisite IS NOT NULL
ORDER BY description DESC;

--10
SELECT prerequisite, COUNT(course_no)
FROM course
GROUP BY prerequisite;

--11 (a)
SELECT DISTINCT location
FROM section;

--11 (b)
SELECT location
FROM section
GROUP BY location;

--12
SELECT location, capacity, min(capacity), max(capacity)
FROM section
GROUP BY location;

--13
SELECT last_name, instructor.instructor_id, COUNT(course_no)
FROM instructor JOIN section on instructor.instructor_id = section.instructor_id
WHERE course_no IS NOT NULL
GROUP BY last_name;

--14 (a)
SELECT instructor.last_name, description, section.section_id
FROM section JOIN instructor ON section.instructor_id = instructor.instructor_id
             JOIN course ON section.course_no = course.course_no
             JOIN enrollment ON section.section_id = enrollment.section_id
             JOIN student ON student.student_id = enrollment.student_id
WHERE student.last_name LIKE "Williams"
AND student.first_name LIKE "Yvonne"
OR student.last_name LIKE "Wicelinski"
AND student.first_name LIKE "Daniel";

--14 (b)
SELECT instructor.last_name, description, section.section_id
FROM section JOIN instructor USING(instructor_id)
             JOIN course USING(course_no)
             JOIN enrollment USING(section_id)
             JOIN student ON student.student_id = enrollment.student_id
WHERE student.last_name BETWEEN "Wicelinski" AND "Williams"
AND student.first_name = "Daniel"
OR student.first_name = "Yvonne";

--15
SELECT first_name, last_name
FROM instructor JOIN section ON instructor.instructor_id = section.instructor_id
GROUP BY last_name
HAVING COUNT(course_no) < 10;

--16
SELECT c1.description, cp.description
FROM course c1 JOIN course cp ON c1.prerequisite = cp.course_no;

--17
SELECT prerequisite, COUNT(course_no)
FROM course
WHERE course_no IS NOT NULL
AND prerequisite IS NOT NULL
GROUP BY prerequisite;
