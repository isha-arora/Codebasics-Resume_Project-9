WITH promo_cte as (
SELECT * from fact_events as E
LEFT JOIN dim_products as P
ON E.product_id = P.product_code
)

SELECT product_name, category,
AVG((quantity_sold_after_promo * base_price - quantity_sold_before_promo * base_price) / (quantity_sold_before_promo * base_price) * 100) AS IR_percent
FROM promo_cte
GROUP BY product_name, category
ORDER BY IR_percent DESC
LIMIT 5;
