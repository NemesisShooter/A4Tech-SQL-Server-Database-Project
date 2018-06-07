CREATE PROCEDURE [SGT].[udp_StagingTableCleaning] AS 

WITH cte
     AS (
     SELECT ROW_NUMBER() OVER(PARTITION BY BusinessEntityID, PersonModifiedDate, EmployeeModifiedDate ORDER BY BusinessEntityID DESC) AS RowNum,
            BusinessEntityID,
			PersonModifiedDate, 
			EmployeeModifiedDate
     FROM SGT.view_StagingTable
	 )
DELETE FROM cte
WHERE RowNum >= 2