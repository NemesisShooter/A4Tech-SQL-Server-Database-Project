CREATE PROCEDURE [DWH].[MergeAreaUpdate] AS

MERGE [DWH].[Area]
		USING [DWH].[Area_update]
		ON [DWH].[Area].[Location] = [Area_update].[Location] 
		AND 
		[DWH].[Area].[European Electoral Region Name] = [Area_update].[European Electoral Region Name]
		AND 
		[DWH].[Area].[Primary Care Trust Name] = [Area_update].[Primary Care Trust Name]
		
		WHEN MATCHED 
		THEN 
		UPDATE SET 
			[DWH].[Area].[VERSION] = 0

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
		 [DWH].[Area_update].[Output Area Classification Name], 
		 [DWH].[Area_update].[European Electoral Region Name], 
		 [DWH].[Area_update].[Primary Care Trust Name], 
		 [DWH].[Area_update].[Location], 
		 1
		 )
		OUTPUT $action, INSERTED.*, DELETED.*;

INSERT INTO DWH.[LogTable]
VALUES ('MergeAreaUpdate', GETDATE(), [DWH].[carl]('Merge'))