-- Create a logging table to store operation logs
CREATE TABLE operation_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    user_name NVARCHAR(50),
    operation_type NVARCHAR(10),
    table_name NVARCHAR(50),
    operation_time DATETIME DEFAULT GETDATE(),
    details NVARCHAR(MAX)
);

-- Trigger to log INSERT operations on the product table
CREATE TRIGGER log_product_insert
ON product
AFTER INSERT
AS
BEGIN
    INSERT INTO operation_log (user_name, operation_type, table_name, details)
    SELECT SYSTEM_USER, 'INSERT', 'product', 
           'Inserted product_id: ' + CAST(INSERTED.product_id AS NVARCHAR) + ', name: ' + INSERTED.name
    FROM INSERTED;
END;

-- Trigger to log UPDATE operations on the warehouse_product table
CREATE TRIGGER log_warehouse_product_update
ON warehouse_product
AFTER UPDATE
AS
BEGIN
    INSERT INTO operation_log (user_name, operation_type, table_name, details)
    SELECT SYSTEM_USER, 'UPDATE', 'warehouse_product', 
           'Updated product_id: ' + CAST(INSERTED.product_id AS NVARCHAR) + 
           ', warehouse_id: ' + CAST(INSERTED.warehouse_id AS NVARCHAR) + 
           ', new quantity: ' + CAST(INSERTED.quantity AS NVARCHAR)
    FROM INSERTED;
END;

-- Trigger to log DELETE operations on the shipment table
CREATE TRIGGER log_shipment_delete
ON shipment
AFTER DELETE
AS
BEGIN
    INSERT INTO operation_log (user_name, operation_type, table_name, details)
    SELECT SYSTEM_USER, 'DELETE', 'shipment', 
           'Deleted shipment_id: ' + CAST(DELETED.shipment_id AS NVARCHAR)
    FROM DELETED;
END;

-- Example: View logs
SELECT * FROM operation_log;