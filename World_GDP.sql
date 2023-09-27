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
