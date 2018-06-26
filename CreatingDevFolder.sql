DECLARE @folder_id bigint
EXEC [SSISDB].[catalog].[create_folder]
    @folder_name = N'Dev',   
	@folder_id = @folder_id OUTPUT
SELECT
    @folder_id
EXEC [SSISDB].[catalog].[set_folder_description]
    @folder_name = N'Dev',   
	@folder_description = N'Development'