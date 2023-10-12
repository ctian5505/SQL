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


-- Populate Property Address Data
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


-- Populate Owner Address Data
SELECT 
	OwnerAddress
	, PARSENAME(REPLACE(OwnerAddress, ',', '.'),3) AS Address
	, PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) AS City
	, PARSENAME(REPLACE(OwnerAddress, ',', '.'),1) AS State
FROM RawData

	--- Creating a table where the Owner Split Address will store
	ALTER TABLE RawData
	ADD OwnerSplitAddress NVARCHAR(250)
		--- Pasting the Owner Split Address to the new table
		UPDATE RawData
		SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)
	
	--- Creating a table where the Owner Split City will store
	ALTER TABLE RawData
	ADD OwnerSplitCity NVARCHAR(250)UP
		--- Pasting the Owner Split City to the new table
		UPDATE RawData
		SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

	--- Creating a table where the Owner Split State will store
	ALTER TABLE RawData
	ADD OwnerSplitState NVARCHAR(5)
		--- Pasting the Owner Split State to the new table
		UPDATE RawData
		SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

-- Change Y and N to Yes and No in "Sold as Vacant" field
UPDATE RawData
SET SoldAsVacant = 
	CASE
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END


-- Delete Unused Columns (Uniqie (Unique) but hut the info is the same) 
WITH RowNumCTE AS(
SELECT *, ROW_NUMBER() OVER (PARTITION BY 
ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID
) AS Row_Num
FROM RawData)

DELETE FROM RowNumCTE
WHERE Row_Num > 1

-- Delete Unused Columns
ALTER TABLE RawData
DROP COLUMN PropertyAddress, OwnerAddress







































