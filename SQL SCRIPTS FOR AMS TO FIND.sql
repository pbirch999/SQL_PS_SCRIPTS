
/* Allows you to find a column name using wildcards
in the database
*/

SELECT t.name AS table_name, c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%ship%' 
ORDER BY table_name;

SELECT * 
FROM INFORMATION_SCHEMA.columns
WHERE table_name = 'tbTag'

USE AMS
GO

/*
Populates a result set with the values from a table
Patrick Birch
9/21
*/

SELECT 
	COLUMN_NAME, 
	UPPER (
	Case 
	     WHEN Data_TYPE IN ( 'varchar', 'char') THEN 'string' + '(' +  CAST (CHARACTER_MAXIMUM_LENGTH as varchar(5)) +')'
		 WHEN Data_type IN ('time', 'date', 'smalldatetime', 'datetime', 'datetime2', 'datetimeoffset') THEN 'DATETIME'
		 WHEN data_type IN ('Int', 'bigint', 'smallint', 'tinyint') THEN 'INTEGER' + '(' + CAST (NUMERIC_PRECISION as varchar(5)) + ',' + CAST( NUMERIC_SCALE AS varchar(5)) +')'
		 WHEN data_type = 'bit' THEN 'BOOLEAN'
		 ELSE DATA_TYPE + '(' + CAST (NUMERIC_PRECISION as varchar(5)) + ',' + CAST( NUMERIC_SCALE AS varchar(5)) +')'
	END 
	) AS  DT_SIZE,
	IIF(COLUMN_DEFAULT IS NULL, '', COLUMN_DEFAULT) as DEFAULT_VALUE,
	IIF(IS_NULLABLE = 'NO', ' ', IS_NULLABLE) as IS_NULLABLE,
	tt.TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS	CC 
	INNER JOIN INFORMATION_SCHEMA.Tables TT 
on cc.TABLE_NAME = tt.TABLE_NAME and tt.TABLE_TYPE = 'BASE TABLE' and tt.TABLE_NAME = 'tbshift'
--WHERE tt.TABLE_NAME = 'tbshift'
--WHERE tt.TABLE_NAME like '%user%'
--ORDER BY tt.TABLE_NAME;

SELECT TOP 25 * FROM tbtracerticket

SELECT * FROM INFORMATION_SCHEMA.columns WHERE table_name = 'tbshift'


SELECT COLUMN_NAME, Data_type, CHARACTER_MAXIMUM_LENGTH, numeric_precision, NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS	
WHERE TABLE_NAME = 'tbtag'