-- These queries report potential issues; they do not modify data.

-- 1. Orders without line items.
SELECT o.order_id
FROM orders o
LEFT JOIN order_items oi ON oi.order_id = o.order_id
WHERE oi.order_item_id IS NULL;

-- 2. Menu items with non-positive prices (the CHECK constraint should prevent these).
SELECT item_id, item_name, price
FROM menu_items
WHERE price <= 0;

-- 3. Recorded sale price differs from current menu price.
-- This may be valid if menu prices changed after an order.
SELECT oi.order_item_id, mi.item_name,
       oi.unit_price AS recorded_sale_price,
       mi.price AS current_menu_price
FROM order_items oi
JOIN menu_items mi ON mi.item_id = oi.item_id
WHERE oi.unit_price <> mi.price;

-- 4. Order counts by status.
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY status;

-- 5. Check references (foreign keys should prevent missing parents).
SELECT o.order_id
FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id
LEFT JOIN restaurants r ON r.restaurant_id = o.restaurant_id
WHERE c.customer_id IS NULL OR r.restaurant_id IS NULL;
