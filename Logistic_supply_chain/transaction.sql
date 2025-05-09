-- Transaction 1: Add new stock to a warehouse
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[warehouse_product]
    SET quantity = quantity + 100
    WHERE warehouse_id = 'W001' AND product_id = 'P001';
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 2: Remove stock from a warehouse for shipment
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[warehouse_product]
    SET quantity = quantity - 50
    WHERE warehouse_id = 'W001' AND product_id = 'P001';

    INSERT INTO [dbo].[shipment] (shipment_id, status, route_id, departure_time, total_weight, total_cost)
    VALUES ('S001', 'In Transit', 'R001', GETDATE(), 500.00, 1000.00);

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 3: Transfer stock between warehouses
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[warehouse_product]
    SET quantity = quantity - 30
    WHERE warehouse_id = 'W001' AND product_id = 'P002';

    UPDATE [dbo].[warehouse_product]
    SET quantity = quantity + 30
    WHERE warehouse_id = 'W002' AND product_id = 'P002';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 4: Add a new product to inventory
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[product] (product_id, name, description, weight, hs_code, category, storage_type, price)
    VALUES ('P010', 'New Product', 'A new electronic product', 5.00, '123456', 'Electronics', 'Dry', 150.00);

    INSERT INTO [dbo].[warehouse_product] (warehouse_id, product_id, quantity)
    VALUES ('W001', 'P010', 200);

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 5: Process a customer order
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[orders] (order_id, order_date, customer_id, status, total_amount)
    VALUES ('O001', GETDATE(), 'C001', 'Processing', 1500.00);

    INSERT INTO [dbo].[order_item] (order_item_id, quantity, unit_price, product_id, order_id)
    VALUES ('OI001', 10, 150.00, 'P001', 'O001');

    UPDATE [dbo].[warehouse_product]
    SET quantity = quantity - 10
    WHERE warehouse_id = 'W001' AND product_id = 'P001';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 6: Return a product
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[returns] (return_id, order_id, customer_id, return_date, reason, status, refund_amount)
    VALUES ('R001', 'O001', 'C001', GETDATE(), 'Damaged product', 'Processed', 1500.00);

    UPDATE [dbo].[warehouse_product]
    SET quantity = quantity + 10
    WHERE warehouse_id = 'W001' AND product_id = 'P001';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 7: Update warehouse capacity
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[warehouse]
    SET capacity = capacity + 500
    WHERE warehouse_id = 'W001';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 8: Assign a driver to a vehicle
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[vehicle_driver] (vehicle_id, driver_id, assignment_date)
    VALUES ('V001', 'D001', GETDATE());

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 9: Update shipment status
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[shipment]
    SET status = 'Delivered', actual_arrival = GETDATE()
    WHERE shipment_id = 'S001';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 10: Add a new supplier
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[supplier] (supplier_id, name, address, contact_number, email, contract_terms, reliability_score)
    VALUES ('S005', 'New Supplier', '123 Supplier St.', '1234567890', 'supplier@example.com', '1-year contract', 'High');

    INSERT INTO [dbo].[supplier_product] (supplier_id, product_id)
    VALUES ('S005', 'P003');

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 11: Remove a product from inventory
BEGIN TRANSACTION;
BEGIN TRY
    DELETE FROM [dbo].[warehouse_product]
    WHERE product_id = 'P004' AND warehouse_id = 'W002';

    DELETE FROM [dbo].[product]
    WHERE product_id = 'P004';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 12: Update product details
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[product]
    SET weight = 6.50, category = 'Updated Category', price = 200.00
    WHERE product_id = 'P002';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 13: Add a new route
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[route] (route_id, distance, origin_warehouse_id, destination_warehouse_id, estimated_time, transportation_cost)
    VALUES ('R005', 300, 'W001', 'W003', 180, 500.00);

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 14: Process customs clearance
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[customs_clearance] (clearance_id, tax_duty, shipment_id, clearance_date, status)
    VALUES ('CC001', 500.00, 'S001', GETDATE(), 'Cleared');

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 15: Update warehouse manager
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[warehouse]
    SET manager = 'New Manager'
    WHERE warehouse_id = 'W002';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 16: Add a new customer
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[customer] (customer_id, name, tax_id, contact, email, address)
    VALUES ('C005', 'New Customer', 'TAX12345', '1234567890', 'customer@example.com', '456 Customer Lane');

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 17: Cancel an order
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[orders]
    SET status = 'Cancelled'
    WHERE order_id = 'O002';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 18: Update vehicle status
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[transportation_vehicle]
    SET status = 'Under Maintenance', maintenance_date = GETDATE()
    WHERE vehicle_id = 'V002';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 19: Add a new driver
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[driver] (driver_id, license_number, name, contact, address, hire_date)
    VALUES ('D005', 'LIC12345', 'New Driver', '9876543210', '789 Driver Blvd.', GETDATE());

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 20: Adjust stock for damaged goods
BEGIN TRANSACTION;
BEGIN TRY
    UPDATE [dbo].[warehouse_product]
    SET quantity = quantity - 5
    WHERE warehouse_id = 'W001' AND product_id = 'P003';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 21: Record a payment for an order
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[payment] (payment_id, order_id, payment_date, payment_method, amount)
    VALUES ('P001', 'O001', GETDATE(), 'Credit Card', 1500.00);

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Transaction 22: Log vehicle maintenance
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO [dbo].[maintenance_log] (log_id, vehicle_id, maintenance_date, description, cost)
    VALUES ('ML001', 'V001', GETDATE(), 'Engine repair', 1000.00);

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;