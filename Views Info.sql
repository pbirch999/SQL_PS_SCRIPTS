

DECLARE @FULLVIEW varchar(100)
SET @FULLVIEW = '[dbo].[vGetVehicleHistoryView]'



DECLARE @VIEW varchar(500)
SET @VIEW = 'vGetVehicleHistoryView'


SELECT VIEW_SCHEMA, VIEW_NAME, TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE VIEW_NAME = @VIEW;

SELECT VIEW_NAME, TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.VIEW_COLUMN_USAGE
WHERE VIEW_NAME = @VIEW;

Select  @FULLVIEW

SELECT @FULLVIEW + ' Columns' as 'label'


SELECT CONCAT(sp.type_desc collate SQL_Latin1_General_CP1_CI_AS, ' ', sp.name collate SQL_Latin1_General_CP1_CI_AS ) as 'Found In'
  from sys.objects o inner join sys.sql_expression_dependencies  sd on o.object_id = sd.referenced_id
                inner join sys.objects sp on sd.referencing_id = sp.object_id
                    and sp.type in ('P','FN')
  where o.name = @VIEW
  ORDER BY sp.name


