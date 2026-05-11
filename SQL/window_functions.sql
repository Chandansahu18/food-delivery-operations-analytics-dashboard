-- Query 1: Rank delivery partners by avg delivery time
SELECT delivery_person_id,city,COUNT(*) AS total_orders,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
ROUND(AVG(delivery_person_rating),2) AS avg_rating,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
RANK() OVER (ORDER BY AVG(time_taken_min) ASC) AS speed_rank
FROM orders GROUP BY delivery_person_id, city
HAVING COUNT(*) >= 30 ORDER BY speed_rank LIMIT 20;

-- Query 2: Top 3 worst-performing delivery partners 
WITH partner_stats AS (SELECT delivery_person_id,city,COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
ROUND(AVG(time_taken_min),2) AS avg_delivery_time FROM orders GROUP BY delivery_person_id, city HAVING COUNT(*) >= 20), 
ranked AS (SELECT *,DENSE_RANK() OVER (PARTITION BY city ORDER BY sla_breach_pct DESC) AS rank_within_city FROM partner_stats)
SELECT * FROM ranked WHERE rank_within_city <= 3 ORDER BY city, rank_within_city;

-- Query 3: Delivery time percentiles by city
SELECT city,COUNT(*) AS total_orders,ROUND(AVG(time_taken_min),1) AS avg_time,
PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY time_taken_min) AS p25_time,
PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY time_taken_min) AS p50_median,
PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY time_taken_min) AS p75_time,
PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY time_taken_min) AS p90_time,
MAX(time_taken_min) AS max_time 
FROM orders
GROUP BY city
ORDER BY avg_time DESC;

-- Query 4: Running cumulative order count by order_hour
WITH hourly_orders AS (SELECT order_hour,COUNT(*) AS orders_in_hour FROM orders WHERE order_hour IS NOT NULL GROUP BY order_hour)
SELECT order_hour,orders_in_hour,SUM(orders_in_hour) OVER (ORDER BY order_hour ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
AS cumulative_orders,
ROUND(100.0 * orders_in_hour / SUM(orders_in_hour) OVER (),2) AS pct_of_daily_volume FROM hourly_orders ORDER BY order_hour;

-- Query 5: LAG — compare SLA breach rate month over month
WITH monthly_stats AS (SELECT order_month,COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct FROM orders 
WHERE order_month > 0 GROUP BY order_month) SELECT order_month,total_orders,sla_breach_pct,LAG(sla_breach_pct) 
OVER (ORDER BY order_month) AS prev_month_breach_pct,
ROUND(sla_breach_pct - LAG(sla_breach_pct) OVER (ORDER BY order_month),2) AS month_over_month_change
FROM monthly_stats
ORDER BY order_month;