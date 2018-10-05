
if not exists(select s.schema_id from sys.schemas s where s.name = 'catalog') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'dbo') begin
	exec sp_executesql N'create schema [catalog] authorization [dbo]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'internal') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'dbo') begin
	exec sp_executesql N'create schema [internal] authorization [dbo]'
end
GO

