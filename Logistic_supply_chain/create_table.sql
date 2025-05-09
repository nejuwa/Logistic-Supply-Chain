-- Create database if it does not exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'national_logistics_and_supply_chain')
BEGIN
    CREATE DATABASE national_logistics_and_supply_chain;
END;
GO

USE national_logistics_and_supply_chain;
GO

-- Enhanced product table with additional attributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'product' AND xtype = 'U')
BEGIN
    CREATE TABLE product (
        product_id VARCHAR(10) NOT NULL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        description TEXT,
        weight DECIMAL(10,2) NOT NULL,
        hs_code VARCHAR(10) NOT NULL,
        category VARCHAR(20) NOT NULL,
        storage_type VARCHAR(20) NOT NULL,
        price DECIMAL(10,2) NOT NULL,
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT GETDATE()
    );
END;
GO

-- Enhanced supplier table with additional attributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'supplier' AND xtype = 'U')
BEGIN
    CREATE TABLE supplier (
        supplier_id VARCHAR(10) NOT NULL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        address TEXT,
        contact_number VARCHAR(15),
        email VARCHAR(50),
        contract_terms TEXT,
        reliability_score VARCHAR(20),
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT GETDATE()
    );
END;
GO

-- Supplier-product relationship
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'supplier_product' AND xtype = 'U')
BEGIN
    CREATE TABLE supplier_product (
        supplier_id VARCHAR(10) NOT NULL,
        product_id VARCHAR(10) NOT NULL,
        PRIMARY KEY (supplier_id, product_id),
        FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id),
        FOREIGN KEY (product_id) REFERENCES product (product_id)
    );
END;
GO

-- Enhanced warehouse table with additional attributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'warehouse' AND xtype = 'U')
BEGIN
    CREATE TABLE warehouse (
        warehouse_id VARCHAR(10) NOT NULL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        location VARCHAR(50) NOT NULL,
        capacity INT NOT NULL,
        manager VARCHAR(50),
        type VARCHAR(20) NOT NULL,
        contact VARCHAR(15),
        operational_status VARCHAR(20) DEFAULT 'Active',
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT GETDATE()
    );
END;
GO

-- Warehouse-product relationship
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'warehouse_product' AND xtype = 'U')
BEGIN
    CREATE TABLE warehouse_product (
        warehouse_id VARCHAR(10) NOT NULL,
        product_id VARCHAR(10) NOT NULL,
        quantity INT NOT NULL DEFAULT 0,
        PRIMARY KEY (warehouse_id, product_id),
        FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id),
        FOREIGN KEY (product_id) REFERENCES product (product_id)
    );
END;
GO

-- Enhanced route table with additional attributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'route' AND xtype = 'U')
BEGIN
    CREATE TABLE route (
        route_id VARCHAR(10) NOT NULL PRIMARY KEY,
        distance INT NOT NULL,
        origin_warehouse_id VARCHAR(10) NOT NULL,
        destination_warehouse_id VARCHAR(10) NOT NULL,
        estimated_time INT NOT NULL, -- in minutes
        transportation_cost DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (origin_warehouse_id) REFERENCES warehouse (warehouse_id),
        FOREIGN KEY (destination_warehouse_id) REFERENCES warehouse (warehouse_id)
    );
END;
GO

-- Enhanced transportation_vehicle table with additional attributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'transportation_vehicle' AND xtype = 'U')
BEGIN
    CREATE TABLE transportation_vehicle (
        vehicle_id VARCHAR(10) NOT NULL PRIMARY KEY,
        type VARCHAR(20) NOT NULL,
        status VARCHAR(20) NOT NULL,
        capacity DECIMAL(10,2),
        fuel_type VARCHAR(20),
        maintenance_date DATE
    );
END;
GO

-- Enhanced driver table with additional attributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'driver' AND xtype = 'U')
BEGIN
    CREATE TABLE driver (
        driver_id VARCHAR(10) NOT NULL PRIMARY KEY,
        license_number VARCHAR(20) NOT NULL,
        name VARCHAR(50) NOT NULL,
        contact VARCHAR(15),
        address TEXT,
        hire_date DATE
    );
END;
GO

-- Vehicle-driver relationship
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'vehicle_driver' AND xtype = 'U')
BEGIN
    CREATE TABLE vehicle_driver (
        vehicle_id VARCHAR(10) NOT NULL,
        driver_id VARCHAR(10) NOT NULL,
        assignment_date DATE NOT NULL,
        PRIMARY KEY (vehicle_id, driver_id),
        FOREIGN KEY (vehicle_id) REFERENCES transportation_vehicle (vehicle_id),
        FOREIGN KEY (driver_id) REFERENCES driver (driver_id)
    );
END;
GO

