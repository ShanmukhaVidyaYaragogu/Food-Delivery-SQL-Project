-- Business analysis queries. Run after loading sample data.

-- 1. Orders with customer and restaurant names.
SELECT o.order_id, c.customer_name, r.restaurant_name, o.order_date, o.status
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN restaurants r ON r.restaurant_id = o.restaurant_id
ORDER BY o.order_date;

-- 2. Total food revenue from delivered orders (delivery fees excluded).
SELECT SUM(oi.quantity * oi.unit_price) AS delivered_food_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'Delivered';

-- 3. Revenue by restaurant.
SELECT r.restaurant_name,
       SUM(oi.quantity * oi.unit_price) AS food_revenue
FROM orders o
JOIN restaurants r ON r.restaurant_id = o.restaurant_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY food_revenue DESC;

-- 4. Best-selling menu items.
SELECT mi.item_id, mi.item_name,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * oi.unit_price) AS item_revenue
FROM order_items oi
JOIN menu_items mi ON mi.item_id = oi.item_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY mi.item_id, mi.item_name
ORDER BY units_sold DESC, item_revenue DESC;

-- 5. Customers with more than one delivered order.
SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT o.order_id) AS delivered_order_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY delivered_order_count DESC;

-- 6. Average food order value; first calculate one subtotal per order.
WITH order_totals AS (
    SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS food_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY o.order_id
)
SELECT ROUND(AVG(food_total), 2) AS average_food_order_value
FROM order_totals;

-- 7. Count orders by status.
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC, status;

-- 8. Customers who have never placed an order.
SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;

-- 9. Monthly delivered food revenue (PostgreSQL syntax).
SELECT DATE_TRUNC('month', o.order_date)::date AS order_month,
       SUM(oi.quantity * oi.unit_price) AS food_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY DATE_TRUNC('month', o.order_date)::date
ORDER BY order_month;

-- 10. Rank restaurants by delivered food revenue.
WITH restaurant_sales AS (
    SELECT r.restaurant_id, r.restaurant_name,
           SUM(oi.quantity * oi.unit_price) AS food_revenue
    FROM restaurants r
    JOIN orders o ON o.restaurant_id = r.restaurant_id
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY r.restaurant_id, r.restaurant_name
)
SELECT restaurant_name, food_revenue,
       DENSE_RANK() OVER (ORDER BY food_revenue DESC) AS revenue_rank
FROM restaurant_sales
ORDER BY revenue_rank, restaurant_name;

-- 11. Segment delivered orders by subtotal.
WITH order_totals AS (
    SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS food_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY o.order_id
)
SELECT order_id, food_total,
       CASE WHEN food_total >= 500 THEN 'High value'
            WHEN food_total >= 250 THEN 'Medium value'
            ELSE 'Low value' END AS order_segment
FROM order_totals
ORDER BY food_total DESC;

-- 12. Cancellation rate by restaurant; denominator is all orders.
SELECT r.restaurant_name,
       COUNT(*) AS total_orders,
       COUNT(*) FILTER (WHERE o.status = 'Cancelled') AS cancelled_orders,
       ROUND(100.0 * COUNT(*) FILTER (WHERE o.status = 'Cancelled')
             / NULLIF(COUNT(*), 0), 2) AS cancellation_rate_percent
FROM restaurants r
JOIN orders o ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY cancellation_rate_percent DESC, r.restaurant_name;
