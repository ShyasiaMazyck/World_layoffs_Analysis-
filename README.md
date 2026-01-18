# World_layoffs_Analysis: SQL analysis of world layoffs with supply chain insights

## About This Project
This project was completed as a personal learning and portfolio project to practice SQL, data cleaning, and supply chain-focused analysis.
The insights are based on a publicly available global layoffs dataset and demonstrate workforce risk, industry trends, and operational considerations relevant to supply Chain roles.

## Project Objective
Analyze global layoffs trends across industries, countries, and time to identify workforce risk patterns and economic signals impacting supply chain-related sectors, including logistics, manufacturing, retail, and transportation, to inform workforce planning decisions. 

## Dataset Overview
- Source: Publicly available dataset by Kaggle (https://www.kaggle.com/datasets/swaptr/layoffs-2022)
- Columns Included:
    - Company
    - Location
    - Total_laid_off
    - Date
    - Percentage_laid_off
    - Industry
    - Source
    - Stage
    - Funds_raised
    - Country
    - Date_added
 
**Note:** The dataset is used for educational and portfolio purposes only. All rights remain with the original author.

## Tools & Skills
- SQL (MySQL)
- Data Analysis
- Business Insights

## Key Insights 
1. Retail companies showed the hightest complete workforce reductions(100% layoffs), indicating eleveated workforce instability in costomer-facing supply chain segments
2. Transportation-related companies had the highest funds_raised among other companies that experienced complete workforce reductions(100% layoff), reflecting that high funding alone does not eliminate workforce instability in logistics sectors.
3. Amazon showed the highest total layoffs during 2020-2025, reflecting large-scale workforce adjustments in response to post-pandemic demand normalization.
4. The United States had the highest volume of layoffs, suggesting significant workforce instability in a key global supply chain hub.
5. Layoffs spiked in 2023, marking a significant increase from 2020-2022, followed by a downward trend in 2024 and 2025. This pattern indicates that companies were responding to a potential overcapacity of employees post-pandemic, signaling a transition towards a stable workforce demand and operational capacity.
6. Year to year analysis shows that the largest layoffs were among major global firms (e.g., Uber, ByteDance, Meta, Amazon, Intel), suggesting workforce reductions were driven by wider macroeconomic conditions rather than company-specific performance. 


## Sample SQL Queries 

-- Company that had the Most Funding
SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised DESC;

-- Year with the most layoffs
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;
