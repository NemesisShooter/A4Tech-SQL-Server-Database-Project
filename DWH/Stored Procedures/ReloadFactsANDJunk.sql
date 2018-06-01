CREATE PROCEDURE [DWH].[ReloadFactsANDJunk] @PackageName VARCHAR (100) = NULL AS

INSERT INTO DWH.[FData] 
	(
		Location.[LocationID], 
		[AreaID],
		[DateID],
		[Population]
	)
SELECT	
	DISTINCT
	[LocationID], 
	[AreaID],
	[DateID],
	[Socrata ID]

FROM	SGT.[ST]
	INNER JOIN DWH.[Location]
	ON [Location].[Easting] = [ST].[Easting] AND [Location].[Northing] = [ST].[Northing] AND [Location].[Postcode 1] = [ST].[Postcode 1]
	INNER JOIN DWH.[Area]
	ON [Area].[Location] = [ST].Location
	INNER JOIN DWH.[DateIntroduced]
	ON [DateIntroduced].[date] = [ST].[Date Introduced]


INSERT INTO DWH.[JunctionTable] 
	(
		[AreaID], 
		[LocationID]
	)
SELECT	
	[AreaID], 
	[LocationID]

FROM	DWH.[Location]
	INNER JOIN SGT.ST
	ON [Location].[Easting] = [ST].[Easting] AND [Location].[Northing] = [ST].[Northing] AND [Location].[Postcode 1] = [ST].[Postcode 1]
	INNER JOIN DWH.[Area]
	ON [Area].[Location] = [ST].Location

INSERT INTO DWH.[LogTable]
VALUES ('Reload', GETDATE(), DWH.[carl]('Creation'), @PackageName)