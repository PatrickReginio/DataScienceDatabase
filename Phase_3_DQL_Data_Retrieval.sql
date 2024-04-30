--////DATA RETRIEVAL (DQL)////
--//Basic Queries//
--Retrieves all columns from the DimEmployee table.
SELECT * 
FROM DimEmployee;


--------------------------------------------------------------------------------------------------------------------
--Retrieves all columns from the DimJob table.
SELECT * 
FROM DimJob;


--------------------------------------------------------------------------------------------------------------------
--Retrieves all columns from the DimTerritory table.
SELECT * 
FROM DimTerritory;


--------------------------------------------------------------------------------------------------------------------
--Retrieves all columns from the FactSalary table.
SELECT * 
FROM SalarySchema.FactSalary;


--------------------------------------------------------------------------------------------------------------------
--Retrieve all records from the DimEmployee table where the employees are classified as 'Executive' based on their experience level.
SELECT *
FROM DimEmployee
WHERE ExperienceLevel = 'Executive';


--------------------------------------------------------------------------------------------------------------------
--Calculate the number of employees labeled as Executive in the DimEmployee table.
SELECT COUNT(*) as 'ExecutiveCount'
FROM DimEmployee
WHERE ExperienceLevel = 'Executive';


--------------------------------------------------------------------------------------------------------------------
--Retrieve all data from the DimEmployee table where the experience level is Mid-Level and the work setting is In-person.
SELECT *
FROM DimEmployee
WHERE ExperienceLevel = 'Mid-Level'
  AND WorkSetting = 'In-person'


--------------------------------------------------------------------------------------------------------------------
--Retrieve all data from the DimEmployee table where the experience level is Mid-Level or the work setting is In-person.
SELECT *
FROM DimEmployee
WHERE ExperienceLevel = 'Mid-Level'
   OR WorkSetting = 'In-person'


--------------------------------------------------------------------------------------------------------------------
--Retrieve a list of unique job titles from the DimJob table.
SELECT DISTINCT JobTitle
FROM DimJob;


--------------------------------------------------------------------------------------------------------------------
--Calculate the number of unique job titles in the DimJob table.
SELECT DISTINCT COUNT(JobTitle) as 'JobTitleCount'
FROM DimJob;


--------------------------------------------------------------------------------------------------------------------
--Retrieve a list of unique job categories from the DimJob table.
SELECT DISTINCT JobCategory
FROM DimJob;


--------------------------------------------------------------------------------------------------------------------
--Retrieve the number of employees in each company size category for each work year in order.
SELECT WorkYear, 
       CompanySize, 
	   COUNT(*) AS EmployeeCount
FROM DimEmployee 
GROUP BY WorkYear, CompanySize
ORDER BY WorkYear,CompanySize DESC;


--------------------------------------------------------------------------------------------------------------------
--Calculate the total salary from the FactSalary table.
SELECT SUM(Salary_in_USD) as 'TotalSalary'
FROM SalarySchema.FactSalary;


--------------------------------------------------------------------------------------------------------------------
--Calculate the average salary from the FactSalary table.
SELECT AVG(Salary_in_USD) as 'AvgSalary'
FROM SalarySchema.FactSalary;


--------------------------------------------------------------------------------------------------------------------
--Calculate the highest salary from the FactSalary table.
SELECT MAX(Salary_in_USD) as 'HighestSalary'
FROM SalarySchema.FactSalary;


--------------------------------------------------------------------------------------------------------------------
--Calculate the lowest salary from the FactSalary table.
SELECT MIN(Salary_in_USD) as 'LowestSalary'
FROM SalarySchema.FactSalary;


--------------------------------------------------------------------------------------------------------------------
--Retrieve the territories where the total salary exceeds $1,000,000 in order.
SELECT dt.EmployeeResidence,
       SUM(fs.Salary_in_USD) as 'TotalSalary'
FROM SalarySchema.FactSalary as fs
JOIN DimTerritory as dt
  ON fs.TerritoryID = dt.TerritoryID
GROUP BY dt.EmployeeResidence
HAVING SUM(fs.Salary_in_USD) > 1000000
ORDER BY 'TotalSalary' DESC;


