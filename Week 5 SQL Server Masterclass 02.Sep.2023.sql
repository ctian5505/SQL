-- EXERCISES ON DQL

-- Retrieve the first and last names of all employees in the "dbo.DimEmployee" table.
SELECT FirstName, LastName
FROM AdventureWorksDW2022..DimEmployee

-- Retrieve the product names and list prices for products in the "dbo.DimProduct" table where the list price is greater than $1,000.
SELECT EnglishProductName, ListPrice
FROM AdventureWorksDW2022..DimProduct
WHERE ListPrice > 1000
ORDER BY ListPrice

-- Retrieve the product names and standard costs for products in the "dbo.DimProduct" table, ordered by standard cost in descending order.

SELECT EnglishProductName, StandardCost
FROM AdventureWorksDW2022..DimProduct
ORDER BY StandardCost DESC

-- Retrieve the product names and category names for products in the "dbo.DimProduct" table along with their corresponding categories from the "dbo.DimProductCategory" table.

SELECT DP.EnglishProductName, DPC.EnglishProductCategoryName
FROM AdventureWorksDW2022..DimProduct AS DP
JOIN AdventureWorksDW2022..DimProductSubcategory AS DPS
ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
JOIN AdventureWorksDW2022..DimProductCategory AS DPC
ON DPS.ProductCategoryKey = DPC.ProductCategoryKey
ORDER BY DPC.EnglishProductCategoryName 

-- Calculate the total sales amount for each product in the "dbo.FactInternetSales" table and display the product names along with their total sales amounts.

SELECT DP.EnglishProductName AS [Product Name], SUM(FIS.SalesAmount) AS [Total Sale]
FROM AdventureWorksDW2022.SalesSchema.FactInternetSales AS FIS
JOIN AdventureWorksDW2022..DimProduct AS DP
ON FIS.ProductKey = DP.ProductKey
GROUP BY DP.EnglishProductName

--Find the number of employees in each department in the "dbo.DimDepartmentGroup" table and display the department names along with the employee counts.
		-- NO ANSWER / Invalid Data / No Relationship
		-- Alternative 
SELECT DepartmentName, COUNT(*) AS [Employee Count]
FROM AdventureWorksDW2022..DimEmployee
GROUP BY DepartmentName
ORDER BY [Employee Count] DESC



--Retrieve the first and last names of employees in the "dbo.DimEmployee" table who have a job title of "Production Technician/ Engineering Manager" (use a subquery).

SELECT FirstName, LastName, Title
FROM AdventureWorksDW2022..DimEmployee
WHERE Title IN (
				SELECT Title
				FROM AdventureWorksDW2022..DimEmployee
				WHERE Title = 'Engineering Manager'
				)

-- Create a CTE that calculates the average list price for products in the "dbo.DimProduct" table and then retrieve the product names along with their list prices, indicating whether each product's list price is above or below the average.

-- List Price Average 745.8999

	-- Static ListPrice
WITH CTE_ListPriceAverage AS (
SELECT EnglishProductName, ListPrice,
CASE
	WHEN ListPrice > 745.8999 THEN 'Above Average'
	ELSE 'Below Average'
END AS [Above or Below Average]
FROM AdventureWorksDW2022..DimProduct
WHERE ListPrice IS NOT NULL
)

SELECT * 
FROM CTE_ListPriceAverage
ORDER BY ListPrice DESC	
	-- Dynamic ListPrice ( Use this code so that if the list price add, the value will change
WITH CTE_AvgListPrice AS (	 
SELECT AVG(ListPrice) AS AvgPrice
FROM AdventureWorksDW2022..DimProduct
)
SELECT EnglishProductName, DP.ListPrice,
CASE
	WHEN DP.ListPrice > CTE_AvgListPrice.AvgPrice THEN 'Above Average'
	ELSE 'Below Average' 
END AS PriceCategory
FROM AdventureWorksDW2022..DimProduct AS DP
CROSS JOIN CTE_AvgListPrice
WHERE DP.ListPrice IS NOT NULL
ORDER BY ListPrice DESC

-- Calculate the cumulative sales amount for each day in the "dbo.FactInternetSales" table, ordered by date, and display the date along with the cumulative sales amount.

SELECT DISTINCT OrderDate, SUM(SalesAmount) OVER (ORDER BY OrderDate) AS CumualativeSalesPerDay
FROM AdventureWorksDW2022.SalesSchema.FactInternetSales
ORDER BY OrderDate

-- Retrieve the product names and standard costs for products in the "dbo.DimProduct" table where the standard cost is less than the average standard cost for all products, and the product name starts with the letter 'B'.

	-- AVG Standard Cost = 434.2658
SELECT EnglishProductName, SUM(StandardCost) AS StandardCost
FROM AdventureWorksDW2022..DimProduct
WHERE StandardCost < (
SELECT AVG(StandardCost)
FROM AdventureWorksDW2022..DimProduct)
AND EnglishProductName LIKE 'B%'
GROUP BY EnglishProductName
