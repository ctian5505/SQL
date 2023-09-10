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
WHERE CustomerKey IN (
                      SELECT CustomerKey
                      FROM AdventureWorksDW2022..DimCustomer
                      WHERE FirstName = 'John' AND LastName = 'Smith'
                      )

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

-- Q8 Retrieve orders placed on or after January 1, 2014, and display results from the 11th row onward using OFFSET-FETCH
SELECT SalesOrderNumber, OrderDate, SalesAmount
FROM AdventureWorksDW2022..FactInternetSales
WHERE OrderDate = '2014-01-01'
ORDER BY OrderDate
OFFSET 10 ROW
FETCH NEXT 999999 ROW ONLY

-----INSERT STATEMENT
-- Q9
/* 
Insert a new product with the following details into the [dbo].[DimProduct] table:
ProductID: 9999
EnglishProductName : DSA Training'
Color: Gold'
Size: ‘XXL'
ListPrice: 49.99
*/
INSERT INTO AdventureWorksDW2022..DimProduct(ProductKey, EnglishProductName, Color, Size, ListPrice, SpanishProductName,FrenchProductName,FinishedGoodsFlag)
VALUES (9999, 'DSA Training', 'Gold', 'XXL', 49.99,' ',' ',' ')

-----UPDATE STATEMENT
  
-- Q10 Update the job Title of the employee with EmployeeID 101 in the [dbo].[DimEmployee] table to 'Software Engineer.'
UPDATE AdventureWorksDW2022..DimEmployee
SET Title = 'Software Engineer'
WHERE EmployeeKey = 101

----- DELETE STATEMENT
--Q11 Delete all products with a Weight less than or equal to 3 pound from the [dbo].[DimProduct] table.
DELETE FROM AdventureWorksDW2022..DimProduct
WHERE Weight <=3 AND WeightUnitMeasureCode = 'LB'
/*
  Can't Delete (
Msg 547, Level 16, State 0, Line 8
The DELETE statement conflicted with the REFERENCE constraint "FK_FactProductInventory_DimProduct". The conflict occurred in database "AdventureWorksDW2022", table "dbo.FactProductInventory", column 'ProductKey'.
The statement has been terminated.
)
*/

----- SUBQUERIES
-- Q12 Retrieve all products that have been ordered by customer John Smith' (FirstName = John' and LastName = Smith').
SELECT ProductKey, EnglishProductName, Color, Size,ListPrice
FROM AdventureWorksDW2022.dbo.DimProduct
WHERE ProductKey IN (
          						SELECT ProductKey
          						FROM AdventureWorksDW2022..FactInternetSales
          						WHERE CustomerKey IN (
                      												SELECT CustomerKey
                      												FROM AdventureWorksDW2022..DimCustomer
                      												WHERE FirstName = 'John' AND LastName = 'Smith'
                      												))

----- JOINS
-- Q13 Retrieve all orders along with customer details for orders placed on or after January 1, 2014, from the dbo.FactInternetSales and dimCustomer tables.
SELECT FIS.CustomerKey, FIS.SalesOrderNumber,FIS.OrderDate, DC.FirstName, DC.LastName, DC.Gender, DC.EmailAddress
FROM AdventureWorksDW2022..DimCustomer AS DC
JOIN AdventureWorksDW2022..FactInternetSales AS FIS
ON DC.CustomerKey = FIS.CustomerKey
WHERE OrderDate >= '2014-01-01'
ORDER BY OrderDate ASC

-----AGGREGATE FUNCTIONS
-- Q14 Calculate the total sales amount for each product category from the dbo.DimProduct and dbo.FactInternetSales tables. Display the results with the category name, subcategory name and the total sales amount order by category name.

SELECT DPC.EnglishProductCategoryName AS [Catergory Name], DPS.EnglishProductSubcategoryName AS [Subcategory Name],SUM(FIS.SalesAmount) AS [Sales Amount]
FROM AdventureWorksDW2022..DimProduct AS DP
JOIN AdventureWorksDW2022..DimProductSubcategory AS DPS
ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
JOIN AdventureWorksDW2022..DimProductCategory AS DPC
ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
JOIN AdventureWorksDW2022..FactInternetSales AS FIS
ON DP.ProductKey = FIS.ProductKey
GROUP BY DPC.EnglishProductCategoryName, DPS.EnglishProductSubcategoryName
ORDER BY [Catergory Name]

----- COMBINING CONCEPTS
-- Q15 Retrieve the top 5 customers with the highest total purchases from the [dbo].[DimCustomer] and [dbo].[FactInternetSales] tables. Display customer details along with their total purchases.
SELECT TOP 5 DC.CustomerKey, DC.FirstName, DC.LastName, SUM(FIS.SalesAmount) AS [Total Puchases]
FROM AdventureWorksDW2022..DimCustomer AS DC
JOIN AdventureWorksDW2022..FactInternetSales AS FIS
ON DC.CustomerKey = FIS.CustomerKey
GROUP BY DC.CustomerKey, DC.FirstName, DC.LastName
ORDER BY [Total Puchases] DESC


----- ADVANCED QUERY
-- Find the average quantity and total sales amount of products sold in each month of the year 2011 from the [dbo].[DimProduct] and [dbo].FactResellerSales tables.
SELECT  MONTH(OrderDate) AS Month, AVG(FRS.OrderQuantity) AS [Average Quantity], SUM(FRS.SalesAmount) AS [Total Sales]
FROM AdventureWorksDW2022..DimProduct AS DP
JOIN AdventureWorksDW2022..FactResellerSales AS FRS
ON DP.ProductKey = FRS.ProductKey
WHERE YEAR(OrderDate) = 2011
GROUP BY MONTH(OrderDate)
ORDER BY Month




