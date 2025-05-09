-- Backup the entire database
BACKUP DATABASE national_logistics_and_supply_chain
TO DISK = 'C:\path\to\backup\national_logistics_backup.bak'
WITH FORMAT, INIT, NAME = 'Full Database Backup';

-- Backup specific tables
-- Note: SQL Server does not support backing up individual tables directly.
-- To back up specific tables, you can export them to a file using BCP (Bulk Copy Program) or SELECT INTO.
-- Example using BCP:
-- Export 'product' table
EXEC xp_cmdshell 'bcp "SELECT * FROM national_logistics_and_supply_chain.dbo.product" queryout "C:\path\to\backup\product_table_backup.csv" -c -T -S localhost';

-- Export 'warehouse' table
EXEC xp_cmdshell 'bcp "SELECT * FROM national_logistics_and_supply_chain.dbo.warehouse" queryout "C:\path\to\backup\warehouse_table_backup.csv" -c -T -S localhost';

-- Backup structure only (no data)
-- Generate the schema for the database using SQL Server Management Studio (SSMS) or a script.
-- Example: Generate a script for the database schema
-- In SSMS: Right-click the database -> Tasks -> Generate Scripts -> Select "Schema only".

-- Backup data only (no structure)
-- Export data from all tables using BCP or SELECT INTO.
-- Example using BCP:
-- Export data from the entire database
EXEC xp_cmdshell 'bcp "SELECT * FROM national_logistics_and_supply_chain.dbo.product" queryout "C:\path\to\backup\national_logistics_data_backup.csv" -c -T -S localhost';

