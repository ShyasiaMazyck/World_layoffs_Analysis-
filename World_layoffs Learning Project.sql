SELECT *
FROM layoffs;

--- remove any duplicates 
--- stndardize the data 
--- null values or blank values 
--- remove any columns 

---- Removing Duplicates

CREATE TABLE layoffs_staging 
LIKE layoffs; 


SELECT *
FROM layoffs_staging;

INSERT layoffs_staging 
SELECT *
FROM layoffs;


SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry, `source`, stage, funds_raised, country, date_added) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry, `source`, stage, funds_raised, country, date_added) AS row_num
FROM layoffs_staging)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` int DEFAULT NULL,
  `country` text,
  `date_added` text,
  `row_num` INT 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry, `source`, stage, funds_raised, country, date_added) AS row_num
FROM layoffs_staging;


---- Standardizing data (finding issues within the dataset)

SELECT DISTINCT company
FROM layoffs_staging2;

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Auckland%';

UPDATE layoffs_staging2
SET location = 'Auckland,Non-U.S.'
WHERE location LIKE 'Auckland%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Bengaluru%';

UPDATE layoffs_staging2
SET location = 'Bengaluru,Non-U.S.'
WHERE location LIKE 'Bengaluru%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Brisbane%';

UPDATE layoffs_staging2
SET location = 'Brisbane,Non-U.S.'
WHERE location LIKE 'Brisbane%';



SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Gurugram%';

UPDATE layoffs_staging2
SET location = 'Gurugram,Non-U.S.'
WHERE location LIKE 'Gurugram%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Kuala lumpur%';

UPDATE layoffs_staging2
SET location = 'Kuala lumpur,Non-U.S.'
WHERE location LIKE 'Kuala lumpur%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Singapore%';

UPDATE layoffs_staging2
SET location = 'Singapore,Non-U.S.'
WHERE location LIKE 'Singapore%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Tel Aviv%';

UPDATE layoffs_staging2
SET location = 'Tel Aviv,Non-U.S.'
WHERE location LIKE 'Tel Aviv%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Luxembourg%';

UPDATE layoffs_staging2
SET location = 'Luxembourg,Non-U.S.'
WHERE location LIKE 'Luxembourg%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Melbourne%';

UPDATE layoffs_staging2
SET location = 'Melbourne,Non-U.S.'
WHERE location LIKE 'Melbourne%';

SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Montreal%';

UPDATE layoffs_staging2
SET location = 'Montreal,Non-U.S.'
WHERE location LIKE 'Montreal%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Mumbai%';

UPDATE layoffs_staging2
SET location = 'Mumbai,Non-U.S.'
WHERE location LIKE 'Mumbai%';


SELECT *
FROM layoffs_staging2
WHERE location LIKE 'New Delhi%';

UPDATE layoffs_staging2
SET location = 'New Delhi,Non-U.S.'
WHERE location LIKE 'New Delhi%';

SELECT *
FROM layoffs_staging2
WHERE location LIKE 'New Delhi%';



SELECT DISTINCT country 
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'UAE%';

UPDATE layoffs_staging2
SET country = 'United Arab Emirates'
WHERE country LIKE 'UAE%';


SELECT DISTINCT stage 
FROM layoffs_staging2
ORDER BY 1;
SELECT DISTINCT source 
FROM layoffs_staging2
ORDER BY 1;

SELECT `date`
FROM layoffs_staging2;

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2 
MODIFY COLUMN `date` DATE;

--- Working with null/blank values 
SELECT*
FROM layoffs_staging2
;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
	AND t2.industry IS NOT NULL;


SELECT*
FROM layoffs_staging2


---Removing Columnss/rowss;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging2
WHERE total_laid_off = ''
AND percentage_laid_off = '';

DELETE
FROM layoffs_staging2
WHERE total_laid_off = ''
AND percentage_laid_off = '';


SELECT *
FROM layoffs_staging2;

---dropping row_num column;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


