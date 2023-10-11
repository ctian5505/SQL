-- Data I made: 
-- Create Database 
CREATE DATABASE HR

-- Making a database diagram
    -- Database diagram image : 
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

  -- transfer the data into designated table ( Job_Title$ - Job_Title )
INSERT INTO Job_Title
SELECT * FROM Job_Title$
 
-- Delete all the imported data 
DROP TABLE Attendance$
DROP TABLE Department$
DROP TABLE Employee$
DROP TABLE Job_Title$
DROP TABLE Manager$


-- Display the department and job title of each employee and its hourly salary

SELECT 
	Emp.Employee_ID, Emp.First_Name, Emp.Middle_Name, Emp.Last_Name, Dept.Department_name, Job_T.Job_Title, Job_T.Hourly_Salary 
FROM 
	Employee AS Emp
LEFT JOIN
	Department AS Dept
ON
	Emp.Department_ID = Dept.Department_ID
LEFT JOIN
	Job_Title AS Job_T
ON
	Emp.Job_Title_ID = Job_T.Job_Title_ID

-- Calculate the salary of each employee for the day of 2020-01-01 - 2020-01-02

SELECT 
	at.Employee_ID
	, emp.First_Name
	, emp.Last_Name
	, jt.Job_Title
	, SUM(at.Hours_Worked) [Total_Hours_Worked(2020-01-01 - 2020-01-02)]
	, jt.Hourly_Salary
	, SUM(at.Hours_Worked) * jt.Hourly_Salary as [Salary($)]
FROM 
	Attendance AS at
LEFT JOIN
	Employee AS emp
ON
	at.Employee_ID = emp.Employee_ID
LEFT JOIN
	Job_Title as jt
ON
	emp.Job_Title_ID = jt.Job_Title_ID
WHERE
	at.Date >= '2020-01-01' AND at.Date <= '2020-01-02' -- Start and end date
GROUP BY
	at.Employee_ID
	, jt.Hourly_Salary
	, emp.First_Name
	, emp.Last_Name
	, jt.Job_Title
