--////DATA POPULATION (DML)////
--Populate DimEmployee table.
USE DataScienceDatabase;
BULK INSERT dbo.DimEmployee
FROM 'C:\Favorites\Desktop\Projects\SQL Projects\Data Science Jobs and Salaries Database\CSV Data\DimEmployee.csv'
WITH (FORMAT = 'CSV',
      FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '0x0a');

SELECT * FROM dbo.DimEmployee


--------------------------------------------------------------------------------------------------------------------
--Populate DimJob table.
USE DataScienceDatabase;
BULK INSERT dbo.DimJob
FROM 'C:\Favorites\Desktop\Projects\SQL Projects\Data Science Jobs and Salaries Database\CSV Data\DimJob.csv'
WITH (FORMAT = 'CSV',
      FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '0x0a');

SELECT * FROM dbo.DimJob


--------------------------------------------------------------------------------------------------------------------
--Populate DimTerritory table.
USE DataScienceDatabase;
BULK INSERT DimTerritory
FROM 'C:\Favorites\Desktop\Projects\SQL Projects\Data Science Jobs and Salaries Database\CSV Data\DimTerritory.csv'
WITH (FORMAT = 'CSV',
      FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '0x0a');

SELECT * FROM dbo.DimTerritory


--------------------------------------------------------------------------------------------------------------------
--Populate FactSalary table.
USE DataScienceDatabase;
BULK INSERT SalarySchema.FactSalary
FROM 'C:\Favorites\Desktop\Projects\SQL Projects\Data Science Jobs and Salaries Database\CSV Data\FactSalary.csv'
WITH (FORMAT = 'CSV',
      FIRSTROW = 2,
	  FIELDTERMINATOR = ',',
	  ROWTERMINATOR = '0x0a');

SELECT * FROM SalarySchema.FactSalary