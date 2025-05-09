-- Insert data into 'product'
INSERT INTO product (product_id, name, description, weight, hs_code, category, storage_type, price) VALUES
('P001', 'Product A', 'Description of Product A', 10.5, 'HS001', 'Category 1', 'Cold', 100.00),
('P002', 'Product B', 'Description of Product B', 5.0, 'HS002', 'Category 2', 'Dry', 50.00),
('P003', 'Product C', 'Description of Product C', 7.2, 'HS003', 'Category 1', 'Cold', 70.00),
('P004', 'Product D', 'Description of Product D', 12.0, 'HS004', 'Category 3', 'Dry', 120.00),
('P005', 'Product E', 'Description of Product E', 8.5, 'HS005', 'Category 2', 'Cold', 85.00),
('P006', 'Product F', 'Description of Product F', 15.0, 'HS006', 'Category 3', 'Dry', 150.00),
('P007', 'Product G', 'Description of Product G', 6.8, 'HS007', 'Category 1', 'Cold', 68.00),
('P008', 'Product H', 'Description of Product H', 9.3, 'HS008', 'Category 2', 'Dry', 93.00),
('P009', 'Product I', 'Description of Product I', 11.1, 'HS009', 'Category 3', 'Cold', 111.00),
('P010', 'Product J', 'Description of Product J', 4.5, 'HS010', 'Category 1', 'Dry', 45.00);

-- Insert data into 'supplier'
INSERT INTO supplier (supplier_id, name, address, contact_number, email, contract_terms, reliability_score) VALUES
('S001', 'Supplier A', '123 Supplier St.', '1234567890', 'supplierA@example.com', 'Terms A', 'High'),
('S002', 'Supplier B', '456 Supplier Ave.', '1234567891', 'supplierB@example.com', 'Terms B', 'Medium'),
('S003', 'Supplier C', '789 Supplier Blvd.', '1234567892', 'supplierC@example.com', 'Terms C', 'Low'),
('S004', 'Supplier D', '101 Supplier Rd.', '1234567893', 'supplierD@example.com', 'Terms D', 'High'),
('S005', 'Supplier E', '202 Supplier Ln.', '1234567894', 'supplierE@example.com', 'Terms E', 'Medium'),
('S006', 'Supplier F', '303 Supplier Ct.', '1234567895', 'supplierF@example.com', 'Terms F', 'Low'),
('S007', 'Supplier G', '404 Supplier Dr.', '1234567896', 'supplierG@example.com', 'Terms G', 'High'),
('S008', 'Supplier H', '505 Supplier Pl.', '1234567897', 'supplierH@example.com', 'Terms H', 'Medium'),
('S009', 'Supplier I', '606 Supplier Way.', '1234567898', 'supplierI@example.com', 'Terms I', 'Low'),
('S010', 'Supplier J', '707 Supplier Cir.', '1234567899', 'supplierJ@example.com', 'Terms J', 'High');

-- Insert data into 'supplier_product'
INSERT INTO supplier_product (supplier_id, product_id) VALUES
('S001', 'P001'),
('S002', 'P002'),
('S003', 'P003'),
('S004', 'P004'),
('S005', 'P005'),
('S006', 'P006'),
('S007', 'P007'),
('S008', 'P008'),
('S009', 'P009'),
('S010', 'P010');

-- Insert data into 'warehouse'
INSERT INTO warehouse (warehouse_id, name, location, capacity, manager, type, contact, operational_status) VALUES
('W001', 'Warehouse A', 'Location A', 1000, 'Manager A', 'Cold', '1234567890', 'Active'),
('W002', 'Warehouse B', 'Location B', 800, 'Manager B', 'Dry', '1234567891', 'Active'),
('W003', 'Warehouse C', 'Location C', 1200, 'Manager C', 'Cold', '1234567892', 'Active'),
('W004', 'Warehouse D', 'Location D', 900, 'Manager D', 'Dry', '1234567893', 'Active'),
('W005', 'Warehouse E', 'Location E', 1100, 'Manager E', 'Cold', '1234567894', 'Active'),
('W006', 'Warehouse F', 'Location F', 700, 'Manager F', 'Dry', '1234567895', 'Active'),
('W007', 'Warehouse G', 'Location G', 1300, 'Manager G', 'Cold', '1234567896', 'Active'),
('W008', 'Warehouse H', 'Location H', 1000, 'Manager H', 'Dry', '1234567897', 'Active'),
('W009', 'Warehouse I', 'Location I', 1400, 'Manager I', 'Cold', '1234567898', 'Active'),
('W010', 'Warehouse J', 'Location J', 800, 'Manager J', 'Dry', '1234567899', 'Active');

