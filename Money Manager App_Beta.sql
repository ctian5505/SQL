-- Creating Database
CREATE DATABASE MoneyManagerApp;

-- Crating table
CREATE TABLE Transactions(
Transaction_No INT IDENTITY(1,1) PRIMARY KEY,
Date DATETIME NOT NULL,
Transaction_Type NVARCHAR(10) NOT NULL,
Account_No NVARCHAR(50) NOT NULL,
Amount FLOAT NOT NULL,
Category NVARCHAR(50),
Note NVARCHAR(250)
)


-- Making a stored procedure that accept a transactions
