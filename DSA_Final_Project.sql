--Project Phases and Tasks:
  --Phase 1: Database Design (DDL)
   --Task 1: Define the Database Schema | Description: Create the database schema for the library management system, defining 
	-- Create Database 
CREATE DATABASE Library
	-- Create Table Book
CREATE TABLE Books(
BookID INT NOT NULL PRIMARY KEY,
Title NVARCHAR(150) NOT NULL,
Author NVARCHAR(100),
Language NVARCHAR(50),
DatePublished DATE,
GenreID INT)

	-- Create Table Genre
CREATE TABLE Genre(
GenreID INT PRIMARY KEY,
Genre NVARCHAR(150))


   --Task 2: Specify Keys and Constraints | Description: Define primary keys, foreign keys, constraints, and relationships between tables.




