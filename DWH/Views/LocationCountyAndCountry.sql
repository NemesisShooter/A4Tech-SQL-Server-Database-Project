--CREATE VIEW ClassificationToEERN AS
--SELECT [Output Area Classification Name], [European Electoral Region Name] FROM [Area]

--CREATE VIEW LocationPCtoCNNtoCONtoRN AS
--SELECT [Postcode 1], [County Name], [Country Name], [Region Name] FROM Location
--WHERE [Region Name] IS NOT NULL

--ALTER SCHEMA DWH
--TRANSFER [dbo].FData

CREATE VIEW [DWH].LocationCountyAndCountry AS
SELECT CONCAT([County Name],' IN ',[Country Name]) AS CountyAndCountry, [Region Name] FROM DWH.Location
WHERE [Region Name] IS NOT NULL