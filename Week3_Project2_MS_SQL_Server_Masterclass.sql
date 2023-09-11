-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - Creating a Schema

-- Q1 Create a new schema called "SalesSchema".
     CREATE SCHEMA SalesSchema;

-- Q2 Move the "FactInternetSales" table into the "SalesSchema" schema.
     ALTER SCHEMA SalesSchema 
     TRANSFER dbo.FactInternetSales;

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - Creating a Table

--Q3 Create a new table named "ProductReviews" with columns: ReviewID (INT), ProductID (INT), Rating (INT), ReviewText (VARCHAR), and ReviewDate (DATE).
     CREATE TABLE ProductReviews (
     ReviewID INT PRIMARY KEY,
     ProductID INT,
     Rating INT,
     ReviewText VARCHAR(MAX),
     ReviewDate DATE
     )

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - Adding Columns

-- Q4 Add a column named “LinkedIn URL" of type VARCHAR(MAX) to the "DimEmployee" table.
     ALTER TABLE AdventureWorksDW2022..DimEmployee
     ADD LinkedInURL VARCHAR(100);

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying Columns

-- Q5 Modify the "LastName" column in the " DimEmployee" table to allow a maximum of 75 characters.
     ALTER TABLE AdventureWorksDW2022..DimEmployee
     ALTER COLUMN LastName Varchar(75)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Deleting Columns

-- Q6 Remove the “NameStyle" column from the “Employee" table.
     ALTER TABLE AdventureWorksDW2022..DimEmployee
     DROP COLUMN NameStyle;

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Primary Key Constraint

-- Q7 Add a primary key constraint to the "DimDate" table for the "DateKey" column
     ALTER TABLE AdventureWorksDW2022..DimDate
     ADD CONSTRAINT 
     PK_DimDate PRIMARY KEY(DateKey);

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Foreign Key Constraint

-- Q8 Add a foreign key constraint to the "FactInternetSales" table referencing the "DimDate" table's "DateKey" column.
     ALTER TABLE AdventureWorksDW2022.SalesSchema.FactInternetSales
     ADD CONSTRAINT FK_FactInternetSales_DimDate
     FOREIGN KEY(OrderDateKey)
     REFERENCES DimDate(DateKey);

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Check Constraint

-- Q9 Add a check constraint to the "Product" table to ensure that the "StandardCost" column value is greater than 0.
     ALTER TABLE AdventureWorksDW2022..DimProduct
     ADD CONSTRAINT CHK_Product_StandardCost
     CHECK (StandardCost > 0)

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Clustered Index
 
-- Q10 Create a clustered index on the "FactInternetSales" table's "OrderDateKey" column.
     --DROP the existing INDEX FIRST
          ALTER TABLE salesSchema.FactInternetSales DROP CONSTRAINT PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber;
          ALTER TABLE dbo.FactInternetSalesReason DROP CONSTRAINT FK_FactInternetSalesReason_FactInternetSales;
     --Create the new INDEX
          CREATE CLUSTERED INDEX IX_FactInternetSales_OrderDateKey
          ON SalesSchema.FactInternetSales(OrderDateKey);

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Non-Clustered Index

-- Q11 Create a non-clustered index on the "Product" table's "ProductSubcategoryKey" column
     CREATE NONCLUSTERED INDEX IX_Product_ProductSubcategoryKey 
     ON AdventureWorksDW2022..dimProduct(ProductSubcategoryKey);
-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying Index Columns

-- Q12Modify the existing clustered index on the "FactInternetSales" table to include the "ResellerKey" and "ProductKey" columns.
     CREATE NONCLUSTERED INDEX IX_FactInternetSales_ProductKey 
     ON AdventureWorksDW2022.salesschema.FactInternetSales(ProductKey);

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Dropping an Index

-- Q13 Drop the non-clustered index you created on the "Product" table.
     DROP INDEX AdventureWorksDW2022..dimProduct.IX_Product_ProductSubcategoryKey;

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a View

