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

1:59:46
