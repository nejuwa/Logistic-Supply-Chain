-- Inventory Report: Shows products and their quantities in each warehouse
CREATE VIEW inventory_report AS
SELECT 
    w.warehouse_id,
    w.name AS warehouse_name,
    p.product_id,
    p.name AS product_name,
    p.description AS product_description,
    p.category,
    p.storage_type,
    wp.quantity
FROM 
    warehouse_product wp
JOIN 
    warehouse w ON wp.warehouse_id = w.warehouse_id
JOIN 
    product p ON wp.product_id = p.product_id;

-- Products Report: Shows product details along with their suppliers
CREATE VIEW products_report AS
SELECT 
    p.product_id,
    p.name AS product_name,
    p.description AS product_description,
    p.category,
    p.weight,
    p.storage_type,
    p.price,
    s.supplier_id,
    s.name AS supplier_name,
    s.contact_number AS supplier_contact,
    s.email AS supplier_email
FROM 
    product p
LEFT JOIN 
    supplier_product sp ON p.product_id = sp.product_id
LEFT JOIN 
    supplier s ON sp.supplier_id = s.supplier_id;

-- Suppliers Report: Shows suppliers and the products they supply
CREATE VIEW suppliers_report AS
SELECT 
    s.supplier_id,
    s.name AS supplier_name,
    s.address AS supplier_address,
    s.contact_number AS supplier_contact,
    s.email AS supplier_email,
    s.contract_terms,
    s.reliability_score,
    p.product_id,
    p.name AS product_name,
    p.category AS product_category
FROM 
    supplier s
LEFT JOIN 
    supplier_product sp ON s.supplier_id = sp.supplier_id
LEFT JOIN 
    product p ON sp.product_id = p.product_id;

-- Products and Respective Warehouses: Shows which products are stored in which warehouses
CREATE VIEW products_warehouses AS
SELECT 
    p.product_id,
    p.name AS product_name,
    w.warehouse_id,
    w.name AS warehouse_name,
    wp.quantity
FROM 
    product p
JOIN 
    warehouse_product wp ON p.product_id = wp.product_id
JOIN 
    warehouse w ON wp.warehouse_id = w.warehouse_id;

-- Cargos Report: Shows shipments and their statuses
CREATE VIEW cargos_report AS
SELECT 
    s.shipment_id,
    s.status AS shipment_status,
    s.estimated_arrival,
    s.actual_arrival,
    s.total_weight,
    s.total_cost,
    tv.vehicle_id,
    tv.type AS vehicle_type,
    tv.capacity AS vehicle_capacity,
    r.route_id,
    r.distance AS route_distance,
    r.estimated_time AS route_estimated_time,
    r.transportation_cost AS route_cost
FROM 
    shipment s
LEFT JOIN 
    transportation_vehicle tv ON s.vehicle_id = tv.vehicle_id
LEFT JOIN 
    route r ON s.route_id = r.route_id;

-- Imports Report: Shows shipments with customs clearance details
CREATE VIEW imports_report AS
SELECT 
    cc.clearance_id,
    cc.tax_duty,
    cc.clearance_date,
    cc.status AS clearance_status,
    s.shipment_id,
    s.status AS shipment_status,
    s.estimated_arrival,
    s.actual_arrival,
    s.total_cost AS shipment_cost
FROM 
    customs_clearance cc
JOIN 
    shipment s ON cc.shipment_id = s.shipment_id;

-- Distribution Centers Report: Shows warehouses and their details
CREATE VIEW distribution_centers AS
SELECT 
    w.warehouse_id,
    w.name AS warehouse_name,
    w.location,
    w.capacity,
    w.manager,
    w.type AS warehouse_type,
    w.operational_status,
    w.contact
FROM 
    warehouse w;

-- Payments Report: Shows payment details for orders
CREATE VIEW payments_report AS
SELECT 
    p.payment_id,
    p.payment_date,
    p.payment_method,
    p.amount AS payment_amount,
    o.order_id,
    o.order_date,
    o.total_amount AS order_total,
    c.customer_id,
    c.name AS customer_name,
    c.contact AS customer_contact
FROM 
    payment p
JOIN 
    orders o ON p.order_id = o.order_id
JOIN 
    customer c ON o.customer_id = c.customer_id;

-- Maintenance Logs Report: Shows maintenance details for vehicles
CREATE VIEW maintenance_logs_report AS
SELECT 
    ml.log_id,
    ml.maintenance_date,
    ml.description AS maintenance_description,
    ml.cost AS maintenance_cost,
    tv.vehicle_id,
    tv.type AS vehicle_type,
    tv.status AS vehicle_status,
    tv.capacity AS vehicle_capacity
FROM 
    maintenance_log ml
JOIN 
    transportation_vehicle tv ON ml.vehicle_id = tv.vehicle_id;

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