-- Insert data into 'warehouse_product'
INSERT INTO warehouse_product (warehouse_id, product_id, quantity) VALUES
('W001', 'P001', 100),
('W002', 'P002', 200),
('W003', 'P003', 150),
('W004', 'P004', 180),
('W005', 'P005', 120),
('W006', 'P006', 300),
('W007', 'P007', 250),
('W008', 'P008', 170),
('W009', 'P009', 220),
('W010', 'P010', 190);

-- Insert data into 'route'
INSERT INTO route (route_id, distance, origin_warehouse_id, destination_warehouse_id, estimated_time, transportation_cost) VALUES
('R001', 100, 'W001', 'W002', 60, 500.00),
('R002', 200, 'W002', 'W003', 120, 1000.00),
('R003', 150, 'W003', 'W004', 90, 750.00),
('R004', 180, 'W004', 'W005', 110, 900.00),
('R005', 120, 'W005', 'W006', 80, 600.00),
('R006', 300, 'W006', 'W007', 150, 1500.00),
('R007', 250, 'W007', 'W008', 130, 1250.00),
('R008', 170, 'W008', 'W009', 100, 850.00),
('R009', 220, 'W009', 'W010', 140, 1100.00),
('R010', 190, 'W010', 'W001', 120, 950.00);

-- Insert data into 'transportation_vehicle'
INSERT INTO transportation_vehicle (vehicle_id, type, status, capacity, fuel_type, maintenance_date) VALUES
('V001', 'Truck', 'Available', 5000, 'Diesel', '2025-05-01'),
('V002', 'Van', 'In Use', 3000, 'Petrol', '2025-05-02'),
('V003', 'Truck', 'Available', 6000, 'Diesel', '2025-05-03'),
('V004', 'Van', 'In Use', 4000, 'Petrol', '2025-05-04'),
('V005', 'Truck', 'Available', 7000, 'Diesel', '2025-05-05'),
('V006', 'Van', 'In Use', 3500, 'Petrol', '2025-05-06'),
('V007', 'Truck', 'Available', 8000, 'Diesel', '2025-05-07'),
('V008', 'Van', 'In Use', 4500, 'Petrol', '2025-05-08'),
('V009', 'Truck', 'Available', 9000, 'Diesel', '2025-05-09'),
('V010', 'Van', 'In Use', 5000, 'Petrol', '2025-05-10');

-- Insert data into 'driver'
INSERT INTO driver (driver_id, license_number, name, contact, address, hire_date) VALUES
('D001', 'L001', 'Driver A', '1234567890', '123 Driver St.', '2025-01-01'),
('D002', 'L002', 'Driver B', '1234567891', '456 Driver Ave.', '2025-02-01'),
('D003', 'L003', 'Driver C', '1234567892', '789 Driver Blvd.', '2025-03-01'),
('D004', 'L004', 'Driver D', '1234567893', '101 Driver Rd.', '2025-04-01'),
('D005', 'L005', 'Driver E', '1234567894', '202 Driver Ln.', '2025-05-01'),
('D006', 'L006', 'Driver F', '1234567895', '303 Driver Ct.', '2025-06-01'),
('D007', 'L007', 'Driver G', '1234567896', '404 Driver Dr.', '2025-07-01'),
('D008', 'L008', 'Driver H', '1234567897', '505 Driver Pl.', '2025-08-01'),
('D009', 'L009', 'Driver I', '1234567898', '606 Driver Way.', '2025-09-01'),
('D010', 'L010', 'Driver J', '1234567899', '707 Driver Cir.', '2025-10-01');

