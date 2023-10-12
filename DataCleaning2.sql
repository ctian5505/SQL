-- Create a database
CREATE DATABASE DataCleaning

--import the table


-- Standardize Date Format
  -- Create a column where to store the edited salesdate
  ALTER TABLE Dirty_Data
  ADD SalesDateEdited DATE

  -- Insert the edited date
  UPDATE Dirty_Data
  SET SalesDateEdited = CONVERT(DATE, SaleDate)
