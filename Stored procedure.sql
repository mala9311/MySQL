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

DELIMITER $$
CREATE PROCEDURE larger_salaries4(p_employee_id INT)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = p_employee_id;
	
END $$
DELIMITER ;

CALL larger_salaries4(1);




