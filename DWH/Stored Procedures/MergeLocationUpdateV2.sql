CREATE PROCEDURE [DWH].[MergeLocationUpdateV2] AS
DECLARE @VARIABLElocation TABLE 
	(
		[Postcode 1]VARCHAR(255),
		[Easting]VARCHAR(255),
		[Northing]VARCHAR(255),
		[County Code]VARCHAR(255),
		[County Name]VARCHAR(255),
		[Country Code]VARCHAR(255),
		[Country Name]VARCHAR(255),
		[Region Code]VARCHAR(255),
		[Region Name]VARCHAR(255),
		[VERSION] INT
	);
	  


MERGE [DWH].[Location] AS TARGET
		USING [SGT].[ST] AS SOURCE
		ON TARGET.[Easting] = SOURCE.[Easting] AND TARGET.[Northing] = SOURCE.[Northing] AND TARGET.[Postcode 1] = SOURCE.[Postcode 1]

		WHEN MATCHED AND
		(
			SOURCE.[Postcode 1]!=TARGET.[Postcode 1] 
			OR
			SOURCE.[Easting]!=TARGET.[Easting]
			OR
			SOURCE.[Northing]!=TARGET.[Northing]
			OR
			SOURCE.[County Code]!=TARGET.[County Code]
			OR
			SOURCE.[County Name]!=TARGET.[County Name]
			OR
			SOURCE.[Country Code]!=TARGET.[Country Code]
			OR
			SOURCE.[Country Name]!=TARGET.[Country Name]
			OR
			SOURCE.[Region Code]!=TARGET.[Region Code]
			OR
			SOURCE.[Region Name]!=TARGET.[Region Name]
		)
		THEN 
		UPDATE SET 
			Target.[VERSION] = 1

		WHEN NOT MATCHED THEN
		INSERT 
		(
			[Postcode 1],
			[Easting],
			[Northing],
			[County Code],
			[County Name],
			[Country Code],
			[Country Name],
			[Region Code],
			[Region Name],
			[VERSION]
		)	
		VALUES 
		(
			SOURCE.[Postcode 1],
			SOURCE.[Easting],
			SOURCE.[Northing],
			SOURCE.[County Code],
			SOURCE.[County Name],
			SOURCE.[Country Code],
			SOURCE.[Country Name],
			SOURCE.[Region Code],
			SOURCE.[Region Name],
			0
		)
OUTPUT   
			SOURCE.[Postcode 1],
			SOURCE.[Easting],
			SOURCE.[Northing],
			SOURCE.[County Code],
			SOURCE.[County Name],
			SOURCE.[Country Code],
			SOURCE.[Country Name],
			SOURCE.[Region Code],
			SOURCE.[Region Name],
			0
	INTO @VARIABLElocation ;
	    
SELECT *  FROM @VARIABLElocation ;

INSERT INTO [DWH].location
SELECT *  FROM @VARIABLElocation

INSERT INTO DWH.[LogTable]
VALUES ('MergeAreaUpdate', GETDATE(), [DWH].[carl]('Merge'))