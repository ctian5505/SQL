-- Data I made: 
-- Create Database 
CREATE DATABASE HR

-- Making a database diagram
  -- import the data to the database
  
-- transfer the data into designated table ( Attendance$ - Attendance )

INSERT INTO Attendance
SELECT * FROM Attendance$
-- transfer the data into designated table ( Employee$ - Employee )
INSERT INTO Employee
SELECT * FROM Employee$

-- transfer the data into designated table ( Department$ - Department )
INSERT INTO Department
SELECT * FROM Department$
-- transfer the data into designated table ( Manager$ - Manager )
INSERT INTO Manager
SELECT * FROM 
  


--
