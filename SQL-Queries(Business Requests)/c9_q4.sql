WITH promotion_cte AS 
(
    SELECT category, 
    SUM(quantity_sold_before_promo) AS total_sold_before_diwali,
	SUM(quantity_sold_after_promo) AS total_sold_after_diwali
    FROM fact_events E 
    LEFT JOIN dim_products P
    ON E.product_id = product_code
    WHERE campaign_id = 'CAMP_DIW_01'
    GROUP BY category
)
SELECT pc.category,
    CONCAT((ROUND(SUM(pc.total_sold_after_diwali) - SUM(pc.total_sold_before_diwali)) / SUM(pc.total_sold_before_diwali) * 100),' %') AS ISU_percent,
    RANK() OVER (ORDER BY (SUM(pc.total_sold_after_diwali) - SUM(pc.total_sold_before_diwali)) / SUM(pc.total_sold_before_diwali) DESC) AS rank_order
FROM promotion_cte pc GROUP BY pc.category;