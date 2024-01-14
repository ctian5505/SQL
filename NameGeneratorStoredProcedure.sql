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
