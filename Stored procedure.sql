-- Stored Procedure

CREATE PROCEDURE larger_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL larger_salaries();

DELIMITER $$
CREATE PROCEDURE larger_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;
