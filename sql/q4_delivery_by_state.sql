select c.customer_state,
AVG(DATEDIFF(o.order_delivered_customer_date,o.order_purchase_timestamp)) as average_days
from customers c join orders o
on c.customer_id = o.customer_id
WHERE order_delivered_customer_date IS NOT NULL
group by c.customer_state
order by average_days desc