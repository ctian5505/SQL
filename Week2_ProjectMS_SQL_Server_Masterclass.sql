----- EXERCISE - BASIC SELECT QUERIES

-- Q1. Retrieve the first 5 products from the Product table.
SELECT TOP 5 *
FROM AdventureWorksDW2022..DimProduct

-- Q2. Get the top 10 employees from the Employee table along with their job titles.
SELECT TOP 10 EmployeeKey, FirstName, LastName, Title
FROM AdventureWorksDW2022..DimEmployee

----- EXERCISE - WHERE CLAUSE
-- Q3 Retrieve all orders placed by customer 'John Smith' (FirstName = 'John' and LastName = 'Smith') from the [dbo].[FactInternetSales] table.
SELECT ProductKey, SalesOrderNumber, OrderDate, SalesAmount
FROM AdventureWorksDW2022..FactInternetSales
WHERE CustomerKey IN 
(SELECT CustomerKey
FROM AdventureWorksDW2022..DimCustomer
WHERE FirstName = 'John' AND LastName = 'Smith')


--Q4 Get all products with a weight greater than 10 pounds (Weight > 10) from the [dbo].[DimProduct] table.
SELECT ProductKey, EnglishProductName, Weight, WeightUnitMeasureCode
FROM AdventureWorksDW2022..DimProduct
WHERE Weight > 10 and WeightUnitMeasureCode = 'LB'

  
----- ORDER BY CLAUSE
-- Q5 Get the top 5 products with the lowest list prices from the [dbo].[DimProduct] table.
SELECT TOP 5 ProductKey, EnglishProductName, ListPrice
FROM AdventureWorksDW2022..DimProduct
ORDER BY ListPrice

-- Q6 Retrieve the 10 oldest orders from the [dbo].[FactInternetSales] table, sorted by the order date in ascending order.
SELECT TOP 10 ProductKey, SalesOrderNumber, SalesAmount, OrderDate
FROM AdventureWorksDW2022..FactInternetSales
ORDER BY OrderDate ASC

-----OFFSET-FETCH CLAUSE
-- Q7 Get the 6th to 10th products with the highest list prices from the [dbo].[DimProduct] table.
SELECT ProductKey, EnglishProductName, ListPrice
FROM AdventureWorksDW2022..DimProduct
ORDER BY ListPrice DESC
OFFSET 5 ROW FETCH NEXT 5 ROWS ONLY



