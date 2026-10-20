-- Fictional sample data. Run after 01_create_tables.sql.
INSERT INTO customers VALUES
(1, 'Aarav', 'Hyderabad', '2025-01-10'),
(2, 'Diya', 'Hyderabad', '2025-02-12'),
(3, 'Kabir', 'Secunderabad', '2025-03-05'),
(4, 'Meera', 'Hyderabad', '2025-04-20'),
(5, 'Ishaan', 'Warangal', '2025-05-02'),
(6, 'Sana', 'Hyderabad', '2025-05-14');

INSERT INTO restaurants VALUES
(10, 'Spice Route', 'Indian', 'Hyderabad'),
(11, 'Green Bowl', 'Healthy', 'Hyderabad'),
(12, 'Pizza Corner', 'Italian', 'Secunderabad'),
(13, 'Dosa House', 'South Indian', 'Hyderabad');

INSERT INTO menu_items VALUES
(100, 10, 'Paneer Biryani', 'Main Course', 240.00),
(101, 10, 'Masala Dosa', 'Main Course', 120.00),
(102, 11, 'Grilled Veg Bowl', 'Healthy', 180.00),
(103, 11, 'Fruit Smoothie', 'Beverage', 90.00),
(104, 12, 'Margherita Pizza', 'Main Course', 280.00),
(105, 12, 'Garlic Bread', 'Side', 110.00),
(106, 13, 'Idli Plate', 'Breakfast', 80.00),
(107, 13, 'Filter Coffee', 'Beverage', 50.00);

INSERT INTO orders VALUES
(1000, 1, 10, '2025-05-01 12:15:00', 'Delivered', 25.00),
(1001, 2, 10, '2025-05-01 19:10:00', 'Delivered', 20.00),
(1002, 1, 11, '2025-05-02 13:30:00', 'Cancelled', 0.00),
(1003, 3, 12, '2025-05-03 20:00:00', 'Delivered', 30.00),
(1004, 4, 11, '2025-05-04 11:45:00', 'Delivered', 15.00),
(1005, 2, 10, '2025-05-05 18:05:00', 'Preparing', 20.00),
(1006, 1, 10, '2025-05-06 20:20:00', 'Delivered', 25.00),
(1007, 5, 13, '2025-05-07 08:15:00', 'Delivered', 10.00),
(1008, 3, 12, '2025-06-01 19:25:00', 'Delivered', 30.00),
(1009, 6, 11, '2025-06-02 12:05:00', 'Cancelled', 0.00),
(1010, 4, 13, '2025-06-03 09:10:00', 'Delivered', 10.00),
(1011, 2, 10, '2025-06-04 19:40:00', 'On the way', 20.00),
(1012, 5, 13, '2025-06-05 08:25:00', 'Delivered', 10.00),
(1013, 6, 11, '2025-06-06 13:00:00', 'Delivered', 15.00);

INSERT INTO order_items VALUES
(1, 1000, 100, 1, 240.00),
(2, 1000, 101, 1, 120.00),
(3, 1001, 100, 2, 240.00),
(4, 1002, 102, 1, 180.00),
(5, 1003, 104, 2, 280.00),
(6, 1003, 105, 1, 110.00),
(7, 1004, 102, 2, 180.00),
(8, 1004, 103, 1, 90.00),
(9, 1005, 101, 2, 120.00),
(10, 1006, 101, 1, 120.00),
(11, 1006, 100, 1, 240.00),
(12, 1007, 106, 2, 80.00),
(13, 1007, 107, 2, 50.00),
(14, 1008, 104, 1, 280.00),
(15, 1008, 105, 2, 110.00),
(16, 1009, 103, 2, 90.00),
(17, 1010, 106, 3, 80.00),
(18, 1010, 107, 1, 50.00),
(19, 1011, 100, 1, 240.00),
(20, 1012, 106, 1, 80.00),
(21, 1012, 107, 1, 50.00),
(22, 1013, 102, 1, 180.00),
(23, 1013, 103, 2, 90.00);