-- Insert data into 'vehicle_driver'
INSERT INTO vehicle_driver (vehicle_id, driver_id, assignment_date) VALUES
('V001', 'D001', '2025-05-01'),
('V002', 'D002', '2025-05-02'),
('V003', 'D003', '2025-05-03'),
('V004', 'D004', '2025-05-04'),
('V005', 'D005', '2025-05-05'),
('V006', 'D006', '2025-05-06'),
('V007', 'D007', '2025-05-07'),
('V008', 'D008', '2025-05-08'),
('V009', 'D009', '2025-05-09'),
('V010', 'D010', '2025-05-10');

-- Insert data into 'shipment'
INSERT INTO shipment (shipment_id, status, estimated_arrival, actual_arrival, vehicle_id, route_id, departure_time, total_weight, total_cost) VALUES
('SH001', 'In Transit', '2025-05-10', NULL, 'V001', 'R001', '2025-05-05 08:00:00', 500.00, 1000.00),
('SH002', 'Delivered', '2025-05-09', '2025-05-09', 'V002', 'R002', '2025-05-04 09:00:00', 300.00, 600.00),
('SH003', 'In Transit', '2025-05-11', NULL, 'V003', 'R003', '2025-05-06 10:00:00', 700.00, 1400.00),
('SH004', 'Pending', '2025-05-12', NULL, 'V004', 'R004', '2025-05-07 11:00:00', 400.00, 800.00),
('SH005', 'Delivered', '2025-05-08', '2025-05-08', 'V005', 'R005', '2025-05-03 12:00:00', 600.00, 1200.00),
('SH006', 'In Transit', '2025-05-13', NULL, 'V006', 'R006', '2025-05-08 13:00:00', 350.00, 700.00),
('SH007', 'Pending', '2025-05-14', NULL, 'V007', 'R007', '2025-05-09 14:00:00', 800.00, 1600.00),
('SH008', 'Delivered', '2025-05-07', '2025-05-07', 'V008', 'R008', '2025-05-02 15:00:00', 450.00, 900.00),
('SH009', 'In Transit', '2025-05-15', NULL, 'V009', 'R009', '2025-05-10 16:00:00', 900.00, 1800.00),
('SH010', 'Pending', '2025-05-16', NULL, 'V010', 'R010', '2025-05-11 17:00:00', 500.00, 1000.00);

-- Insert data into 'tracking_log'
INSERT INTO tracking_log (log_id, timestamp, shipment_id, location, status, notes) VALUES
('TL001', '2025-05-05 08:30:00', 'SH001', 'Checkpoint A', 'In Transit', 'No issues'),
('TL002', '2025-05-04 09:30:00', 'SH002', 'Checkpoint B', 'Delivered', 'Delivered successfully'),
('TL003', '2025-05-06 10:30:00', 'SH003', 'Checkpoint C', 'In Transit', 'Minor delay'),
('TL004', '2025-05-07 11:30:00', 'SH004', 'Checkpoint D', 'Pending', 'Awaiting clearance'),
('TL005', '2025-05-03 12:30:00', 'SH005', 'Checkpoint E', 'Delivered', 'Delivered successfully'),
('TL006', '2025-05-08 13:30:00', 'SH006', 'Checkpoint F', 'In Transit', 'No issues'),
('TL007', '2025-05-09 14:30:00', 'SH007', 'Checkpoint G', 'Pending', 'Awaiting clearance'),
('TL008', '2025-05-02 15:30:00', 'SH008', 'Checkpoint H', 'Delivered', 'Delivered successfully'),
('TL009', '2025-05-10 16:30:00', 'SH009', 'Checkpoint I', 'In Transit', 'No issues'),
('TL010', '2025-05-11 17:30:00', 'SH010', 'Checkpoint J', 'Pending', 'Awaiting clearance');

