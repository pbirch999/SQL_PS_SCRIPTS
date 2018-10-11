USE AMS
GO

DECLARE @col AS VARCHAR(25)

SET @col = 'fee'

SELECT t.name AS table_name,
	c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c
	ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%' + @col + '%'
	AND t.name NOT LIKE ('%NCTA%')
	AND left(t.name, 1) = 's'
ORDER BY table_name;

SELECT t.name AS table_name,
	c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c
	ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%' + @col + '%'
	AND t.name NOT LIKE ('%NCTA%')
	AND left(t.name, 1) = 't'
ORDER BY table_name;

