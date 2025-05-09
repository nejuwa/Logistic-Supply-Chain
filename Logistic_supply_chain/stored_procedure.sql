-- Non-parameterized stored procedure
CREATE PROCEDURE [dbo].[get_products_warehouses_report]
AS
BEGIN
    SELECT 
        p.product_id,
        p.name AS product_name,
        w.warehouse_id,
        w.name AS warehouse_name,
        wp.quantity
    FROM 
        [dbo].[product] p
    JOIN 
        [dbo].[warehouse_product] wp ON p.product_id = wp.product_id
    JOIN 
        [dbo].[warehouse] w ON wp.warehouse_id = w.warehouse_id;
END;
GO

-- Parameterized stored procedure
CREATE PROCEDURE [dbo].[get_products_warehouses_report_by_product]
    @product_id INT
AS
BEGIN
    SELECT 
        p.product_id,
        p.name AS product_name,
        w.warehouse_id,
        w.name AS warehouse_name,
        wp.quantity
    FROM 
        [dbo].[product] p
    JOIN 
        [dbo].[warehouse_product] wp ON p.product_id = wp.product_id
    JOIN 
        [dbo].[warehouse] w ON wp.warehouse_id = w.warehouse_id
    WHERE 
        p.product_id = @product_id;
END;
GO