# GROUP BY 
SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT occupation , salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation , salary;

SELECT gender , AVG(age) , MAX(age) , MIN(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

# ORDER BY
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name DESC;

SELECT * 
FROM parks_and_recreation.employee_demographics
ORDER BY gender , age;

SELECT * 
FROM parks_and_recreation.employee_demographics
ORDER BY 5,4;    # ORDERING THE COLUMN BY INDEX VALUES

# --WHERE Vs HAVING
SELECT gender , AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation ,AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation 
HAVING AVG(salary) > 75000;
