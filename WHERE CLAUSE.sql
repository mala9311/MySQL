SELECT*
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie';

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary < 50000;

SELECT* 
FROM parks_and_recreation.employee_demographics
WHERE gender != 'female';

SELECT*
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01';

SELECT* 
FROM  parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male';

SELECT* 
FROM parks_and_recreation.employee_demographics
WHERE birth_date >'1985-01-01'
OR gender ='male';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male';

SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE (first_name = 'Leslie' AND age =44)
OR age > 55 ;

 # --LIKE STATMENT
 #--%  and _
 
 SELECT*
 FROM parks_and_recreation.employee_demographics
 WHERE first_name LIKE 'a%';
 
 SELECT*
 FROM parks_and_recreation.employee_demographics
 WHERE first_name LIKE '__n';
 
