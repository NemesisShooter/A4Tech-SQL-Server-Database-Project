CREATE PROCEDURE [DWH].[udp_DimJobs] AS

TRUNCATE TABLE DWH.DimJobs

INSERT INTO DWH.DimJobs
(
	JobTitle
)
	SELECT DISTINCT
		SGT.view_StagingTable.JobTitle
	FROM	SGT.view_StagingTable
	ORDER BY SGT.view_StagingTable.JobTitle