USE AMS
GO

/*
Populates a result set with the values from a table
Patrick Birch
10/11

*/
DECLARE @prefix2 VARCHAR(2) = 'tb',
	@prefix3 VARCHAR(3) = 'stb';
DECLARE @tbName VARCHAR(100),
	@colName VARCHAR(200)

SET @tbName = 'casetopic'
SET @colName = 'vc'

BEGIN
	IF left(@tbname, 2) = @prefix2
		GOTO META_ONE
	ELSE
		GOTO ADD_PREFIX;
END

ADD_PREFIX:

IF left(@tbname, 2) = 'tb'
	SELECT 'This is a TB table' AS TABLE_TYPE;
ELSE
	SELECT 'This is a STB table' AS TABLE_TYPE;

IF NOT EXISTS (
		SELECT TABLE_NAME
		FROM information_schema.tables
		WHERE TABLE_NAME = @tbName
		)
BEGIN
	SET @tbName = UPPER(LEFT(@tbName, 1)) + LOWER(SUBSTRING(@tbName, 2, LEN(@tbName)))
	SET @tbName = @prefix3 + @tbName
END
ELSE
BEGIN
	SET @tbName = @prefix2 + SUBSTRING(@tbName, 4, 100)
	SET @tbName = LOWER(LEFT(UPPER(LEFT(@tbName, 3)), 2)) + UPPER(SUBSTRING(@tbName, 3, LEN(1))) + LOWER(SUBSTRING(@tbName, 4, LEN(@tbName)))

	SELECT @tbname AS TB_STEP
END

META_ONE:

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
