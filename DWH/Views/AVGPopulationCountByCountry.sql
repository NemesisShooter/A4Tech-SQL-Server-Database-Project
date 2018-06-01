CREATE VIEW [DWH].AVGPopulationCountByCountry AS
SELECT DISTINCT AVG(ST.[Population]) OVER(PARTITION BY [Location].[Country Name]) AS [PopulationAVG], [LocationID]
FROM [DWH].[Location]
INNER JOIN SGT.ST
	ON	SGT.ST.[Easting] = [DWH].[Location].[Easting]