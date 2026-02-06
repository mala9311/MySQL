-- Advance SQL
-- CTEs -> Common Table Expressions

WITH CTE_Example AS
(
SELECT gender , AVG(salary) avg_sal , MAX(salary) max_sal , MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary  sal
	ON dem.employee_id = sal.employee_id 
GROUP BY gender 
)
SELECT AVG(avg_sal)
FROM CTE_Example ;

-- Above method is far good method to use for comanies 
SELECT AVG(avg_sal)
FROM(SELECT gender , AVG(salary) avg_sal , MAX(salary) max_sal , MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary  sal
	ON dem.employee_id = sal.employee_id 
GROUP BY gender
)example_subquery ;
-- This will over write the column name which we have in the query
WITH CTE_Example2(Gender , Avg_Sal, Max_Sal ,  Min_Sal, Count_Sal  ) AS
(
SELECT gender , AVG(salary) avg_sal , MAX(salary) max_sal , MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary  sal
	ON dem.employee_id = sal.employee_id 
GROUP BY gender 
)
SELECT AVG(Avg_Sal)
FROM CTE_Example2 ;

WITH CTE_Example AS
(
SELECT employee_id , gender , birth_date
FROM employee_demographics 
WHERE birth_date > '1985-01-01'
 ),
  CTE_Example2 AS
 (
 SELECT employee_id , salary
 FROM employee_salary
 WHERE salary > 50000 
 )
SELECT*
FROM CTE_Example 
JOIN CTE_Example2 
	ON CTE_Example.employee_id = CTE_Example2.employee_id ;




