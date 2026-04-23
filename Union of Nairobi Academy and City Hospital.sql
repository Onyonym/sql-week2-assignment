-- ============================================
-- Name: Moses
-- Date: 2026-04-23


-- Part 6 - SET Operators (using both databases)
-- 1)	Write a UNION query to show a combined list of all unique cities from the students table and the patients table. Order alphabetically.


select city from nairobi_academy.students
union
select city 
from city_hospital.patients
order by city asc;
 
Set search_path to  city_hospital;
SET search_path TO nairobi_academy1;


-- 2)	Write a UNION ALL query to combine all student first names and all patient full names into one list. Add a second column called source that says 'Student' or 'Patient' so you can tell where each name came from.
select first_name as name,'Student' as source
from nairobi_academy.students
union all
select full_name as name,'Patient' as source
from city_hospital.patients
order by name;


-- 3)	Write an INTERSECT query to find cities that appear in BOTH the students table and the patients table - cities that are home to both students and patients.
select city
from nairobi_academy.students
intersect
select city from city_hospital.patients
order by city;

-- 4)	Write a query that combines all of the following into one result using UNION ALL - student names (labelled 'Student'), patient full names (labelled 'Patient'), and doctor full names (labelled 'Doctor'). Order the final result by the source label, then by name.
select first_name as name,'Student' as source from nairobi_academy.students
union all 
select full_name as name,'Patient' as source from city_hospital.patients
union all
select full_name as name,'Doctor' as source from city_hospital.doctors
order by source, name;











