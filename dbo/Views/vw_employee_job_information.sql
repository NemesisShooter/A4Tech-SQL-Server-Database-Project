


CREATE VIEW [dbo].[vw_employee_job_information] AS

SELECT 
	DWH.DimEmployee.BusinessEntityID AS PersonID,
	FirstName, 
	LastName,
	JobTitle,
	FactMoney AS Salary,
	CASE WHEN DWH.FactTable.IdDimDate = MAX(IdDimDate)OVER(PARTITION BY DWH.DimEmployee.BusinessEntityID) THEN 'Present' ELSE 'Past' END AS CurrentJob,
	DWH.FactTable.IdDimDate
FROM	DWH.FactTable
INNER JOIN DWH.DimEmployee
	ON	DWH.DimEmployee.IdDimEmployee = DWH.FactTable.IdDimEmployee
INNER JOIN DWH.DimJobs
	ON	DWH.DimJobs.IdDimJobs = DWH.FactTable.IdDimJobs
INNER JOIN DWH.DimDate
	ON DWH.DimDate.DateKey = DWH.FactTable.IdDimDate
WHERE DWH.DimEmployee.BusinessEntityID IN 
(
SELECT
	BusinessEntityID
FROM	DWH.FactTable
INNER JOIN DWH.DimEmployee
	ON	DWH.DimEmployee.IdDimEmployee = DWH.FactTable.IdDimEmployee
INNER JOIN DWH.DimJobs
	ON	DWH.DimJobs.IdDimJobs = DWH.FactTable.IdDimJobs
GROUP BY DWH.DimEmployee.BusinessEntityID
HAVING COUNT(DWH.FactTable.IdDimDate) >= 2
)
