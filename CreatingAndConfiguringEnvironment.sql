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
GO

DECLARE @var sql_variant = N'M-SIMIONIDI'
EXEC [SSISDB].[catalog].[create_environment_variable] 
@variable_name=N'ConnectionServerName', 
@sensitive=False, 
@description=N'', 
@environment_name=N'Dev', 
@folder_name=N'Dev', 
@value=@var, 
@data_type=N'String'
GO

DECLARE @var sql_variant = N''
EXEC [SSISDB].[catalog].[create_environment_variable] 
@variable_name=N'FileName', 
@sensitive=False, 
@description=N'', 
@environment_name=N'Dev', 
@folder_name=N'Dev', 
@value=@var, 
@data_type=N'String'
GO

DECLARE @var sql_variant = N'E:\Zhenia Bi\incload\SOURCE\A4Tech\'
EXEC [SSISDB].[catalog].[create_environment_variable] 
@variable_name=N'FilePath', 
@sensitive=False, 
@description=N'', 
@environment_name=N'Dev', 
@folder_name=N'Dev', 
@value=@var, 
@data_type=N'String'
GO

--Configuring Environment
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
GO

EXEC [SSISDB].[catalog].[clear_object_parameter_value] 
@object_type=20, 
@object_name=N'A4tech', 
@parameter_name=N'FilePath', 
@folder_name=N'Dev', 
@project_name=N'A4tech'
GO

EXEC [SSISDB].[catalog].[set_object_parameter_value] 
@object_type=20, 
@parameter_name=N'InitialCatalog', 
@object_name=N'A4tech', 
@folder_name=N'Dev', 
@project_name=N'A4tech', 
@value_type=R, 
@parameter_value=N'ConnectionCatalogName'
GO

EXEC [SSISDB].[catalog].[set_object_parameter_value] 
@object_type=20, 
@parameter_name=N'ServerName', 
@object_name=N'A4tech', 
@folder_name=N'Dev', 
@project_name=N'A4tech', 
@value_type=R, 
@parameter_value=N'ConnectionServerName'
GO