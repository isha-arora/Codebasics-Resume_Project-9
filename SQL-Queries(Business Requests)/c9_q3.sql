WITH retail_cte as 
(
SELECT E.campaign_id, C.campaign_name, base_price, quantity_Sold_before_promo, 
quantity_Sold_after_promo 
FROM fact_events AS E
LEFT JOIN dim_campaigns AS C
ON E.campaign_id = C.campaign_id
)

SELECT campaign_name,
concat(ROUND(SUM(base_price * quantity_sold_before_promo)/1000000), ' Million') AS revenue_before_promotions,
concat(ROUND(SUM(base_price * quantity_sold_after_promo) / 1000000),' Million') AS revenue_after_promotions
FROM retail_cte
GROUP BY campaign_id
ORDER BY campaign_name