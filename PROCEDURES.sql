SELECT 
OBJECT_NAME(referencing_id) AS referencing_entity_name,
referenced_schema_name,
    referenced_entity_name as 'Uses:'  
FROM sys.sql_expression_dependencies AS sed  
INNER JOIN sys.objects AS o ON sed.referencing_id = o.object_id  
--WHERE referencing_id = OBJECT_ID(@PROC); 
ORDER BY OBJECT_NAME(referencing_id) 

SELECT 
CONCAT(ISR.ROUTINE_SCHEMA ,'.',ISR.ROUTINE_NAME) as PROCEDURE_NAME,
PARAMETER_NAME,
ISP.DATA_TYPE, 
ISP.ORDINAL_POSITION
FROM 
	INFORMATION_SCHEMA.ROUTINES ISR LEFT OUTER JOIN 
	INFORMATION_SCHEMA.PARAMETERS ISP 
		ON ISR.ROUTINE_NAME = ISP.SPECIFIC_NAME
		--INNER JOIN sys.objects so ON so.name = ISP.SPECIFIC_NAME
WHERE ISR.ROUTINE_TYPE = 'PROCEDURE' and ISR.ROUTINE_NAME NOT LIKE 'sp_%'