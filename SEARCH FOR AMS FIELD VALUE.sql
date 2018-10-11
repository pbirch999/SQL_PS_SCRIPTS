USE AMS
GO

DECLARE @Results TABLE (
	ColumnName NVARCHAR(370),
	ColumnValue NVARCHAR(3630)
	)
DECLARE @SearchStr VARCHAR(500)

SET @SearchStr = 'Active'
SET NOCOUNT ON

DECLARE @TableName NVARCHAR(256),
	@ColumnName NVARCHAR(128),
	@SearchStr2 NVARCHAR(110)

SET @TableName = ''
SET @SearchStr2 = QUOTENAME('%' + @SearchStr + '%', '''')

WHILE @TableName IS NOT NULL
BEGIN
	SET @ColumnName = ''
	SET @TableName = (
			SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = 'BASE TABLE'
				AND QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @TableName
				AND OBJECTPROPERTY(OBJECT_ID(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)), 'IsMSShipped') = 0
			)

	WHILE (@TableName IS NOT NULL)
		AND (@ColumnName IS NOT NULL)
	BEGIN
		SET @ColumnName = (
				SELECT MIN(QUOTENAME(COLUMN_NAME))
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_SCHEMA = PARSENAME(@TableName, 2)
					AND TABLE_NAME = PARSENAME(@TableName, 1)
					AND DATA_TYPE IN (
						'char',
						'varchar',
						'nchar',
						'nvarchar'
						)
					AND QUOTENAME(COLUMN_NAME) > @ColumnName
				)

		IF @ColumnName IS NOT NULL
		BEGIN
			INSERT INTO @Results
			EXEC (
					'SELECT ''' + @TableName + '.' + @ColumnName + ''', LEFT(' + @ColumnName + ', 3630) 
                FROM ' + @TableName + ' (NOLOCK) ' + ' WHERE ' + @ColumnName + ' LIKE ' + @SearchStr2
					)
		END
	END
END

SELECT DISTINCT ColumnName,
	ColumnValue
FROM @Results
--WHERE columnValue like 'Active'
ORDER BY ColumnValue
