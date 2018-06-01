CREATE PROCEDURE [DWH].[UpdateFTable] @PackageName VARCHAR (100) = NULL AS 

UPDATE [DWH].[FData] 
SET 
	[FData].[LocationID] = Location.[LocationID], 
	[FData].[AreaID] = Area.[AreaID], 
	[FData].DateID = DateIntroduced.DateID, 
	[FData].[Population] = [ST].[Socrata ID]
FROM	SGT.[ST]
	INNER JOIN DWH.Location
	ON Location.[Easting] = [ST].[Easting] 
	AND 
	[Location].[Northing] = [ST].[Northing] 
	AND 
	[Location].[Postcode 1] = [ST].[Postcode 1]
	INNER JOIN [DWH].[Area]
	ON [Area].[Location] = [ST].Location
	INNER JOIN [DWH].[DateIntroduced]
	ON [DateIntroduced].[date] = [ST].[Date Introduced]

INSERT INTO [DWH].[LogTable]
VALUES ('UpdateFTable', GETDATE(), [DWH].[carl]('Update'), @PackageName)