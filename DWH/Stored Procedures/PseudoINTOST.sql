CREATE PROCEDURE [DWH].[PseudoINTOST] @PackageName VARCHAR (100) = NULL AS
INSERT INTO [SGT].[ST] 
SELECT [Postcode 1], 
[Postcode 2],
[Postcode 3],
[Date Introduced],
[User Type],
[Easting],[Northing],
[Positional Quality],[County Code],
[County Name],[Local Authority Code],
[Local Authority Name],[Ward Code],[Ward Name],[Country Code],[Country Name],
[Region Code],[Region Name],[Parliamentary Constituency Code],[Parliamentary Constituency Name],[European Electoral Region Code],[European Electoral Region Name],[Primary Care Trust Code],[Primary Care Trust Name],
[Lower Super Output Area Code],[Lower Super Output Area Name],[Middle Super Output Area Code],[Middle Super Output Area Name],[Output Area Classification Code],[Output Area Classification Name],
[Longitude],[Latitude],[Spatial Accuracy],[Last Uploaded],[Location],[Socrata ID]
FROM DWH.PseudoSTconversion

UPDATE [SGT].[ST]
SET [Date Introduced] = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14650), '1974-01-01')
WHERE [Date Introduced] IS NULL

INSERT INTO DWH.[LogTable]
VALUES ('PseudoINTOST', GETDATE(), [DWH].[carl]('PseudoUpdate'), @PackageName)