-- Insert data into 'customs_clearance'
INSERT INTO customs_clearance (clearance_id, tax_duty, shipment_id, clearance_date, status) VALUES
('CC001', 500.00, 'SH001', '2025-05-06', 'Cleared'),
('CC002', 300.00, 'SH002', '2025-05-05', 'Cleared'),
('CC003', 400.00, 'SH003', '2025-05-07', 'Cleared'),
('CC004', 200.00, 'SH004', '2025-05-08', 'Pending'),
('CC005', 600.00, 'SH005', '2025-05-04', 'Cleared'),
('CC006', 700.00, 'SH006', '2025-05-09', 'Pending'),
('CC007', 800.00, 'SH007', '2025-05-10', 'Pending'),
('CC008', 900.00, 'SH008', '2025-05-03', 'Cleared'),
('CC009', 1000.00, 'SH009', '2025-05-11', 'Pending'),
('CC010', 1100.00, 'SH010', '2025-05-12', 'Pending');

-- Insert data into 'customer'
INSERT INTO customer (customer_id, name, tax_id, contact, email, address) VALUES
('C001', 'Customer A', 'T001', '1234567890', 'customerA@example.com', '123 Customer St.'),
('C002', 'Customer B', 'T002', '1234567891', 'customerB@example.com', '456 Customer Ave.'),
('C003', 'Customer C', 'T003', '1234567892', 'customerC@example.com', '789 Customer Blvd.'),
('C004', 'Customer D', 'T004', '1234567893', 'customerD@example.com', '101 Customer Rd.'),
('C005', 'Customer E', 'T005', '1234567894', 'customerE@example.com', '202 Customer Ln.'),
('C006', 'Customer F', 'T006', '1234567895', 'customerF@example.com', '303 Customer Ct.'),
('C007', 'Customer G', 'T007', '1234567896', 'customerG@example.com', '404 Customer Dr.'),
('C008', 'Customer H', 'T008', '1234567897', 'customerH@example.com', '505 Customer Pl.'),
('C009', 'Customer I', 'T009', '1234567898', 'customerI@example.com', '606 Customer Way.'),
('C010', 'Customer J', 'T010', '1234567899', 'customerJ@example.com', '707 Customer Cir.');

-- Insert data into 'orders'
INSERT INTO orders (order_id, order_date, customer_id, status, total_amount) VALUES
('O001', '2025-05-01', 'C001', 'Pending', 1000.00),
('O002', '2025-05-02', 'C002', 'Completed', 2000.00),
('O003', '2025-05-03', 'C003', 'Pending', 1500.00),
('O004', '2025-05-04', 'C004', 'Completed', 1800.00),
('O005', '2025-05-05', 'C005', 'Pending', 1200.00),
('O006', '2025-05-06', 'C006', 'Completed', 3000.00),
('O007', '2025-05-07', 'C007', 'Pending', 2500.00),
('O008', '2025-05-08', 'C008', 'Completed', 1700.00),
('O009', '2025-05-09', 'C009', 'Pending', 2200.00),
('O010', '2025-05-10', 'C010', 'Completed', 1900.00);

-- Insert data into 'order_item'
INSERT INTO order_item (order_item_id, quantity, unit_price, product_id, order_id) VALUES
('OI001', 10, 100.00, 'P001', 'O001'),
('OI002', 20, 200.00, 'P002', 'O002'),
('OI003', 15, 150.00, 'P003', 'O003'),
('OI004', 18, 180.00, 'P004', 'O004'),
('OI005', 12, 120.00, 'P005', 'O005'),
('OI006', 30, 300.00, 'P006', 'O006'),
('OI007', 25, 250.00, 'P007', 'O007'),
('OI008', 17, 170.00, 'P008', 'O008'),
('OI009', 22, 220.00, 'P009', 'O009'),
('OI010', 19, 190.00, 'P010', 'O010');

