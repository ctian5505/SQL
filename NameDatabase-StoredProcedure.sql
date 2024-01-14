-- Create Database
CREATE DATABASE NameDatabase

-- Create table
Create table  NameDatabase(
NameID int primary key not null,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
NickName nvarchar(50),
RegistrationDate date not null
)


--- Creating Stored Procedure
CREATE Procedure EXEC_Refresh
AS
BEGIN
  -- Cleaning the data header match of the imported files, match the source header to the database header format to avoid error and store it to a temporary table [Temp_table]
	SELECT
		NULLIF([Name ID], '') AS NameID,
		NULLIF([First Name], '') AS FirstName,
		NULLIF([Last Name], '') AS LastName,
		NULLIF([Nick Name], '') AS NickName,
		NULLIF([Registration Date], '') AS RegistrationDate
	INTO
		Temp_table
	FROM
		dbo.Source$
  
-- Formating the Data type of Temp table match to the Database format
	Alter Table Temp_table
	ALTER Column NameID int not null

	Alter Table Temp_table
	ALTER Column FirstName nvarchar(50) not null

	Alter Table Temp_table
	ALTER Column LastName nvarchar(50) not null

	Alter Table Temp_table
	ALTER Column NickName nvarchar(50)

	Alter Table Temp_table
	ALTER Column RegistrationDate date not null

-- Data Merging from source file to the database
	MERGE NameDatabase AS target using Temp_table AS source on target.NameID = source.NameID WHEN MATCHED THEN 
	  --- This block of code is executed when the soucreID[Temp_table] and targetID[NameDatabase] has match, it simply means that the imformation is already existed and just need an update.
	UPDATE
	SET
		target.NameID = source.NameID,
		target.FirstName = source.FirstName,
		target.LastName = source.LastName,
		target.NickName = source.NickName,
		Target.RegistrationDate = source.RegistrationDate

  	--- This block of code executed when the sourceid[Temp_table] didnt exist on targetID[NameDatabase], it means that this is a new data and need to be inserted
	WHEN NOT MATCHED by Target then
	INSERT(
	NameID,FirstName,LastName,NickName,RegistrationDate)
	VALUES(
	source.NameID,source.FirstName,source.LastName,source.NickName,source.RegistrationDate);

	-- Dropping the source table to save space
	DROP TABLE Source$
	-- Dropping the Temp table because it is no longer useful
	DROP TABLE Temp_table
END
