CREATE PROCEDURE [DWH].[CreatingWorldDay1] @PackageName VARCHAR (100) = NULL AS

INSERT INTO DWH.Location
	(
		[Postcode 1], 
		[Easting], 
		[Northing], 
		[County Code], 
		[County Name], 
		[Country Code], 
		[Country Name], 
		[Region Code], 
		[Region Name]
	)
SELECT		DISTINCT 
	[Postcode 1], 
	[Easting], 
	[Northing], 
	[County Code], 
	[County Name], 
	[Country Code], 
	[Country Name],
	[Region Code], 
	[Region Name]
FROM		SGT.ST


INSERT INTO DWH.Area
	(
		[Output Area Classification Name], 
		[European Electoral Region Name],
		[Primary Care Trust Name],
		Location
	)
SELECT		DISTINCT 
	[Output Area Classification Name], 
	[European Electoral Region Name],
	[Primary Care Trust Name],
	[Location]
FROM		SGT.ST


DECLARE @StartDate DATE = '19730101'
DECLARE @CutoffDate DATE = GETDATE();

INSERT DWH.DateIntroduced([date]) 
SELECT d
FROM
(
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM 
  (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    ORDER BY s1.[object_id]
  ) AS x
) AS y;


INSERT INTO DWH.[FData] 
	(
		Location.[LocationID], 
		[AreaID],
		[DateID],
		[Population]
	)
SELECT		 DISTINCT
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
VALUES ('CreatingWorldDay1', GETDATE(), DWH.[carl]('Creation'), @PackageName)