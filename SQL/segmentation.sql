
-- Query 1: Delivery speed category distribution
SELECT delivery_speed,COUNT(*) AS total_orders,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_of_orders,
ROUND(AVG(time_taken_min), 2) AS avg_time_in_category
FROM orders GROUP BY delivery_speed
ORDER BY CASE delivery_speed WHEN 'Fast' THEN 1 WHEN 'On-time' THEN 2 WHEN 'Late' THEN 3 WHEN 'Very Late' THEN 4 END;

-- Query 2: High-risk combination segments
SELECT traffic_density,weather,festival,COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time
FROM orders WHERE traffic_density IS NOT NULL
GROUP BY traffic_density, weather, festival
HAVING COUNT(*) >= 50 ORDER BY sla_breach_pct DESC LIMIT 15;

-- Query 3: Delivery partner age group segmentation
SELECT CASE WHEN delivery_person_age < 25 THEN 'Under 25'
WHEN delivery_person_age BETWEEN 25 AND 30 THEN '25-30'
WHEN delivery_person_age BETWEEN 31 AND 35 THEN '31-35'
ELSE 'Above 35' END AS age_group,
COUNT(*) AS total_orders,ROUND(AVG(delivery_person_rating), 2) AS avg_rating,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct
FROM orders GROUP BY age_group ORDER BY avg_delivery_time;

-- Query 4: Multiple deliveries impact on SLA
SELECT multiple_deliveries,COUNT(*) AS total_orders,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct
FROM orders GROUP BY multiple_deliveries ORDER BY multiple_deliveries;

-- Query 5: Distance bucket segmentation
SELECT CASE WHEN distance_km < 2 THEN '0-2 km'
WHEN distance_km < 5 THEN '2-5 km'
WHEN distance_km < 10 THEN '5-10 km'
ELSE '10+ km' END AS distance_bucket,
COUNT(*) AS total_orders,ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct
FROM orders GROUP BY distance_bucket ORDER BY avg_delivery_time;