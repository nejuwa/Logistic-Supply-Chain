-- Trigger to log updates to the 'order' table
CREATE TRIGGER after_order_update
ON [dbo].[order]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [dbo].[tracking_log] (log_id, shipment_id, location, status, notes)
    VALUES (
        NEWID(), 
        NULL, 
        'System', 
        'Order Updated', 
        'Order ' + CAST(INSERTED.order_id AS NVARCHAR) + ' was updated.'
    );
END;
GO

-- Trigger to log inserts into the 'shipment' table
CREATE TRIGGER after_shipment_insert
ON [dbo].[shipment]
AFTER INSERT
AS
BEGIN
    INSERT INTO [dbo].[tracking_log] (log_id, shipment_id, location, status, notes)
    SELECT 
        NEWID(), 
        INSERTED.shipment_id, 
        'Warehouse', 
        'Shipment Created', 
        'Shipment ' + CAST(INSERTED.shipment_id AS NVARCHAR) + ' was created.'
    FROM INSERTED;
END;
GO

-- Trigger to handle deletions from the 'customer' table
CREATE TRIGGER before_customer_delete
ON [dbo].[customer]
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO [dbo].[tracking_log] (log_id, shipment_id, location, status, notes)
    SELECT 
        NEWID(), 
        NULL, 
        'System', 
        'Customer Deleted', 
        'Customer ' + CAST(DELETED.customer_id AS NVARCHAR) + ' was deleted.'
    FROM DELETED;

    -- Perform the actual delete operation
    DELETE FROM [dbo].[customer]
    WHERE customer_id IN (SELECT customer_id FROM DELETED);
END;
GO