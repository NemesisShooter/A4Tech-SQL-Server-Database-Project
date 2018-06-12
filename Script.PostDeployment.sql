/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

PRINT 'Post-Deployment Script Start'

IF EXISTS (SELECT * FROM DWH.DimDate)
	BEGIN
		PRINT 'PDS: Nothing to input'
	END
ELSE
	BEGIN
		:r DateScript.sql
		PRINT 'PDS: Finishing...'
	END