--------------------------------------------------------------------------------------------------------------------
--Retrieving job categories with at least one employee earning more than $100,000.
SELECT dj.JobCategory
FROM SalarySchema.FactSalary as fs
JOIN DimJob as dj
  ON fs.JobID = dj.JobID
WHERE fs.Salary_in_USD > 100000
GROUP BY dj.JobCategory;


--------------------------------------------------------------------------------------------------------------------
--Retrieve the maximum salary for each employment type in order o salary.
SELECT de.EmploymentType, 
       MAX(fs.Salary) AS 'MaxSalary'
FROM SalarySchema.FactSalary as fs
JOIN DimEmployee as de 
  ON fs.EmployeeID = de.EmployeeID
GROUP BY de.EmploymentType
ORDER BY 'MaxSalary' DESC;


--------------------------------------------------------------------------------------------------------------------
--Retrieve the average salary for each experience level within each job category in order.
SELECT de.ExperienceLevel, 
       dj.JobCategory, 
	   AVG(fs.Salary) AS 'AvgSalary'
FROM SalarySchema.FactSalary as fs
JOIN DimEmployee as de 
  ON fs.EmployeeID = de.EmployeeID
JOIN DimJob as dj 
  ON fs.JobID = dj.JobID
GROUP BY de.ExperienceLevel, dj.JobCategory
ORDER BY 'AvgSalary' DESC;


--------------------------------------------------------------------------------------------------------------------
--Retrieve the top 10 highest-paying employee records, including their details.
SELECT TOP 10 de.EmployeeID,
              de.ExperienceLevel,
			  de.EmploymentType,
			  de.WorkSetting,
			  fs.Salary_in_USD
FROM SalarySchema.FactSalary as fs
JOIN DimEmployee as de
  ON fs.EmployeeID = de.EmployeeID
ORDER BY fs.Salary_in_USD DESC


--------------------------------------------------------------------------------------------------------------------
--Retrieve the total salary for each experience level of employees in order of salary.
SELECT de.ExperienceLevel,
       SUM(fs.Salary_in_USD) as 'TotalSalary'
FROM SalarySchema.FactSalary as fs
JOIN DimEmployee as de
  ON fs.EmployeeID = de.EmployeeID
GROUP BY de.ExperienceLevel
ORDER BY 'TotalSalary' DESC;


--------------------------------------------------------------------------------------------------------------------
--//ADVANCED Queries//
--Retrieve employees with salaries above the average salary for their job category.
--/Using SUBQUERIES/
SELECT de.EmployeeID, 
       de.ExperienceLevel, 
	   dj.JobCategory, 
	   fs.Salary
FROM SalarySchema.FactSalary as fs
JOIN DimEmployee as de 
  ON fs.EmployeeID = de.EmployeeID
JOIN DimJob as dj 
  ON fs.JobID = dj.JobID
WHERE fs.Salary > (SELECT AVG(s.Salary_in_USD) as 'AvgSalary'
                  FROM SalarySchema.FactSalary as s
                  WHERE s.JobID = fs.JobID
                  )
;


--------------------------------------------------------------------------------------------------------------------
--Retrieve employees with salaries above the average salary for their job category.
--/Using CTE/
WITH AvgSalaryCTE as (
	SELECT s.JobID,
	       AVG(Salary_in_USD) as 'AvgSalary'
	FROM SalarySchema.FactSalary as s
	GROUP BY s.JobID
)
SELECT de.EmployeeID, 
       de.ExperienceLevel, 
	   dj.JobCategory, 
	   fs.Salary
FROM SalarySchema.FactSalary as fs
JOIN DimEmployee as de 
  ON fs.EmployeeID = de.EmployeeID
JOIN DimJob as dj 
  ON fs.JobID = dj.JobID
JOIN AvgSalaryCTE as cte
  ON fs.JobID = cte.JobID
WHERE fs.Salary > cte.AvgSalary;


--------------------------------------------------------------------------------------------------------------------
--Rank employees by their salaries within each job category.
SELECT fs.EmployeeID, 
       fs.Salary_in_USD, 
	   dj.JobCategory,
       RANK() OVER (PARTITION BY dj.JobID ORDER BY fs.Salary_in_USD DESC) AS SalaryRank
FROM SalarySchema.FactSalary as fs
JOIN DimJob as dj
  ON fs.JobID = dj.JobID
ORDER BY dj.JobCategory, SalaryRank
;