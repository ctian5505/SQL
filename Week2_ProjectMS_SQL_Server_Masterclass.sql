-- EXERCISE - BASIC SELECT QUERIES

-- Q1. Retrieve the first 5 products from the Product table.
SELECT TOP 5 *
FROM AdventureWorksDW2022..DimProduct

-- Q2. Get the top 10 employees from the Employee table along with their job titles.
SELECT TOP 10 EmployeeKey, FirstName, LastName, Title
FROM AdventureWorksDW2022..DimEmployee

-- Q3

-- Q4 -- Q4 Get all products with a weight greater than 10 pounds (Weight > 10) from the [dbo].[DimProduct] table.
SELECT ProductKey, EnglishProductName, Weight, WeightUnitMeasureCode
FROM AdventureWorksDW2022..DimProduct
WHERE Weight > 10 and WeightUnitMeasureCode = 'LB'
