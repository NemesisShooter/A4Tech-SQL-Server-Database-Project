--CREATE VIEW ClassificationToEERN AS
--SELECT [Output Area Classification Name], [European Electoral Region Name] FROM [Area]

--CREATE VIEW LocationPCtoCNNtoCONtoRN AS
--SELECT [Postcode 1], [County Name], [Country Name], [Region Name] FROM Location
--WHERE [Region Name] IS NOT NULL

--ALTER SCHEMA DWH
--TRANSFER [dbo].FData

--CREATE VIEW LocationCountyAndCountry AS
--SELECT CONCAT([County Name],' IN ',[Country Name]) AS CountyAndCountry, [Region Name] FROM DWH.Location
--WHERE [Region Name] IS NOT NULL

--CREATE VIEW CountyFromSTGtoINT AS
--SELECT CAST(RIGHT([Country Code],LEN([Country Code])-1) AS int) AS [Country Code]
--FROM [DWH].[Location]
--WHERE [Region Name] IS NOT NULL

CREATE VIEW [DWH].PopulationCount AS
SELECT AVG([Population]) AS [Population]
FROM [DWH].[Location]
INNER JOIN SGT.ST
	ON	SGT.ST.[Easting] = [DWH].[Location].[Easting]
WHERE [DWH].[Location].[Country Name] = 'England'