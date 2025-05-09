-- Restore the entire database from a backup
-- Use the following command to restore the database from a full backup file
RESTORE DATABASE [national_logistics_and_supply_chain]
FROM DISK = 'C:\path\to\backup\national_logistics_backup.bak'
WITH FILE = 1, 
MOVE 'national_logistics_and_supply_chain_Data' TO 'C:\path\to\data\national_logistics_and_supply_chain.mdf',
MOVE 'national_logistics_and_supply_chain_Log' TO 'C:\path\to\log\national_logistics_and_supply_chain.ldf',
NOUNLOAD, STATS = 10;

-- Restore specific tables from a backup
-- Note: SQL Server does not support restoring individual tables directly from a backup.
-- You need to restore the entire database to a temporary database and then copy the specific tables.
-- Example: Restore the database to a temporary database
RESTORE DATABASE [temp_national_logistics]
FROM DISK = 'C:\path\to\backup\product_warehouse_backup.bak'
WITH FILE = 1, 
MOVE 'temp_national_logistics_Data' TO 'C:\path\to\data\temp_national_logistics.mdf',
MOVE 'temp_national_logistics_Log' TO 'C:\path\to\log\temp_national_logistics.ldf',
NOUNLOAD, STATS = 10;

-- After restoring to a temporary database, copy the specific tables to the main database
-- Example: Copy the 'product' table
INSERT INTO [national_logistics_and_supply_chain].[dbo].[product]
SELECT * FROM [temp_national_logistics].[dbo].[product];

-- Restore database structure only (no data)
-- Use the following command to generate the schema script
-- Open SQL Server Management Studio (SSMS), right-click the database, and select "Tasks > Generate Scripts".
-- Save the generated script and execute it to restore the schema.

-- Restore database data only
-- Example: Restore only the data of the database
mysql -u root -p national_logistics_and_supply_chain < /path/to/backup/national_logistics_data_backup.sql;

-- Example: Recover a specific table from a backup
-- If you need to recover a specific table, extract it from the backup file
-- Use the following command to extract the table from the backup
mysqldump -u root -p national_logistics_and_supply_chain product > /path/to/backup/product_table_backup.sql;

-- Restore the extracted table
mysql -u root -p national_logistics_and_supply_chain < /path/to/backup/product_table_backup.sql;