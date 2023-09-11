-- Activity # 2 - Creating a Schema

-- Q1 Create a new schema called "SalesSchema".
CREATE SCHEMA SalesSchema;

-- Q2Move the "FactInternetSales" table into the "SalesSchema" schema.
ALTER SCHEMA SalesSchema 
TRANSFER dbo.FactInternetSales;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - Creating a Table
/*
Q2 Create a new table named "ProductReviews" with columns: ReviewID (INT), ProductID (INT), Rating (INT), ReviewText (VARCHAR), and ReviewDate (DATE).
*/
CREATE TABLE ProductReviews (
ReviewID INT PRIMARY KEY,
ProductID INT,
Rating INT,
ReviewText VARCHAR(MAX),
ReviewDate DATE
)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - Adding Columns
/*
Q3 Add a column named “LinkedIn URL" of type VARCHAR(MAX) to the "DimEmployee" table.
*/
ALTER TABLE AdventureWorksDW2022..DimEmployee
ADD LinkedInURL VARCHAR(100);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying Columns
/*
Q4 Modify the "LastName" column in the " DimEmployee" table to allow a maximum of 75 characters.
*/
ALTER TABLE AdventureWorksDW2022..DimEmployee
ALTER COLUMN LastName Varchar(75)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Deleting Columns
/*
Q5 Remove the “NameStyle" column from the “Employee" table.
*/
ALTER TABLE AdventureWorksDW2022..DimEmployee
DROP COLUMN NameStyle;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Primary Key Constraint
/*
Q6 Add a primary key constraint to the "DimDate" table for the "DateKey" column
*/
ALTER TABLE AdventureWorksDW2022..DimDate
ADD CONSTRAINT 
PK_DimDate PRIMARY KEY(DateKey);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Foreign Key Constraint
/*
Q7 Add a foreign key constraint to the "FactInternetSales" table referencing the "DimDate" table's "DateKey" column.
*/
ALTER TABLE AdventureWorksDW2022.SalesSchema.FactInternetSales
ADD CONSTRAINT FK_FactInternetSales_DimDate
FOREIGN KEY(OrderDateKey)
REFERENCES DimDate(DateKey);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Check Constraint
/*
Q8 Add a check constraint to the "Product" table to ensure that the "StandardCost" column value is greater than 0.
*/
ALTER TABLE AdventureWorksDW2022..DimProduct
ADD CONSTRAINT CHK_Product_StandardCost
CHECK (StandardCost > 0)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Clustered Index
/* 
Q8 Create a clustered index on the "FactInternetSales" table's "OrderDateKey" column.
*/
--DROP the existing INDEX FIRST
ALTER TABLE salesSchema.FactInternetSales DROP CONSTRAINT PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber;
ALTER TABLE dbo.FactInternetSalesReason DROP CONSTRAINT FK_FactInternetSalesReason_FactInternetSales;
--Create the new INDEX
CREATE CLUSTERED INDEX IX_FactInternetSales_OrderDateKey
ON SalesSchema.FactInternetSales(OrderDateKey);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Non-Clustered Index
/*
Q9 Create a non-clustered index on the "Product" table's "ProductSubcategoryKey" column
*/
CREATE NONCLUSTERED INDEX IX_Product_ProductSubcategoryKey 
ON AdventureWorksDW2022..dimProduct(ProductSubcategoryKey);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying Index Columns
/*
Modify the existing clustered index on the "FactInternetSales" table to include the "ResellerKey" and "ProductKey" columns.
*/
CREATE NONCLUSTERED INDEX IX_FactInternetSales_ProductKey 
ON AdventureWorksDW2022.salesschema.FactInternetSales(ProductKey);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Dropping an Index
/*
Q10 Drop the non-clustered index you created on the "Product" table.
*/
DROP INDEX AdventureWorksDW2022..dimProduct.IX_Product_ProductSubcategoryKey;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a View
/*
Q11 Create a view named "SalesSummary" that displays the total sales amount, order date, and customer name from the "FactInternetSales" and "DimCustomer" tables.
*/
CREATE VIEW SalesSummary AS(
SELECT s.OrderDateKey, c.LastName, c.firstname, SUM(s.SalesAmount) AS TotalSales
FROM AdventureWorksDW2022.SalesSchema.FactInternetSales s
JOIN AdventureWorksDW2022..DimCustomer c ON s.CustomerKey = c.CustomerKey
GROUP BY s.OrderDateKey, c.LastName, c.firstname
)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying a View
/*
Q12 Modify the "SalesSummary" view to also include the "ProductKey" and "ProductName" from the "DimProduct" table.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Dropping a View
/*
Q13 Drop the "SalesSummary" view you created.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Schema and Table with Constraints
/*
Q14 Create a new schema "HRSchema" and a table "Employees" with columns: EmployeeID (INT), FirstName (VARCHAR), LastName (VARCHAR), and BirthDate (DATE).
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Schema and Table with Constraints
/*
Q15 Modify the "SalesSummary" view to also include the "ProductKey" and "ProductName" from the "DimProduct" table.

Q16 Add a primary key constraint on the "EmployeeID" column and a check constraint to ensure employees are at least 18 years old.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying Constraint Definitions
-- @PDF https://docs.google.com/presentation/d/1SOwdSKCg5r_pQVLk0QoS59X6JRtBAxvM/edit#slide=id.p37




