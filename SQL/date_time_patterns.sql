
-- Query 1: SLA breach rate by hour of day
SELECT order_hour,COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM orders WHERE order_hour IS NOT NULL
GROUP BY order_hour ORDER BY order_hour;

-- Query 2: SLA breach rate by day of week
SELECT order_day_of_week,COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM orders WHERE order_day_of_week != 'Unknown'
GROUP BY order_day_of_week ORDER BY sla_breach_pct DESC;

-- Query 3: Weekend vs weekday comparison
SELECT CASE WHEN is_weekend THEN 'Weekend' ELSE 'Weekday' END AS day_type,
COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM orders GROUP BY is_weekend ORDER BY is_weekend;

-- Query 4: Peak hour identification
WITH hourly_volume AS (SELECT order_hour,COUNT(*) AS order_count,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
NTILE(4) OVER (ORDER BY COUNT(*)) AS volume_quartile
FROM orders WHERE order_hour IS NOT NULL GROUP BY order_hour)
SELECT order_hour,order_count,sla_breach_pct,
CASE WHEN volume_quartile = 4 THEN 'Peak Hour' WHEN volume_quartile = 3 THEN 'High Volume'
WHEN volume_quartile = 2 THEN 'Medium Volume' ELSE 'Low Volume' END AS volume_category
FROM hourly_volume ORDER BY order_hour;

-- Query 5: Hour x Traffic cross-analysis
SELECT order_hour,traffic_density,COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct
FROM orders WHERE order_hour IS NOT NULL AND traffic_density IS NOT NULL
GROUP BY order_hour, traffic_density
HAVING COUNT(*) >= 30 ORDER BY sla_breach_pct DESC LIMIT 20;