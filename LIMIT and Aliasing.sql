# -- LIMIT AND Aliasing

SELECT * 
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2,1;

# --Aliasing

SELECT gender ,AVG(age) AS avg_age
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40 ;

# We can also write without using AS , it does not bother .
