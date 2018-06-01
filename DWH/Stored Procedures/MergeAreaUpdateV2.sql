CREATE PROCEDURE [DWH].[MergeAreaUpdateV2] @PackageName VARCHAR (100) = NULL AS

DECLARE @VARIABLE TABLE 
	(
		[Output Area Classification Name]VARCHAR(255),
		[European Electoral Region Name] VARCHAR(255),
		[Primary Care Trust Name]VARCHAR(255),
		[Location]VARCHAR(255),
		[VERSION] INT
	);
	  


MERGE [DWH].[Area] AS TARGET
		USING [SGT].[ST] AS SOURCE
		ON TARGET.[Location] = SOURCE.[Location] 

		WHEN MATCHED AND
		(
			SOURCE.[Output Area Classification Name]!=TARGET.[Output Area Classification Name] 
			OR
			SOURCE.[European Electoral Region Name]!=TARGET.[European Electoral Region Name]
			OR
			SOURCE.[Primary Care Trust Name]!=TARGET.[Primary Care Trust Name]
			OR
			SOURCE.[Location]!=TARGET.[Location]
		)
		THEN 
		UPDATE SET 
			Target.[Version] = 1

		WHEN NOT MATCHED THEN
		INSERT 
		(
			[Output Area Classification Name],
			[European Electoral Region Name],
			[Primary Care Trust Name],
			[Location],
			[VERSION]
		)	
		VALUES 
		(
			SOURCE.[Output Area Classification Name],
			SOURCE.[European Electoral Region Name],
			SOURCE.[Primary Care Trust Name],
			SOURCE.[Location],
			0
		)
OUTPUT   
	SOURCE.[Output Area Classification Name],
	SOURCE.[European Electoral Region Name],
	SOURCE.[Primary Care Trust Name],
	SOURCE.[Location],
	0
	INTO @VARIABLE ;
	    
SELECT *  FROM @VARIABLE ;

INSERT INTO [DWH].area
SELECT *  FROM @VARIABLE

INSERT INTO DWH.[LogTable]
VALUES ('MergeAreaUpdate', GETDATE(), [DWH].[carl]('Merge'), @PackageName)