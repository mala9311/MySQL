-- Data Cleaning

SELECT * 
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values  
-- 4. Remove Any Columns

CREATE TABLE layoffs_staging
LIKE layoffs ;

SELECT * 
FROM  layoffs_staging ;
INSERT layoffs_staging
SELECT * 
FROM layoffs ;

SELECT * ,
ROW_NUMBER() OVER
( PARTITION BY company , industry , total_laid_off , percentage_laid_off , `date`) AS row_num
FROM  layoffs_staging ;

WITH duplicate_cte AS
(SELECT * ,
ROW_NUMBER() OVER
( PARTITION BY company ,location, industry , total_laid_off , percentage_laid_off , `date`, stage , country , funds_raised_millions ) AS row_num
FROM  layoffs_staging 
) 
SELECT * FROM duplicate_cte
WHERE row_num >1 ;

-- We wouold love to do this but this is not a correct to way of doing 
WITH duplicate_cte AS
(SELECT * ,
ROW_NUMBER() OVER
( PARTITION BY company ,location, industry , total_laid_off , percentage_laid_off , `date`, stage , country , funds_raised_millions ) AS row_num
FROM  layoffs_staging 
) 
DELETE FROM duplicate_cte
WHERE row_num >1 ;

CREATE TABLE `layoffs_staging02` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
 SELECT * FROM layoffs_staging02
 WHERE row_num > 1;

INSERT INTO layoffs_staging02
SELECT * ,
ROW_NUMBER() OVER
( PARTITION BY company ,location, industry , total_laid_off , percentage_laid_off , `date`, stage , country , funds_raised_millions ) 
AS row_num
FROM  layoffs_staging ;

SET SQL_SAFE_UPDATES = 0;

DELETE 
FROM layoffs_staging02 
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM layoffs_staging02
 WHERE row_num > 1;
 
 -- Standardizing data
 
 SELECT company , TRIM(company)
 FROM layoffs_staging02 ;
 
 UPDATE layoffs_staging02
 SET company = TRIM(company);
 
 SELECT DISTINCT industry
 FROM layoffs_staging02
 ORDER BY 1 ;
 
 SELECT * 
 FROM layoffs_staging02
 WHERE industry LIKE 'crypto%';
 
 UPDATE layoffs_staging02
 SET  industry = 'crypto'
 WHERE industry LIKE 'crypto%';
 
 SELECT DISTINCT industry
 FROM layoffs_staging02 ;
 
 SELECT DISTINCT location
 FROM layoffs_staging02 
 ORDER BY 1;
 
 SELECT DISTINCT country , TRIM(TRAILING '.' FROM country) 
 FROM layoffs_staging02
 ORDER BY 1 ;
 UPDATE layoffs_staging02
 SET country = TRIM(TRAILING '.' FROM country) 
 WHERE country LIKE 'United States%';
 
 SELECT *
 FROM layoffs_staging02 ;
 
 SELECT `date` ,
 STR_TO_DATE(`date` , '%m/%d/%Y')
 FROM layoffs_staging02 ;
 
 SELECT `date`
FROM layoffs_staging02
WHERE STR_TO_DATE(`date`, '%m-%d-%Y') IS NULL;

 UPDATE layoffs_staging02
 SET `date` =  STR_TO_DATE(`date` , '%m-%d-%Y') ;  ## This can only be written if we have date in same format either in '/' form or '-'
 
 UPDATE layoffs_staging02
 SET `date` = 
		CASE 
        WHEN `date` LIKE '%/%' THEN STR_TO_DATE (`date` , '%m/%d/%Y') 
        WHEN  `date` LIKE '%-%' THEN STR_TO_DATE(`date` , '%m-%d-%Y')
        END;

ALTER TABLE layoffs_staging02
MODIFY COLUMN `date` DATE ;

SELECT *
FROM layoffs_staging02 ;

-- Null values and Blank values

SELECT * 
FROM layoffs_staging02
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

SELECT DISTINCT industry
FROM layoffs_staging02;

SELECT DISTINCT industry
FROM layoffs_staging02
WHERE industry IS NULL 
OR industry = '';


SELECT *
FROM layoffs_staging02
WHERE industry IS NULL 
OR industry = '';
SELECT * 
FROM layoffs_staging02
WHERE company = 'Airbnb' ;

SELECT *
FROM layoffs_staging02 t1
JOIN layoffs_staging02 t2
	ON t1.company =t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging02 t1
JOIN layoffs_staging02 t2
	ON t1.company =t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL 
;

SELECT * 
FROM layoffs_staging02
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;



DELETE 
FROM layoffs_staging02
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;
SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM layoffs_staging02
WHERE company ='Airbnb';

ALTER TABLE layoffs_staging02
DROP COLUMN row_num;

SELECT company, LENGTH(company)
FROM layoffs_staging02
WHERE company LIKE '%Airbnb%';

SELECT DISTINCT company
FROM layoffs_staging02
WHERE company LIKE '%Airbnb%';

UPDATE layoffs_staging02
SET company = TRIM(company);
SET SQL_SAFE_UPDATES = 0;
UPDATE layoffs_staging02

SET industry = 'Travel'
WHERE company = 'Airbnb';
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;

UPDATE layoffs_staging02
SET industry = 'Travel'
WHERE company = 'Airbnb'
AND (industry IS NULL OR industry = '');
SET SQL_SAFE_UPDATES = 1;

