-- Create a database
CREATE DATABASE DataCleaning

--import the table


-- Standardize Date Format
ALTER TABLE RawData
ALTER COLUMN SaleDate DATE

-- Populate Property Address data


SELECT a.UniqueID, a.ParcelID, a.PropertyAddress,b.UniqueID, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM RawData as a
JOIN RawData as b
ON a.ParcelID = b.ParcelID
WHERE a.UniqueID <> b.UniqueID AND a.PropertyAddress IS NULL
            	-- UPDATING THE OLD COLUMN
            UPDATE a
            SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
            FROM RawData as a
            JOIN RawData as b
            ON a.ParcelID = b.ParcelID
            WHERE a.UniqueID <> b.UniqueID AND a.PropertyAddress IS NULL


-- Populate Owner Address Data
SELECT
	PARSENAME(REPLACE(PropertyAddress, ',','.'),2) AS Address
	,PARSENAME(REPLACE(PropertyAddress, ',','.'),1) AS City
FROM RawData

--- Creating a table where the PropertySplitAddress will store
ALTER TABLE RawData
ADD PropertySplitAddress NVARCHAR(250)

--- Pasting the Property Split Address to the new table
UPDATE RawData
SET PropertySplitAddress = PARSENAME(REPLACE(PropertyAddress, ',','.'),2)

--- Creating a table where the Property Split City will store
ALTER TABLE RawData
ADD PropertySplitCity NVARCHAR(250)

--- Pasting the Property Split City to the new table
UPDATE RawData
SET PropertySplitCity = PARSENAME(REPLACE(PropertyAddress, ',','.'),1)
      
