SELECT items.seller_id,
SUM(CASE WHEN orders.order_delivered_customer_date > orders.order_estimated_delivery_date 
THEN 1 ELSE 0 END) AS total_late_orders,
COUNT(orders.order_id) as total_orders,
ROUND(SUM(CASE WHEN orders.order_delivered_customer_date > orders.order_estimated_delivery_date 
THEN 1 ELSE 0 END)/COUNT(orders.order_id),2) AS late_delivery_rate
FROM items JOIN orders 
ON items.order_id = orders.order_id
WHERE orders.order_delivered_customer_date IS NOT NULL
  AND orders.order_estimated_delivery_date IS NOT NULL
GROUP BY items.seller_id
HAVING COUNT(orders.order_id) >= 10
ORDER BY late_delivery_rate DESC
LIMIT 10;