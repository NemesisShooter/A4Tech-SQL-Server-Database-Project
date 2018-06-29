IF $(CreatingAndConfiguringEnvironment) = 1 AND 
	$(CreatingDevFolder) = 1
	BEGIN

	IF EXISTS (
	SELECT  reference_id
		FROM  [SSISDB].[catalog].[environment_references] er
		JOIN [SSISDB].[catalog].[projects] p 
			ON p.project_id = er.project_id
		WHERE  
			er.environment_name = 'Dev'
		AND  
			p.name              = 'A4Tech'
		)
		BEGIN
			PRINT 'PDS: Deleting Dev environment'

			EXEC [SSISDB].[catalog].[delete_environment]
			@folder_name		= N'Dev',
			@environment_name	= N'Dev'

			PRINT 'PDS: Recreating and configuring Dev environment'
		END

			--Creating environment
			EXEC [SSISDB].[catalog].[create_environment]
			@environment_name = N'Dev',   
			@environment_description = N'Development environment',   
			@folder_name = N'Dev'


			--Adding valuses to the environment
			DECLARE @var sql_variant = N'A4Tech'
			EXEC [SSISDB].[catalog].[create_environment_variable] 
			@variable_name=N'ConnectionCatalogName', 
			@sensitive=False, 
			@description=N'', 
			@environment_name=N'Dev', 
			@folder_name=N'Dev', 
			@value=@var, 
			@data_type=N'String'


			DECLARE @var1 sql_variant = N'M-SIMIONIDI'
			EXEC [SSISDB].[catalog].[create_environment_variable] 
			@variable_name=N'ConnectionServerName', 
			@sensitive=False, 
			@description=N'', 
			@environment_name=N'Dev', 
			@folder_name=N'Dev', 
			@value=@var1, 
			@data_type=N'String'


			DECLARE @var2 sql_variant = N''
			EXEC [SSISDB].[catalog].[create_environment_variable] 
			@variable_name=N'FileName', 
			@sensitive=False, 
			@description=N'', 
			@environment_name=N'Dev', 
			@folder_name=N'Dev', 
			@value=@var2, 
			@data_type=N'String'


			DECLARE @var3 sql_variant = N'E:\Zhenia Bi\incload\SOURCE\A4Tech\'
			EXEC [SSISDB].[catalog].[create_environment_variable] 
			@variable_name=N'FilePath', 
			@sensitive=False, 
			@description=N'', 
			@environment_name=N'Dev', 
			@folder_name=N'Dev', 
			@value=@var3, 
			@data_type=N'String'


			--Configuring Environment
			DECLARE @reference SMALLINT = 
			(
			SELECT 
				[reference_id]
				FROM [SSISDB].[catalog].[environment_references] ref
				INNER JOIN [SSISDB].[catalog].[projects] prj 
					ON  ref.[project_id] = prj.[project_id]
				INNER JOIN [SSISDB].[catalog].[folders] fld 
					ON fld.[folder_id] = prj.[folder_id]
				WHERE 
						fld.name = 'Dev' 
					AND
						prj.name  = 'A4Tech' 
					AND
						environment_name   = 'Dev' 
					AND
						reference_type  = 'R'
			)

	IF (
	SELECT 
	@reference AS reference_id
			) IS NOT NULL
		BEGIN

			DECLARE @reference_id BIGINT
			EXEC [SSISDB].[catalog].[delete_environment_reference] 
			@reference_id=@reference
			SELECT @reference_id

		END

			DECLARE @reference_id BIGINT
			EXEC [SSISDB].[catalog].[create_environment_reference] 
			@environment_name=N'Dev', 
			@reference_id=@reference_id OUTPUT, 
			@project_name=N'A4tech', 
			@folder_name=N'Dev', 
			@reference_type=R
			SELECT @reference_id


			EXEC [SSISDB].[catalog].[set_object_parameter_value] 
			@object_type=20, 
			@parameter_name=N'FileName', 
			@object_name=N'A4tech', 
			@folder_name=N'Dev', 
			@project_name=N'A4tech', 
			@value_type=R, 
			@parameter_value=N'FileName'


			EXEC [SSISDB].[catalog].[clear_object_parameter_value] 
			@object_type=20, 
			@object_name=N'A4tech', 
			@parameter_name=N'FilePath', 
			@folder_name=N'Dev', 
			@project_name=N'A4tech'


			EXEC [SSISDB].[catalog].[set_object_parameter_value] 
			@object_type=20, 
			@parameter_name=N'InitialCatalog', 
			@object_name=N'A4tech', 
			@folder_name=N'Dev', 
			@project_name=N'A4tech', 
			@value_type=R, 
			@parameter_value=N'ConnectionCatalogName'


			EXEC [SSISDB].[catalog].[set_object_parameter_value] 
			@object_type=20, 
			@parameter_name=N'ServerName', 
			@object_name=N'A4tech', 
			@folder_name=N'Dev', 
			@project_name=N'A4tech', 
			@value_type=R, 
			@parameter_value=N'ConnectionServerName'

		PRINT 'PDS: Finishing...'
	END
ELSE
	BEGIN
		PRINT 'PDS: Skipping creation and configuration of Dev environment'
	END