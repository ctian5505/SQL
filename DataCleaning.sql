-- Raw Data:  https://foresightbi.com.ng/wp-content/uploads/2020/05/5.-Jumbled-up-Customers-Details.xlsx

-- Create a database to stored the clean data
CREATE DATABASE Clean(
Name NVARCHAR(50),
Address(100),
Age INT,
Gender NVARCHAR(10)
)

-- Insert the created query that clean the data to a new table
INSERT INTO Clean
SELECT 
	SUBSTRING(Header, CHARINDEX('Name', Header)+5,CHARINDEX('Address', Header)-7) AS Name
	,SUBSTRING(Header,CHARINDEX('Address', Header)+8,CHARINDEX('Age', Header)-CHARINDEX('Address', Header)-8) AS Address
	,SUBSTRING(Header,CHARINDEX('Age', Header)+4,CHARINDEX('Gender', Header)-CHARINDEX('Age', Header)-4) AS Age
	,RIGHT(Header,LEN(Header)-CHARINDEX ('Gender', Header)-6) AS Gender
FROM ['Dirty 5$']
