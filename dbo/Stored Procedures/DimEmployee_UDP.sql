CREATE PROCEDURE [dbo].[DimEmployee_UDP] AS

INSERT	INTO [DWH].[DimEmployee]
(
	BusinessEntityID,
	Title,
	FirstName,
	LastName,
	StartDate,
	EndDate
)
		SELECT DISTINCT
			SGT.view_StagingTable.BusinessEntityID,
			SGT.view_StagingTable.Title,
			SGT.view_StagingTable.FirstName,
			SGT.view_StagingTable.LastName,
			SGT.view_StagingTable.PersonModifiedDate AS StartDate,
			'2299-01-01' AS EndDate
		FROM	SGT.view_StagingTable
		LEFT JOIN	DWH.DimEmployee 
			ON	SGT.view_StagingTable.BusinessEntityID = DWH.DimEmployee.BusinessEntityID
		WHERE	DWH.DimEmployee.BusinessEntityID IS NULL
		OR 
		DWH.DimEmployee.StartDate < SGT.view_StagingTable.PersonModifiedDate
		AND 
		DWH.DimEmployee.EndDate = '2299-01-01'



UPDATE	[DWH].[DimEmployee]
SET	EndDate = DATEADD(day,-1,SGT.view_StagingTable.PersonModifiedDate)
FROM	SGT.view_StagingTable
LEFT JOIN	DWH.DimEmployee
	ON	SGT.view_StagingTable.BusinessEntityID = DWH.DimEmployee.BusinessEntityID
WHERE	DWH.DimEmployee.StartDate < SGT.view_StagingTable.PersonModifiedDate
		AND	
		DWH.DimEmployee.BusinessEntityID = SGT.view_StagingTable.BusinessEntityID
		AND 
		DWH.DimEmployee.EndDate = '2299-01-01'