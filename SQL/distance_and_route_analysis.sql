
-- Query 1: Average delivery time and breach rate by 
SELECT city,CASE WHEN distance_km < 2 THEN '0-2 km'
WHEN distance_km < 5 THEN '2-5 km'
WHEN distance_km < 10 THEN '5-10 km'
ELSE '10+ km' END AS distance_bucket,
COUNT(*) AS total_orders,ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct
FROM orders GROUP BY city, distance_bucket ORDER BY city, avg_delivery_time;

-- Query 2: Distance efficiency ratio
SELECT vehicle_type,city,COUNT(*) AS total_orders,
ROUND(AVG(distance_km), 2) AS avg_distance_km,
ROUND(AVG(time_taken_min), 2) AS avg_time_min,
ROUND(AVG(time_taken_min) / NULLIF(AVG(distance_km), 0), 2) AS minutes_per_km
FROM orders GROUP BY vehicle_type, city
HAVING COUNT(*) >= 50 ORDER BY minutes_per_km;

-- Query 3: Long-distance orders — are they always late?
SELECT CASE WHEN distance_km >= 10 THEN 'Long (10+ km)'
ELSE 'Short/Medium (< 10 km)' END AS distance_type,
traffic_density,COUNT(*) AS total_orders,
ROUND(AVG(time_taken_min), 2) AS avg_delivery_time,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct
FROM orders WHERE traffic_density IS NOT NULL
GROUP BY distance_type, traffic_density
HAVING COUNT(*) >= 30 ORDER BY sla_breach_pct DESC;