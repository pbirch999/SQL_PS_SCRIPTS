/*



[dbo].[zbtVeteranStatus]








*/
USE AMS
GO

DECLARE @tbName varchar(500)
Set @tbName = 'zbtVeteranStatus'



SELECT objtype, objname, name, value  
FROM fn_listextendedproperty (NULL, 'schema', 'dbo', 'table', @tbName , NULL, NULL);  

SELECT TABLE_NAME + ' Definitions' as TABLE_CAPTION
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = @tbName

 SELECT COUNT(COLUMN_NAME) + 1 as Number_of_columns
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_CATALOG = 'AMS' AND TABLE_SCHEMA = 'dbo'
AND TABLE_NAME = @tbName  


SELECT objtype, objname, value as Descriptions
FROM fn_listextendedproperty (NULL, 'schema', 'dbo', 'table', @tbName, 'column', default);

SELECT CONCAT(sp.type_desc collate SQL_Latin1_General_CP1_CI_AS, ' ', sp.name collate SQL_Latin1_General_CP1_CI_AS ) as 'Found In'
  from sys.objects o inner join sys.sql_expression_dependencies  sd on o.object_id = sd.referenced_id
                inner join sys.objects sp on sd.referencing_id = sp.object_id
                    and sp.type in ('P','FN')
  where o.name = @VIEW
  ORDER BY sp.name



