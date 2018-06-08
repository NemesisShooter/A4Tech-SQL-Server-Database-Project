




CREATE VIEW [DWH].[vw_employee_job_information] AS

SELECT 
	DWH.DimEmployee.BusinessEntityID AS PersonID,
	FirstName, 
	LastName,
	JobTitle,
	FactMoney AS Salary,
	CASE WHEN DWH.FactJobChange.IdDimDate = MAX(IdDimDate)OVER(PARTITION BY DWH.DimEmployee.BusinessEntityID) THEN 'Present' ELSE 'Past' END AS CurrentJob,
	[Date]
FROM	DWH.FactJobChange
INNER JOIN DWH.DimEmployee
	ON	DWH.DimEmployee.IdDimEmployee = DWH.FactJobChange.IdDimEmployee
INNER JOIN DWH.DimJobs
	ON	DWH.DimJobs.IdDimJobs = DWH.FactJobChange.IdDimJobs
INNER JOIN DWH.DimDate
	ON DWH.DimDate.DateKey = DWH.FactJobChange.IdDimDate
WHERE DWH.DimEmployee.BusinessEntityID IN 
(
SELECT
	BusinessEntityID
FROM	DWH.FactJobChange
INNER JOIN DWH.DimEmployee
	ON	DWH.DimEmployee.IdDimEmployee = DWH.FactJobChange.IdDimEmployee
INNER JOIN DWH.DimJobs
	ON	DWH.DimJobs.IdDimJobs = DWH.FactJobChange.IdDimJobs
GROUP BY DWH.DimEmployee.BusinessEntityID
HAVING COUNT(DWH.FactJobChange.IdDimDate) >= 2
)