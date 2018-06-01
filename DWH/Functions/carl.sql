  CREATE FUNCTION [DWH].[carl] (@bigcarl VARCHAR(255))
RETURNS INT

BEGIN
RETURN
  (
SELECT 
	value 
FROM		[DWH].[ParameterTable]
WHERE	[P1]=@bigcarl
  )
  END 