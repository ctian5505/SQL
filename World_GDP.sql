-- Data from kaggle | Downloaded 9/26/23
-- https://www.kaggle.com/datasets/sazidthe1/world-gdp-data

USE World_GDP

--- Find the disctinct value of region in table country codes
SELECT 
	DISTINCT(region)
FROM country_codes

--- Rank the highest gdp percent change per year in 'Afghanistan'

WITH CTE_gdp_data AS (
SELECT 
	country_name,
	country_code,
	year,
	value AS [Present_GDP%],
	LAG(value) OVER (ORDER BY year) AS [Previous_GDP%]
FROM gdp_data
WHERE country_name = 'Afghanistan'
)

SELECT country_name,
	year,
	(([Present_GDP%]-[Previous_GDP%])/[Previous_GDP%])*100 AS GDP_Percent_Change_Per_Year,
	RANK() OVER (ORDER BY (([Present_GDP%]-[Previous_GDP%])/[Previous_GDP%])*100 DESC) RANK
FROM CTE_gdp_data
WHERE [Previous_GDP%] IS NOT NULL


---- RANK THE GDP VALUE OF EACH COUNTRY ON YEAR 2000

WITH CTE AS 
(
SELECT country_name, gd.country_code, gd.year, gd.value,cc.region, cc.income_group
FROM gdp_data AS gd
LEFT JOIN country_codes as cc
ON gd.country_code = cc.country_code
WHERE cc.country_code IS NOT NULL 
)

SELECT 
	country_name, 
	year, 
	value,
	RANK() OVER (ORDER BY value DESC) AS[GDP_Rank(Year_2000)]
FROM CTE
WHERE year = '2000'

--- FIND THE LATEST GDP OF EACH COUNTRY 

WITH CTE AS (
SELECT 
	gd.country_name,
	cc.country_code,
	gd.year,
	gd.value,
	RANK() OVER (PARTITION BY cc.country_code ORDER BY year DESC) AS Rnk
FROM gdp_data AS gd
LEFT JOIN country_codes AS cc
ON GD.country_code = CC.country_code
WHERE CC.country_code IS NOT NULL
)

SELECT 
	country_name,
	country_code,
	year,
	value,
	RANK() OVER (ORDER BY value DESC) Rank_by_country 
FROM CTE
WHERE Rnk = 1
