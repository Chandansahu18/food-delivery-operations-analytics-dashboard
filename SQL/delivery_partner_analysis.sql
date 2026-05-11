
-- Query 1: Full delivery partner scorecard
SELECT delivery_person_id,city,delivery_person_age,
ROUND(AVG(delivery_person_rating), 2) AS avg_rating,COUNT(*) AS total_orders,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
ROUND(AVG(distance_km), 2) AS avg_distance_km,
MODE() WITHIN GROUP (ORDER BY vehicle_type) AS most_used_vehicle
FROM orders GROUP BY delivery_person_id, city, delivery_person_age
HAVING COUNT(*) >= 20 ORDER BY sla_breach_pct ASC LIMIT 25;

-- Query 2: Partner performance tier classification
WITH partner_stats AS (SELECT delivery_person_id,ROUND(AVG(time_taken_min), 2) AS avg_time,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS breach_pct,
COUNT(*) AS total_orders FROM orders
GROUP BY delivery_person_id HAVING COUNT(*) >= 20)
SELECT delivery_person_id,avg_time,breach_pct,total_orders,
CASE WHEN breach_pct <= 10 THEN 'Elite' WHEN breach_pct <= 25 THEN 'Good'
WHEN breach_pct <= 40 THEN 'Average' ELSE 'Needs Improvement' END AS performance_tier
FROM partner_stats ORDER BY breach_pct;

-- Query 3: Impact of rating on delivery time
SELECT CASE WHEN delivery_person_rating >= 4.5 THEN 'Top rated (4.5+)'
WHEN delivery_person_rating >= 4.0 THEN 'Good (4.0-4.5)'
WHEN delivery_person_rating >= 3.5 THEN 'Average (3.5-4.0)'
ELSE 'Low (<3.5)' END AS rating_group,
COUNT(*) AS total_orders,ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct
FROM orders GROUP BY rating_group ORDER BY avg_delivery_time;