--Q14 Create a view named "SalesSummary" that displays the total sales amount, order date, and customer name from the "FactInternetSales" and "DimCustomer" tables.
     CREATE VIEW SalesSummary AS(
     SELECT s.OrderDateKey, c.LastName, c.firstname, SUM(s.SalesAmount) AS TotalSales
     FROM AdventureWorksDW2022.SalesSchema.FactInternetSales s
     JOIN AdventureWorksDW2022..DimCustomer c ON s.CustomerKey = c.CustomerKey
     GROUP BY s.OrderDateKey, c.LastName, c.firstname
     )

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying a View

-- Q15 Modify the "SalesSummary" view to also include the "ProductKey" and "ProductName" from the "DimProduct" table.
     ALTER VIEW SalesSummary AS
     SELECT s.OrderDateKey, c.LastName, c.firstname, p.ProductKey, p.EnglishProductName, SUM(s.SalesAmount) AS TotalSales
     FROM SalesSchema.FactInternetSales s
     JOIN DimCustomer c ON s.CustomerKey = c.CustomerKey
     JOIN DimProduct p ON s.ProductKey = p.ProductKey
     GROUP BY s.OrderDateKey, c.LastName, c.firstname,p.ProductKey, p.EnglishProductName;

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Dropping a View

-- Q16 Drop the "SalesSummary" view you created.
     DROP VIEW SalesSummary;

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Schema and Table with Constraints

-- Q17 Create a new schema "HRSchema" and a table "Employees" with columns: EmployeeID (INT), FirstName (VARCHAR), LastName (VARCHAR), and BirthDate (DATE).
     CREATE SCHEMA HRSchema;
     CREATE TABLE HRSchema.Employees (
          EmployeeID INT PRIMARY KEY,
          FirstName VARCHAR(50),
          LastName VARCHAR(50),
          BirthDate DATE,
          CONSTRAINT CHK_Employees_Age CHECK (DATEDIFF(YEAR, BirthDate, GETDATE()) >= 18));
                                    
-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Schema and Table with Constraints

-- Q18 Modify the "SalesSummary" view to also include the "ProductKey" and "ProductName" from the "DimProduct" table.
     ALTER VIEW SalesSummary AS 
     SELECT s.OrderDateKey, c.LastName, c.firstname, p.ProductKey, p.EnglishProductName, SUM(s.SalesAmount) AS TotalSales
     FROM SalesSchema.FactInternetSales s
     JOIN DimCustomer c ON s.CustomerKey = c.CustomerKey
     JOIN DimProduct p ON s.ProductKey = p.ProductKey
     GROUP BY s.OrderDateKey, c.LastName, c.firstname,p.ProductKey, p.EnglishProductName;
 
-- Q19 Add a primary key constraint on the "EmployeeID" column and a check constraint to ensure employees are at least 18 years old.
     --Add a primary key constraint on the "EmployeeID" column.
     ALTER TABLE dbo.DimEmployee DROP CONSTRAINT PK_DimEmployee_EmployeeKey;
     ALTER TABLE dbo.FactResellerSales DROP CONSTRAINT FK_FactResellerSales_DimEmployee;
     -- Add a check constraint to ensure employees are at least 18 years old
     ALTER TABLE dbo.DimEmployee
     ADD CONSTRAINT CHK_DimEmployee_Age CHECK (DATEDIFF(YEAR, BirthDate, GETDATE()) >= 18);

-------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying Constraint Definitions

-- Q20 Modify the "Employees" table's check constraint to ensure employees are at least 21 years old.
     ALTER TABLE HRSchema.Employees
     DROP CONSTRAINT CHK_Employees_Age;
     ALTER TABLE HRSchema.Employees
     ADD CONSTRAINT CHK_Employees_Age CHECK (DATEDIFF(YEAR, BirthDate, GETDATE()) >= 21);

-- Q21 Alter the "Employees" table's primary key constraint to use a non-clustered index.
     ALTER TABLE HRSchema.Employees
     DROP CONSTRAINT PK__Employee__7AD04FF1CB1092A2;
     
     ALTER TABLE HRSchema.Employees
     ADD CONSTRAINT PK_Employees PRIMARY KEY CLUSTERED (EmployeeID);



