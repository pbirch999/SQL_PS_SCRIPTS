USE AMS
GO

/*
Populates a result set with the values from a table
Patrick Birch
9/26
*/
DECLARE @prefix2 varchar(2) = 'tb', @prefix3 varchar(3)='stb'



-- SET TABLE NAME
DECLARE @tbName varchar(100) , @colName varchar(200)
-- add only the name of the table - the script adds the appropriate prefix

SET @tbName = 'imagespec'   

-- SET COLUMN NAME

 -- Easiest way to limit the results - use "vc" or "dt", or any value, depending on the value to be returned.

SET @colName = 'vc'

--SELECT UPPER(LEFT(@tbName,1))+LOWER(SUBSTRING(@tbName,2,LEN(@tbName)))

If NOT EXISTS (SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_NAME = @tbName) 
BEGIN
	SET @tbName = UPPER(LEFT(@tbName,1))+LOWER(SUBSTRING(@tbName,2,LEN(@tbName)))
	SET @tbName = @prefix3 + @tbName

END

If NOT EXISTS (SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_NAME = @tbName) 
BEGIN
	
	SET @tbName = @prefix2 + SUBSTRING(@tbName,4,100)
	SET @tbName =  LOWER( LEFT(UPPER(LEFT(@tbName, 3)),2)) + UPPER(SUBSTRING(@tbName,3,LEN(1))) + LOWER(SUBSTRING(@tbName,4,LEN(@tbName)))

END
BEGIN
	PRINT @tbName + ' does not exist.'
END
/*
DECLARE @SQL as varchar(max)
SET @SQL = 'Create or alter View vTABSAMPLE as SELECT TOP 1 * FROM ' + @tbName + ' ORDER BY NEWID()'
EXEC(@SQL)
*/
SELECT 
	UPPER (
	Case 
	     WHEN Data_TYPE IN ( 'varchar', 'char') THEN 'string' + '(' +  CAST (CHARACTER_MAXIMUM_LENGTH as varchar(5)) +')'
		 WHEN Data_type IN ('time', 'date', 'smalldatetime', 'datetime', 'datetime2', 'datetimeoffset') THEN 'DATETIME'
		 WHEN data_type IN ('Int', 'bigint', 'smallint', 'tinyint') THEN 'INTEGER' + '(' + CAST (NUMERIC_PRECISION as varchar(5)) + ',' + CAST( NUMERIC_SCALE AS varchar(5)) +')'
		 WHEN data_type = 'bit' THEN 'BOOLEAN'
		 ELSE DATA_TYPE + '(' + CAST (NUMERIC_PRECISION as varchar(5)) + ',' + CAST( NUMERIC_SCALE AS varchar(5)) +')'
	END 
	) AS	DT_SIZE,
			@tbName + '.' + COLUMN_NAME as FIELDNAME,
			IIF(COLUMN_DEFAULT IS NULL, '', COLUMN_DEFAULT) as DEFAULT_VALUE,
			IIF(IS_NULLABLE = 'NO', ' ', IS_NULLABLE) as IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS	CC 
	INNER JOIN INFORMATION_SCHEMA.Tables TT 
	ON cc.TABLE_NAME = tt.TABLE_NAME and tt.TABLE_TYPE = 'BASE TABLE' and tt.TABLE_NAME = @tbName
WHERE COLUMN_NAME LIKE '%'+ @colName + '%'
ORDER BY 1

--SELECT * FROM vtabsample  ; --a way to see an example of the actual values. 

