--CREATE VIEW ClassificationToEERN AS

--SELECT [Output Area Classification Name], [European Electoral Region Name] FROM [Area]

CREATE VIEW [DWH].LocationPCtoCNNtoCONtoRN AS
SELECT [Postcode 1], [County Name], [Country Name], [Region Name] FROM Location
WHERE [Region Name] IS NOT NULL