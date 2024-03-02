WITH retail_cte as 
(
SELECT * FROM fact_events AS E
LEFT JOIN dim_stores AS S
ON E.store_code = S.store_id
)
SELECT city, COUNT(DISTINCT(store_code)) AS total_stores
FROM retail_cte GROUP BY city
ORDER BY total_stores DESC
