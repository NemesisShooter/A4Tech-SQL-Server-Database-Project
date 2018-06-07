CREATE VIEW [DWH].vw_employee_name_information AS

WITH cte_counting AS
(
SELECT
	DWH.DimEmployee.BusinessEntityID,
	COUNT(DWH.DimEmployee.BusinessEntityID) AS OtherLastName
FROM	DWH.DimEmployee
GROUP BY BusinessEntityID
)

SELECT 
	DWH.DimEmployee.BusinessEntityID, 
	FirstName, 
	LastName, 
	CASE WHEN EndDate < '22990101' THEN TRY_CAST(EndDate AS VARCHAR(50)) ELSE 'Relevant Information' END AS InformationRelevance
FROM	DWH.DimEmployee
INNER JOIN cte_counting
	ON	cte_counting.BusinessEntityID = DWH.DimEmployee.BusinessEntityID
WHERE cte_counting.OtherLastName >= 2