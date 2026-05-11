
-- Query 1: Full ops summary — one query, all dimensions
SELECT city,weather,traffic_density,COUNT(*) AS total_orders,
ROUND(AVG(time_taken_min), 1) AS avg_delivery_min,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),1) AS breach_pct,
ROUND(AVG(distance_km), 1) AS avg_distance_km,
ROUND(AVG(delivery_person_rating), 2) AS avg_partner_rating
FROM orders WHERE traffic_density IS NOT NULL
GROUP BY city, weather, traffic_density
HAVING COUNT(*) >= 100 ORDER BY breach_pct DESC LIMIT 20;

-- Query 2: The single most important finding
SELECT 'Worst condition combination' AS insight_type,city,weather,traffic_density,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),1) AS sla_breach_pct,
COUNT(*) AS orders_affected FROM orders WHERE traffic_density IS NOT NULL
GROUP BY city, weather, traffic_density
HAVING COUNT(*) >= 100 ORDER BY sla_breach_pct DESC LIMIT 1;