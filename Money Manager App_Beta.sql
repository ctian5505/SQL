-- Imported Data that I created : @Kaggle
-- Imported 2nd Data that I created : @Kaggle

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

-- Inserting the data from imported csv and cleaned 
INSERT INTO Transactions
SELECT Date, Tranasction_Type AS Transaction_Type, AccOUNT_Name as Account_name, Amount, Category, ISNULL(Note, ' ') AS Note 
FROM ImportedTransactions

-- Updating Transaction no 1 by adding its category
UPDATE Transactions
SET Category = 'Salary'
WHERE Transaction_No = 1

-- Creating a database for all income
CREATE TABLE Income (
Transaction_No INT,
Transaction_Type NVARCHAR(50),
Account_Name NVARCHAR(50),
Amount FLOAT, 
Category NVARCHAR(50), 
Note NVARCHAR(250)
)

-- Adding Date column on income table
ALTER TABLE Income
ADD [Date] DATE

-- Inserting all income transaction from table transaction to table income
INSERT INTO Income
SELECT 
	Transaction_No,  
	Transaction_Type, 
	Account_Name,
	Amount,
	Category, 
	Note,
	Date
FROM 
	Transactions
WHERE 
	Transaction_Type = 'Income'

-- Creating Expenses Table
CREATE TABLE Expenses(
	Transaction_No INT,  
	Transaction_Type NVARCHAR(50), 
	Account_Name NVARCHAR(50),
	Amount FLOAT ,
	Category NVARCHAR(50), 
	Note NVARCHAR(250),
	Date DATE
)

-- Inserting all the expenses transaction from table transaction to table expenses
INSERT INTO Expenses
SELECT 
	Transaction_No, 	
	Transaction_Type, 
	Account_Name, 
	Amount, 
	Category, 
	Note,
	Date
FROM 
	Transactions
WHERE 
	Transaction_Type = 'Expenses'

-- Making a view for account type cash on hand
CREATE VIEW Cash_on_hand AS
SELECT
	t.Transaction_No,
	T.Transaction_Type,
	T.Date,
	T.Account_Name,
	T.Category,
	ISNULL(E.Amount, 0) AS Expenses,
	ISNULL(I.Amount, 0) AS Income
FROM
	Transactions AS T
LEFT JOIN
	Expenses AS E
ON
	T.Transaction_No = E.Transaction_No
LEFT JOIN
	Income AS I
ON 
	T.Transaction_No = I.Transaction_No
WHERE
	T.Account_Name = 'Cash on hand'

-- make a stored procedure that when executed will  display the cumulative balance of the account
CREATE PROCEDURE 
	Cash_on_hand_Balance 
	AS
BEGIN
	SELECT *, 
	SUM(Income-Expenses) OVER (ORDER BY Transaction_No) AS Cumulative_Balance
FROM 
	Cash_on_hand
END

	-- EXEC Cash_on_hand_Balance

-- Importing new datasets
INSERT INTO Transactions
SELECT Date, Transaction_Type, Account_Name, Amount, Category, ISNULL(Note, '') AS NOTE FROM SecondDatasets

-- Creating a stored procedure that when executed, the income table aotumatically add the new income transactions from transactions table
CREATE PROCEDURE Income_Refresh AS
BEGIN
INSERT INTO Income
SELECT
	T.Transaction_No,
    T.Transaction_Type,
    T.Account_Name,
    T.Amount,
    T.Category,
    T.Note,
    T.Date
FROM 
	Transactions AS T
LEFT JOIN
	INCOME AS I
ON
T.Transaction_No = I.Transaction_No
WHERE T.Transaction_Type = 'Income' AND I.Transaction_No IS NULL
END

-- Creating a stored procedure that when executed, the Expenses table aotumatically add the new Expenses transactions from transactions table

CREATE PROCEDURE Expenses_Refresh AS
BEGIN
SELECT
	T.Transaction_No,
    T.Transaction_Type,
    T.Account_Name,
    T.Amount,
    T.Category,
    T.Note,
    T.Date
FROM 
	Transactions AS T
LEFT JOIN
	Expenses AS E
ON
T.Transaction_No = E.Transaction_No
WHERE T.Transaction_Type = 'Expenses' AND E.Transaction_No IS NULL
END