-- Insert data into 'invoice'
INSERT INTO invoice (invoice_id, amount, issue_date, due_date, order_id, status) VALUES
('I001', 1000.00, '2025-05-01', '2025-05-10', 'O001', 'Unpaid'),
('I002', 2000.00, '2025-05-02', '2025-05-11', 'O002', 'Paid'),
('I003', 1500.00, '2025-05-03', '2025-05-12', 'O003', 'Unpaid'),
('I004', 1800.00, '2025-05-04', '2025-05-13', 'O004', 'Paid'),
('I005', 1200.00, '2025-05-05', '2025-05-14', 'O005', 'Unpaid'),
('I006', 3000.00, '2025-05-06', '2025-05-15', 'O006', 'Paid'),
('I007', 2500.00, '2025-05-07', '2025-05-16', 'O007', 'Unpaid'),
('I008', 1700.00, '2025-05-08', '2025-05-17', 'O008', 'Paid'),
('I009', 2200.00, '2025-05-09', '2025-05-18', 'O009', 'Unpaid'),
('I010', 1900.00, '2025-05-10', '2025-05-19', 'O010', 'Paid');

-- Insert data into 'return'
INSERT INTO returns (return_id, order_id, customer_id, return_date, reason, status, refund_amount) VALUES
('R001', 'O001', 'C001', '2025-05-11', 'Damaged product', 'Processed', 500.00),
('R002', 'O002', 'C002', '2025-05-12', 'Wrong item delivered', 'Pending', 1000.00),
('R003', 'O003', 'C003', '2025-05-13', 'Product expired', 'Processed', 750.00),
('R004', 'O004', 'C004', '2025-05-14', 'Packaging damaged', 'Pending', 900.00),
('R005', 'O005', 'C005', '2025-05-15', 'Late delivery', 'Processed', 600.00),
('R006', 'O006', 'C006', '2025-05-16', 'Product defective', 'Pending', 1500.00),
('R007', 'O007', 'C007', '2025-05-17', 'Incorrect quantity', 'Processed', 1250.00),
('R008', 'O008', 'C008', '2025-05-18', 'Customer changed mind', 'Pending', 850.00),
('R009', 'O009', 'C009', '2025-05-19', 'Product damaged in transit', 'Processed', 1100.00),
('R010', 'O010', 'C010', '2025-05-20', 'Other', 'Pending', 950.00);

-- Insert data into 'payment'
INSERT INTO payment (payment_id, order_id, payment_date, payment_method, amount) VALUES
('P001', 'O001', '2025-05-11', 'Credit Card', 1000.00),
('P002', 'O002', '2025-05-12', 'Bank Transfer', 2000.00),
('P003', 'O003', '2025-05-13', 'Cash', 1500.00),
('P004', 'O004', '2025-05-14', 'Credit Card', 1800.00),
('P005', 'O005', '2025-05-15', 'Bank Transfer', 1200.00),
('P006', 'O006', '2025-05-16', 'Cash', 3000.00),
('P007', 'O007', '2025-05-17', 'Credit Card', 2500.00),
('P008', 'O008', '2025-05-18', 'Bank Transfer', 1700.00),
('P009', 'O009', '2025-05-19', 'Cash', 2200.00),
('P010', 'O010', '2025-05-20', 'Credit Card', 1900.00);

-- Insert data into 'maintenance_log'
INSERT INTO maintenance_log (log_id, vehicle_id, maintenance_date, description, cost) VALUES
('ML001', 'V001', '2025-05-01', 'Engine repair', 1000.00),
('ML002', 'V002', '2025-05-02', 'Tire replacement', 500.00),
('ML003', 'V003', '2025-05-03', 'Oil change', 200.00),
('ML004', 'V004', '2025-05-04', 'Brake inspection', 300.00),
('ML005', 'V005', '2025-05-05', 'Transmission repair', 1500.00),
('ML006', 'V006', '2025-05-06', 'Battery replacement', 400.00),
('ML007', 'V007', '2025-05-07', 'Suspension repair', 800.00),
('ML008', 'V008', '2025-05-08', 'Air conditioning repair', 600.00),
('ML009', 'V009', '2025-05-09', 'Fuel system repair', 1200.00),
('ML010', 'V010', '2025-05-10', 'Exhaust system repair', 700.00);