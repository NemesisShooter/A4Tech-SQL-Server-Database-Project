CREATE PROCEDURE [dbo].[DimJobs_UDP] AS

TRUNCATE TABLE DWH.DimJobs

INSERT INTO DWH.DimJobs
(
	JobTitle
)
	SELECT DISTINCT
		SGT.view_StagingTable.JobTitle
	FROM	SGT.view_StagingTable
	ORDER BY SGT.view_StagingTable.JobTitle