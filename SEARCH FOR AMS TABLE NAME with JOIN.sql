use ams
go

SELECT tt.TABLE_NAME, cc.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLES tt INNER JOIN INFORMATION_SCHEMA.COLUMNS cc
	ON tt.TABLE_NAME = cc.TABLE_NAME
WHERE tt.table_Name like '%Role%'
--and  left(cc.column_name, 2) = 'vc'
ORDER BY tt.table_name

--SELECT * FROM tbCustName