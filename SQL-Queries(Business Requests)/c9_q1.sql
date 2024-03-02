WITH retail_cte as 
(
SELECT * from fact_events as E
LEFT JOIN dim_products as P
ON E.product_id = P.product_code
)
SELECT distinct(product_name), category, base_price 
from retail_cte 
WHERE base_price >=500 AND promo_type ='BOGOF'