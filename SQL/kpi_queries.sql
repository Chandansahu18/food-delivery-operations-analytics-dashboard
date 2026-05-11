-- KPI 1: Total orders and overall SLA breach rate
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) AS total_breaches,
    ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
    ROUND(AVG(time_taken_min),2) AS avg_delivery_time_min,
    PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY time_taken_min) AS median_delivery_time_min,
    MIN(time_taken_min) AS min_delivery_time,
    MAX(time_taken_min) AS max_delivery_time FROM orders;


-- KPI 2: SLA breach rate by city tier
SELECT
    city,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) AS breached_orders,
    ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
    ROUND(AVG(time_taken_min),2) AS avg_delivery_time FROM orders GROUP BY city ORDER BY sla_breach_pct DESC;

-- KPI 3: SLA breach rate by weather condition
SELECT
    weather,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
    ROUND(AVG(time_taken_min),2) AS avg_delivery_time FROM orders GROUP BY weather ORDER BY sla_breach_pct DESC;

-- KPI 4: SLA breach rate by traffic density
SELECT
    traffic_density,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
    ROUND(AVG(time_taken_min),2) AS avg_delivery_time FROM orders WHERE traffic_density IS NOT NULL GROUP BY traffic_density 
    ORDER BY sla_breach_pct DESC;

-- KPI 5: SLA breach rate by order type (food category)
SELECT
    order_type,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
    ROUND(AVG(time_taken_min),2) AS avg_delivery_time FROM orders GROUP BY order_type ORDER BY sla_breach_pct DESC;

-- KPI 6: SLA breach rate by vehicle type
SELECT
    vehicle_type,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
    ROUND(AVG(time_taken_min),2) AS avg_delivery_time FROM orders GROUP BY vehicle_type ORDER BY avg_delivery_time DESC;

-- KPI 7: Festival vs non-festival delivery performance
SELECT
    festival,
    COUNT(*) AS total_orders,
    ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
    ROUND(AVG(time_taken_min),2) AS avg_delivery_time FROM orders GROUP BY festival ORDER BY festival;