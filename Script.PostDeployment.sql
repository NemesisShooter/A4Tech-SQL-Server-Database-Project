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
		PRINT 'PDS: Nothing to input DimDate'
	END
ELSE
	BEGIN
		PRINT 'PDS: Loading DimDate'
		:r DateScript.sql
		PRINT 'PDS: Finishing...'
	END;


IF $(CreatingDevFolder) = 1
	BEGIN
		PRINT 'PDS: Creating Dev folder'
		:r CreatingDevFolder.sql
		PRINT 'PDS: Finishing...'
	END
ELSE
	BEGIN
		PRINT 'PDS: Skipping creation of Dev folder'
	END;


IF $(CreatingAndConfiguringEnvironment) = 1 AND 
	$(CreatingDevFolder) = 1
	BEGIN
		PRINT 'PDS: Creating and configuring Dev environment'
--		:r CreatingAndConfiguringEnvironment.sql
		PRINT 'PDS: Finishing...'
	END
ELSE
	BEGIN
		PRINT 'PDS: Skipping creation and configuration of Dev environment'
	END



IF	$(JobSSISDeployment) = 1 AND 
	(
	$(CreatingAndConfiguringEnvironment) = 1 OR
	(
		SELECT  reference_id
		FROM  SSISDB.[catalog].environment_references er
		JOIN SSISDB.[catalog].projects p ON p.project_id = er.project_id
		WHERE  er.environment_name = 'DEV'
		AND  p.name              = 'A4Tech'
	) IS NOT NULL
	)
	BEGIN
		PRINT 'PDS: Creating and configuring Dev environment'
--		:r JobSSISDeployment.sql
		PRINT 'PDS: Finishing...'
	END
ELSE
	BEGIN
		PRINT 'PDS: Skipping creation and configuration of Dev environment'
	END