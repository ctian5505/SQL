-- Downloaded data from kaggle
  -- https://www.kaggle.com/datasets/ruchi798/data-science-job-salaries

-- Create a database
CREATE DATABASE Data_Science_Job_Salaries;

-- NEXT Import the data

-- Use the database
USE Data_Science_Job_Salaries

-- Rename the imported table
EXEC sp_rename 'ds_salaries$','ds_salaries'

-- Query all the informaation inside the [ds_salaries]
SELECT *
FROM ds_salaries

