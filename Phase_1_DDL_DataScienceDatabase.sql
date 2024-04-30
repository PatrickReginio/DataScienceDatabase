--////DATABASE DESIGN (DDL)////
--///TASK 1: DATABASE///
--Creating the Amazon database.
CREATE DATABASE DataScienceDatabase;

--------------------------------------------------------------------------------------------------------------------
--//TABLES//
--Creating the DimEmployee table.
CREATE TABLE DimEmployee (
EmployeeID INT,
ExperienceLevel VARCHAR(50),
EmploymentType VARCHAR(50),
WorkSetting VARCHAR(50),
WorkYear INT,
CompanySize VARCHAR(50)
);


--------------------------------------------------------------------------------------------------------------------
--Creating the DimJob table.
CREATE TABLE DimJob (
JobID INT,
JobTitle VARCHAR(50),
JobCategory VARCHAR(50)
);


--------------------------------------------------------------------------------------------------------------------
--Creating the DimTerritory table.
CREATE TABLE DimTerritory (
TerritoryID INT,
EmployeeResidence VARCHAR(50),
CompanyLocation VARCHAR(50)
);


--------------------------------------------------------------------------------------------------------------------
--Creating the FactSalary table.
CREATE TABLE FactSalary (
SalaryID INT,
EmployeeID INT,
JobID INT,
TerritoryID INT,
SalaryCurrency VARCHAR(10),
Salary INT,
Salary_in_USD INT
);


--------------------------------------------------------------------------------------------------------------------
--///SCHEMA///
--Create a SCHEMA.
CREATE SCHEMA SalarySchema;

--Modify the dbo SCHEMA into SalarySchema for FactSalary.
ALTER SCHEMA SalarySchema TRANSFER dbo.FactSalary;


--------------------------------------------------------------------------------------------------------------------
--///TASK 2: SPECIFY KEYS AND CONSTRAINTS///
--//DimEmployee Table//
--Modify column to disallow NULL values.
ALTER TABLE dbo.DimEmployee
ALTER COLUMN EmployeeID INT NOT NULL;

ALTER TABLE dbo.DimEmployee
ALTER COLUMN ExperienceLevel VARCHAR(50) NOT NULL;

ALTER TABLE dbo.DimEmployee
ALTER COLUMN EmploymentType VARCHAR(50) NOT NULL;

ALTER TABLE dbo.DimEmployee
ALTER COLUMN WorkSetting VARCHAR(50) NOT NULL;

ALTER TABLE dbo.DimEmployee
ALTER COLUMN WorkYear INT NOT NULL;

ALTER TABLE dbo.DimEmployee
ALTER COLUMN CompanySize VARCHAR(50) NOT NULL;

--Adding PRIMARY KEY CONSTRAINT.
ALTER TABLE dbo.DimEmployee
ADD CONSTRAINT PK_DimEmployee_EmployeeID PRIMARY KEY (EmployeeID);

--Adding UNIQUE CONSTRAINTS.
ALTER TABLE dbo.DimEmployee
ADD CONSTRAINT UC_EmployeeID UNIQUE (EmployeeID);


--------------------------------------------------------------------------------------------------------------------
--//DimJob Table//
--Modify column to disallow NULL values.
ALTER TABLE dbo.DimJob
ALTER COLUMN JobID INT NOT NULL;

ALTER TABLE dbo.DimJob
ALTER COLUMN JobTitle VARCHAR(50) NOT NULL;

ALTER TABLE dbo.DimJob
ALTER COLUMN JobCategory VARCHAR(50) NOT NULL;

--Adding PRIMARY KEY CONSTRAINT.
ALTER TABLE dbo.DimJob
ADD CONSTRAINT PK_DimJob_JobID PRIMARY KEY (JobID);

--Adding UNIQUE CONSTRAINTS.
ALTER TABLE dbo.DimJob
ADD CONSTRAINT UC_JobID UNIQUE (JobID);

--------------------------------------------------------------------------------------------------------------------
--//DimTerritory Table//
--Modify column to disallow NULL values.
ALTER TABLE dbo.DimTerritory
ALTER COLUMN TerritoryID INT NOT NULL;

ALTER TABLE dbo.DimTerritory
ALTER COLUMN EmployeeResidence VARCHAR(50) NOT NULL;

ALTER TABLE dbo.DimTerritory
ALTER COLUMN CompanyLocation VARCHAR(50) NOT NULL;

--Adding PRIMARY KEY CONSTRAINT.
ALTER TABLE dbo.DimTerritory
ADD CONSTRAINT PK_DimTerritory_TerritoryID PRIMARY KEY (TerritoryID);

--Adding UNIQUE CONSTRAINTS.
ALTER TABLE dbo.DimTerritory
ADD CONSTRAINT UC_TerritoryID UNIQUE (TerritoryID);

--------------------------------------------------------------------------------------------------------------------
--//FactSalary Table//
--Modify column to disallow NULL values.
ALTER TABLE SalarySchema.FactSalary
ALTER COLUMN SalaryID INT NOT NULL;

ALTER TABLE SalarySchema.FactSalary
ALTER COLUMN EmployeeID INT NOT NULL;

ALTER TABLE SalarySchema.FactSalary
ALTER COLUMN JobID INT NOT NULL;

ALTER TABLE SalarySchema.FactSalary
ALTER COLUMN TerritoryID INT NOT NULL;

ALTER TABLE SalarySchema.FactSalary
ALTER COLUMN SalaryCurrency VARCHAR(10) NOT NULL;

ALTER TABLE SalarySchema.FactSalary
ALTER COLUMN Salary INT NOT NULL;

ALTER TABLE SalarySchema.FactSalary
ALTER COLUMN Salary_in_USD INT NOT NULL;

--Adding PRIMARY KEY CONSTRAINT.
ALTER TABLE SalarySchema.FactSalary
ADD CONSTRAINT PK_FactSalary_SalaryID PRIMARY KEY (SalaryID);

--Adding FOREIGN KEY CONSTRAINT.
ALTER TABLE SalarySchema.FactSalary
ADD CONSTRAINT FK_FactSalary_DimJob FOREIGN KEY (JobID)
REFERENCES dbo.DimJob(JobID);

ALTER TABLE SalarySchema.FactSalary
ADD CONSTRAINT FK_FactSalary_DimTerritory FOREIGN KEY (TerritoryID)
REFERENCES dbo.DimTerritory (TerritoryID);

--Adding UNIQUE CONSTRAINTS.
ALTER TABLE SalarySchema.FactSalary
ADD CONSTRAINT UC_SalaryID UNIQUE (SalaryID);