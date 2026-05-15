select  p.product_category_name,
SUM(CASE WHEN r.review_score <= 2 THEN 1 ELSE 0 END) as bad_reviews,
count(*) as reviews,
ROUND(SUM(CASE WHEN r.review_score <= 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS worstreviews_perc
from reviews r 
join items i on r.order_id = i.order_id 
join products p on p.product_id = i.product_id
group by p.product_category_name
HAVING count(*) > 100
order by worstreviews_perc desc