-- Enhanced shipment table with additional attributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'shipment' AND xtype = 'U')
BEGIN
    CREATE TABLE shipment (
        shipment_id VARCHAR(10) NOT NULL PRIMARY KEY,
        status VARCHAR(20) NOT NULL,
        estimated_arrival DATE,
        actual_arrival DATE,
        vehicle_id VARCHAR(10),
        route_id VARCHAR(10) NOT NULL,
        departure_time DATETIME,
        total_weight DECIMAL(10,2),
        total_cost DECIMAL(10,2),
        FOREIGN KEY (vehicle_id) REFERENCES transportation_vehicle (vehicle_id),
        FOREIGN KEY (route_id) REFERENCES route (route_id)
    );
END;
GO

-- Tracking log
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'tracking_log' AND xtype = 'U')
BEGIN
    CREATE TABLE tracking_log (
        log_id VARCHAR(10) NOT NULL PRIMARY KEY,
        timestamp DATETIME DEFAULT GETDATE(),
        shipment_id VARCHAR(10) NOT NULL,
        location VARCHAR(50) NOT NULL,
        status VARCHAR(20) NOT NULL,
        notes TEXT,
        FOREIGN KEY (shipment_id) REFERENCES shipment (shipment_id)
    );
END;
GO

-- Customs clearance
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'customs_clearance' AND xtype = 'U')
BEGIN
    CREATE TABLE customs_clearance (
        clearance_id VARCHAR(10) NOT NULL PRIMARY KEY,
        tax_duty DECIMAL(10,2) NOT NULL,
        shipment_id VARCHAR(10) NOT NULL,
        clearance_date DATE NOT NULL,
        status VARCHAR(20) NOT NULL,
        FOREIGN KEY (shipment_id) REFERENCES shipment (shipment_id)
    );
END;
GO

-- Enhanced customer table with additional attributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'customer' AND xtype = 'U')
BEGIN
    CREATE TABLE customer (
        customer_id VARCHAR(10) NOT NULL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        tax_id VARCHAR(20),
        contact VARCHAR(15),
        email VARCHAR(50),
        address TEXT,
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT GETDATE()
    );
END;
GO

-- Orders table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'orders' AND xtype = 'U')
BEGIN
    CREATE TABLE orders (
        order_id VARCHAR(10) NOT NULL PRIMARY KEY,
        order_date DATE NOT NULL,
        customer_id VARCHAR(10) NOT NULL,
        status VARCHAR(20) NOT NULL,
        total_amount DECIMAL(10,2),
        FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
    );
END;
GO

-- Order items
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'order_item' AND xtype = 'U')
BEGIN
    CREATE TABLE order_item (
        order_item_id VARCHAR(10) NOT NULL PRIMARY KEY,
        quantity INT NOT NULL,
        unit_price DECIMAL(10,2) NOT NULL,
        product_id VARCHAR(10) NOT NULL,
        order_id VARCHAR(10) NOT NULL,
        FOREIGN KEY (product_id) REFERENCES product (product_id),
        FOREIGN KEY (order_id) REFERENCES orders (order_id)
    );
END;
GO

-- Invoice table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'invoice' AND xtype = 'U')
BEGIN
    CREATE TABLE invoice (
        invoice_id VARCHAR(10) NOT NULL PRIMARY KEY,
        amount DECIMAL(10,2) NOT NULL,
        issue_date DATE NOT NULL,
        due_date DATE NOT NULL,
        order_id VARCHAR(10) NOT NULL,
        status VARCHAR(20) NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders (order_id)
    );
END;
GO

-- Returns table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'returns' AND xtype = 'U')
BEGIN
    CREATE TABLE returns (
        return_id VARCHAR(10) NOT NULL PRIMARY KEY,
        order_id VARCHAR(10) NOT NULL,
        customer_id VARCHAR(10) NOT NULL,
        return_date DATE NOT NULL,
        reason TEXT NOT NULL,
        status VARCHAR(20) NOT NULL,
        refund_amount DECIMAL(10,2),
        FOREIGN KEY (order_id) REFERENCES orders (order_id),
        FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
    );
END;
GO

-- Payment details
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'payment' AND xtype = 'U')
BEGIN
    CREATE TABLE payment (
        payment_id VARCHAR(10) NOT NULL PRIMARY KEY,
        order_id VARCHAR(10) NOT NULL,
        payment_date DATE NOT NULL,
        payment_method VARCHAR(20) NOT NULL,
        amount DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders (order_id)
    );
END;
GO

-- Maintenance logs for vehicles
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'maintenance_log' AND xtype = 'U')
BEGIN
    CREATE TABLE maintenance_log (
        log_id VARCHAR(10) NOT NULL PRIMARY KEY,
        vehicle_id VARCHAR(10) NOT NULL,
        maintenance_date DATE NOT NULL,
        description TEXT NOT NULL,
        cost DECIMAL(10,2),
        FOREIGN KEY (vehicle_id) REFERENCES transportation_vehicle (vehicle_id)
    );
END;
GO