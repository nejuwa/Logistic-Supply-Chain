-- Create Logins and Users
CREATE LOGIN warehouse_manager WITH PASSWORD = 'password123';
CREATE USER warehouse_manager FOR LOGIN warehouse_manager;

CREATE LOGIN inventory_clerk WITH PASSWORD = 'password123';
CREATE USER inventory_clerk FOR LOGIN inventory_clerk;

CREATE LOGIN logistics_manager WITH PASSWORD = 'password123';
CREATE USER logistics_manager FOR LOGIN logistics_manager;

CREATE LOGIN auditor WITH PASSWORD = 'password123';
CREATE USER auditor FOR LOGIN auditor;

-- Grant Permissions
-- Grant permissions to the warehouse manager
GRANT SELECT, INSERT, UPDATE, DELETE ON [national_logistics_and_supply_chain].[warehouse] TO warehouse_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON [national_logistics_and_supply_chain].[warehouse_product] TO warehouse_manager;

-- Grant permissions to the inventory clerk
GRANT SELECT, INSERT, UPDATE ON [national_logistics_and_supply_chain].[product] TO inventory_clerk;
GRANT SELECT, INSERT, UPDATE ON [national_logistics_and_supply_chain].[warehouse_product] TO inventory_clerk;

-- Grant permissions to the logistics manager
GRANT SELECT, INSERT, UPDATE, DELETE ON [national_logistics_and_supply_chain].[shipment] TO logistics_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON [national_logistics_and_supply_chain].[route] TO logistics_manager;

-- Grant read-only permissions to the auditor
GRANT SELECT ON [national_logistics_and_supply_chain].* TO auditor;

-- Revoke Permissions (Example)
-- Revoke DELETE permission from the inventory clerk
DENY DELETE ON [national_logistics_and_supply_chain].[product] TO inventory_clerk;

-- Database Audit Implementation
-- Create an audit table to log changes
CREATE TABLE audit_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    user_name NVARCHAR(50),
    operation_type NVARCHAR(10),
    table_name NVARCHAR(50),
    operation_time DATETIME DEFAULT GETDATE(),
    details NVARCHAR(MAX)
);

-- Create a trigger to log INSERT operations on the product table
CREATE TRIGGER after_product_insert
ON product
AFTER INSERT
AS
BEGIN
    INSERT INTO audit_log (user_name, operation_type, table_name, details)
    SELECT SYSTEM_USER, 'INSERT', 'product', 
           'Inserted product_id: ' + CAST(INSERTED.product_id AS NVARCHAR) + ', name: ' + INSERTED.name
    FROM INSERTED;
END;

-- Create a trigger to log UPDATE operations on the warehouse_product table
CREATE TRIGGER after_warehouse_product_update
ON warehouse_product
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit_log (user_name, operation_type, table_name, details)
    SELECT SYSTEM_USER, 'UPDATE', 'warehouse_product', 
           'Updated product_id: ' + CAST(INSERTED.product_id AS NVARCHAR) + 
           ', warehouse_id: ' + CAST(INSERTED.warehouse_id AS NVARCHAR) + 
           ', new quantity: ' + CAST(INSERTED.quantity AS NVARCHAR)
    FROM INSERTED;
END;

-- Create a trigger to log DELETE operations on the shipment table
CREATE TRIGGER after_shipment_delete
ON shipment
AFTER DELETE
AS
BEGIN
    INSERT INTO audit_log (user_name, operation_type, table_name, details)
    SELECT SYSTEM_USER, 'DELETE', 'shipment', 
           'Deleted shipment_id: ' + CAST(DELETED.shipment_id AS NVARCHAR)
    FROM DELETED;
END;

-- Example: View audit logs
SELECT * FROM audit_log;