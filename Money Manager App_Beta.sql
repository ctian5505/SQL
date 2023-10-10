-- Creating Database
CREATE DATABASE MoneyManagerApp;

-- Crating table
CREATE TABLE Transactions(
Transaction_No INT IDENTITY(1,1) PRIMARY KEY,
Date DATE NOT NULL,
Transaction_Type NVARCHAR(10) NOT NULL,
Account_No NVARCHAR(50) NOT NULL,
Amount FLOAT NOT NULL,
Category NVARCHAR(50),
Note NVARCHAR(250)
)


-- Making a stored procedure that accept a transactions
CREATE PROCEDURE Create_Transaction  
	@Date DATE, 
	@Transaction_Type NVARCHAR(10), 
	@Account_No NVARCHAR(50), 
	@Amount FLOAT, 
	@Category NVARCHAR(50),
	@Note NVARCHAR(250)
AS
BEGIN
INSERT INTO Transactions (Date, Transaction_Type, Account_No, Amount, Category,Note)
VALUES (@Date, @Transaction_Type, @Account_No, @Amount, @Category,@Note)
END

-- making first transaction
EXEC Create_Transaction '2000-01-01', 'Income', 'Cash on hand ' , 1000,' ','Salary'

-- Renaming the column Account_No to Account_Name
EXEC sp_rename 'Transactions.Account_No', 'Account_Name', 'COLUMN';

-- Update the stored procedure (Becasue of changes at Account_Name)
ALTER PROCEDURE Create_Transaction  
	@Date DATE, 
	@Transaction_Type NVARCHAR(10), 
	@Account_Name NVARCHAR(50), 
	@Amount FLOAT, 
	@Category NVARCHAR(50),
	@Note NVARCHAR(250)
AS
BEGIN
INSERT INTO Transactions (Date, Transaction_Type, Account_Name, Amount, Category,Note)
VALUES (@Date, @Transaction_Type, @Account_Name, @Amount, @Category,@Note)
END

-- adding new transaction to check if the stored procedure are working properly
EXEC Create_Transaction '2000-01-02', 'Expenses', 'Cash on hand', 50, 'Food', 'Shomai'
