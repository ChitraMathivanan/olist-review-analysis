WITH late_order AS(
SELECT order_id,
CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END AS is_late
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
),
low_reviewscores AS(
SELECT order_id,review_score,
CASE WHEN review_score <= 2 THEN 1 ELSE 0 END AS is_low_score
FROM reviews
)
SELECT l.is_late,
ROUND(avg(r.review_score),2) AS avg_review_score,
COUNT(*) AS total_orders,
SUM(r.is_low_score) AS low_score_count,
ROUND(SUM(r.is_low_score) / COUNT(*) * 100, 1) AS low_score_pct
from late_order l
JOIN low_reviewscores r on l.order_id = r.order_id
GROUP BY l.is_late
ORDER BY l.is_late;