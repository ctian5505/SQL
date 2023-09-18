-- BEFORE Creatign Database click mixed mode to add user

--You need to create a role for the sales team, 'SalesTeam,' in the AdventureWorksDW2022 database.
--Task: Write the SQL query to create the 'SalesTeam' role.
CREATE ROLE SalesTeam

------------------------------------------------

--The sales team needs access to the 'FactInternetSales' table in the AdventureWorksDW2022 database to generate reports. However, they should only be able to view data, not modify it.
--Task: Write the SQL query to grant SELECT permission on the 'FactInternetSales' table to the 'SalesTeam' role.
GRANT SELECT ON [SalesSchema].[FactInternetSales] TO SalesTeam

-------------------------------------------------

--You hired a new member, 'NewSalesPerson,' for the sales team. You need to create a user for them.	
--Task: Write the SQL query to create the user 'NewSalesPerson' and associate it with the login
-- PS: If gagawa ng loh in , master dapat ang gamitin
USE master
CREATE LOGIN newuser001 WITH PASSWORD = 'newuser001password'
USE AdventureWorksDW2022
CREATE USER newsalesperson001 FOR LOGIN newuser001

EXEC sp_addrolemember 'SalesTeam', 'newsalesperson001'
-- PS: this command use to add role to a member

-----------------------------------------------

--'NewSalesPerson' should have the same permissions as the 'SalesTeam' role. You need to assign 'NewSalesPerson' to the 'SalesTeam' role.
--Task: Write the SQL query to add the user 'NewSalesPerson' to the 'SalesTeam' role.

USE master
CREATE LOGIN NewSalesPersonChan WITH PASSWORD = 'newsalesperson'
USE AdventureWorksDW2022
CREATE USER UserChan FOR LOGIN NewSalesPersonChan

EXEC sp_addrolemember 'SalesTeam', UserChan


------------------------------------------
--You want to verify that 'NewSalesPerson' has the appropriate permissions to access the 'FactInternetSales' table.
--Task: Write a SELECT query to retrieve data from the 'FactInternetSales' table using the 'NewSalesPerson' user.

SELECT *
FROM [SalesSchema].[FactInternetSales]

-------------------------------------------
--'NewSalesPerson' has completed their assignment and should no longer have access to the 'FactInternetSales' table. 
--Task: Write the SQL query to remove the user 'NewSalesPerson' from the 'SalesTeam' role.

EXEC  sp_droprolemember 'SalesTeam', 'newsalesperson001'


--------------------------------------------
--You want to grant SELECT permission to the 'SalesTeam' role on all tables within the 'Sales' schema in the AdventureWorksDW2022 database.
--Task: Write the SQL query to grant SELECT permission on all tables within the 'Sales' schema to the 'SalesTeam' role.

GRANT SELECT ON SCHEMA:: dbo TO SalesTeam;
--------------------------------------------
--Due to sensitive data in the 'DimEmployee' table, you need to deny SELECT permission to the ‘SalesTeam' users.
--Task: Write the SQL query to deny SELECT permission on the 'DimEmployee' table to the ‘SalesTeam' user.

DENY SELECT ON dbo.DimEmployee TO SalesTeam
---------------------------------------------
--You've hired two new sales team members, 'NewSalesPerson1' and 'NewSalesPerson2,' and you want to assign them to the 'SalesTeam' role.
--Task: Write the SQL queries to add both 'NewSalesPerson1' and 'NewSalesPerson2' to the 'SalesTeam' role.

USE master
CREATE LOGIN NewSalesPerson1 WITH PASSWORD = 'NewSalesPerson1'
USE AdventureWorksDW2022
CREATE USER UserPerson1 FOR LOGIN NewSalesPerson1

EXEC sp_addrolemember 'SalesTeam', UserPerson1

USE master
CREATE LOGIN NewSalesPerson2 WITH PASSWORD = 'NewSalesPerson2'
USE AdventureWorksDW2022
CREATE USER UserPerson2 FOR LOGIN NewSalesPerson2

EXEC sp_addrolemember 'SalesTeam', UserPerson2


------------------------------
--The sales team no longer requires access to the 'Sales' schema. You need to revoke all permissions on this schema.
--Task: Write the SQL query to revoke all permissions on the 'Sales' schema.

REVOKE ALL ON SCEHMA:: dbo TO public

----------------------------------
--Verify the permissions for various users and roles in the AdventureWorksDW2022 database after completing the previous exercises.
--Task: Write SQL queries to check the permissions for 'SalesTeam,' 'User2,' 'NewSalesPerson1,' and 'NewSalesPerson2' on various database objects.
 
