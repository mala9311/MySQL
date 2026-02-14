-- AGAIN Data cleaning

SELECT * 
FROM layoffs ;
CREATE TABLE layoffs_staging
LIKE layoffs ;

SELECT *
FROM layoffs_staging ;

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
WITH duplicate_cte AS
(SELECT * ,
ROW_NUMBER() OVER
( PARTITION BY company ,location, industry , total_laid_off , percentage_laid_off , `date`, stage , country , funds_raised_millions ) AS row_num
FROM  layoffs_staging 
) 
DELETE FROM duplicate_cte
WHERE row_num >1 ;



CREATE TABLE `layoffs_staging2` (
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
SELECT * FROM layoffs_staging2;
INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER
( PARTITION BY company ,location, industry , total_laid_off , percentage_laid_off , `date`, stage , country , funds_raised_millions ) 
AS row_num
FROM  layoffs_staging ;


DELETE 
FROM layoffs_staging2 
WHERE row_num > 1;
SELECT * FROM layoffs_staging2;
SELECT company , TRIM(company)
 FROM layoffs_staging2 ;

 UPDATE layoffs_staging2
 SET company = TRIM(company);

 SELECT DISTINCT industry
 FROM layoffs_staging2
 ORDER BY 1 ;

 SELECT * 
 FROM layoffs_staging2
 WHERE industry LIKE 'crypto%';

 UPDATE layoffs_staging2
 SET  industry = 'crypto'
 WHERE industry LIKE 'crypto%';

 SELECT DISTINCT industry
 FROM layoffs_staging2 ;

 SELECT DISTINCT location
 FROM layoffs_staging2 
 ORDER BY 1;

SELECT DISTINCT country , TRIM(TRAILING '.' FROM country) 
 FROM layoffs_staging02
 ORDER BY 1 ;
 UPDATE layoffs_staging2
 SET country = TRIM(TRAILING '.' FROM country) 
 WHERE country LIKE 'United States%';

 SELECT *
 FROM layoffs_staging2 ;

 SELECT `date` ,
 STR_TO_DATE(`date` , '%m/%d/%Y')
 FROM layoffs_staging2 ;

 SELECT `date`
FROM layoffs_staging2
WHERE STR_TO_DATE(`date`, '%m-%d-%Y') IS NULL;

 UPDATE layoffs_staging2
 SET `date` =  STR_TO_DATE(`date` , '%m-%d-%Y') ;  ## This can only be written if we have date in same format either in '/' form or '-'

 UPDATE layoffs_staging2
 SET `date` = 
		CASE 
        WHEN `date` LIKE '%/%' THEN STR_TO_DATE (`date` , '%m/%d/%Y') 
        WHEN  `date` LIKE '%-%' THEN STR_TO_DATE(`date` , '%m-%d-%Y')
        END;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE ;

SELECT *
FROM layoffs_staging2 ;

-- Null values and Blank values

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT DISTINCT industry
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL ;

SELECT *
FROM layoffs_staging2
WHERE company ='Airbnb';

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT company, LENGTH(company)
FROM layoffs_staging2
WHERE company LIKE '%Airbnb%';

SELECT DISTINCT company
FROM layoffs_staging2
WHERE company LIKE '%Airbnb%';

UPDATE layoffs_staging2
SET company = TRIM(company);

UPDATE layoffs_staging2
SET industry = 'Travel'
WHERE company = 'Airbnb';

UPDATE layoffs_staging2
SET industry = 'Travel'
WHERE company = 'Airbnb'
AND (industry IS NULL OR industry = '');



