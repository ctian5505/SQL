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


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Modifying Columns
/*
Q4 Modify the "LastName" column in the " DimEmployee" table to allow a maximum of 75 characters.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Deleting Columns
/*
Q5 Remove the “NameStyle" column from the “Employee" table.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Primary Key Constraint
/*
Q6 Add a primary key constraint to the "DimDate" table for the "DateKey" column
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Foreign Key Constraint
/*
Q7 Add a foreign key constraint to the "FactInternetSales" table referencing the "DimDate" table's "DateKey" column.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Adding Check Constraint
/*
Q8 Add a check constraint to the "Product" table to ensure that the "StandardCost" column value is greater than 0.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Clustered Index
/* 
Q8 Create a clustered index on the "FactInternetSales" table's "OrderDateKey" column.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a Non-Clustered Index
/*
Q9 Create a non-clustered index on the "Product" table's "ProductSubcategoryKey" column
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Dropping an Index
/*
Q10 Drop the non-clustered index you created on the "Product" table.
*/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Activity # 2 - :Creating a View
/*
Q11 Create a view named "SalesSummary" that displays the total sales amount, order date, and customer name from the "FactInternetSales" and "DimCustomer" tables.
*/


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




