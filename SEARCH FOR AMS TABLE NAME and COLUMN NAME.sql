USE AMS
GO

/*
Populates a result set with the values from a table
Patrick Birch
9/26
*/
DECLARE @prefix2 VARCHAR(2) = 'tb',
	@prefix3 VARCHAR(3) = 'stb';
-- SET TABLE NAME
DECLARE @tbName VARCHAR(100),
	@colName VARCHAR(200)

-- add only the name of the table - the script adds the appropriate prefix
SET @tbName = 'casetopic'
-- SET COLUMN NAME
-- Easiest way to limit the results - use "vc" or "dt", or any value, depending on the value to be returned.
SET @colName = 'vc'

--SELECT UPPER(LEFT(@tbName,1))+LOWER(SUBSTRING(@tbName,2,LEN(@tbName)))
BEGIN
	IF left(@tbname, 2) = @prefix2
		GOTO META_ONE
	ELSE
		GOTO ADD_PREFIX;
END

ADD_PREFIX:

IF NOT EXISTS (
		SELECT TABLE_NAME
		FROM information_schema.tables
		WHERE TABLE_NAME = @tbName
		)
BEGIN
	SET @tbName = UPPER(LEFT(@tbName, 1)) + LOWER(SUBSTRING(@tbName, 2, LEN(@tbName)))
	SET @tbName = @prefix3 + @tbName

	SELECT @tbname AS STB_STEP
END
ELSE
BEGIN
	SET @tbName = @prefix2 + SUBSTRING(@tbName, 4, 100)
	SET @tbName = LOWER(LEFT(UPPER(LEFT(@tbName, 3)), 2)) + UPPER(SUBSTRING(@tbName, 3, LEN(1))) + LOWER(SUBSTRING(@tbName, 4, LEN(@tbName)))

	SELECT @tbname AS TB_STEP
END

/*
DECLARE @SQL as varchar(max)
SET @SQL = 'Create or alter View vTABSAMPLE as SELECT TOP 1 * FROM ' + @tbName + ' ORDER BY NEWID()'
EXEC(@SQL)
*/
META_ONE:

/*
DECLARE @SQL as varchar(max)
SET @SQL = 'SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ' + @tbName + ' ORDER BY 1'
EXEC(@SQL)

*/
SELECT UPPER(CASE 
			WHEN Data_TYPE IN (
					'varchar',
					'char'
					)
				THEN 'string' + '(' + CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR(5)) + ')'
			WHEN Data_type IN (
					'time',
					'date',
					'smalldatetime',
					'datetime',
					'datetime2',
					'datetimeoffset'
					)
				THEN 'DATETIME'
			WHEN data_type IN (
					'Int',
					'bigint',
					'smallint',
					'tinyint'
					)
				THEN 'INTEGER' + '(' + CAST(NUMERIC_PRECISION AS VARCHAR(5)) + ',' + CAST(NUMERIC_SCALE AS VARCHAR(5)) + ')'
			WHEN data_type = 'bit'
				THEN 'BOOLEAN'
			ELSE DATA_TYPE + '(' + CAST(NUMERIC_PRECISION AS VARCHAR(5)) + ',' + CAST(NUMERIC_SCALE AS VARCHAR(5)) + ')'
			END) AS DT_SIZE,
	@tbName + '.' + COLUMN_NAME AS FIELDNAME,
	IIF(COLUMN_DEFAULT IS NULL, '', COLUMN_DEFAULT) AS DEFAULT_VALUE,
	IIF(IS_NULLABLE = 'NO', ' ', IS_NULLABLE) AS IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS CC
INNER JOIN INFORMATION_SCHEMA.Tables TT
	ON cc.TABLE_NAME = tt.TABLE_NAME
		AND tt.TABLE_NAME = @tbName
WHERE COLUMN_NAME LIKE '%' + @colName + '%'
ORDER BY 1

IF left(@tbname, 2) = 'tb'
	SELECT 'This is a TB table';
ELSE
	SELECT 'This is a STB table';

--SELECT * FROM vtabsample  ; --a way to see an example of the actual values. 
