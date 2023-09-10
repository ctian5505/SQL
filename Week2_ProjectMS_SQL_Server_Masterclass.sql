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
Can't Delete (
Msg 547, Level 16, State 0, Line 8
The DELETE statement conflicted with the REFERENCE constraint "FK_FactProductInventory_DimProduct". The conflict occurred in database "AdventureWorksDW2022", table "dbo.FactProductInventory", column 'ProductKey'.
The statement has been terminated.
)

----- SUBQUERIES
-- Retrieve all products that have been ordered by customer John Smith' (FirstName = John' and LastName = Smith').
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

