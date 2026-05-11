-- Query 1: Delivery partner cohort — first active month
WITH partner_first_month AS (SELECT delivery_person_id,MIN(order_month) AS cohort_month FROM orders
WHERE order_month > 0 GROUP BY delivery_person_id),
partner_monthly AS (SELECT o.delivery_person_id,pfm.cohort_month,o.order_month AS active_month,
o.order_month - pfm.cohort_month AS months_since_joining,o.sla_breached FROM orders o
JOIN partner_first_month pfm ON o.delivery_person_id = pfm.delivery_person_id WHERE o.order_month > 0)
SELECT cohort_month,months_since_joining,COUNT(DISTINCT delivery_person_id) AS active_partners,
COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct
FROM partner_monthly
GROUP BY cohort_month, months_since_joining
ORDER BY cohort_month, months_since_joining;

-- Query 2: Do delivery partners improve over time?
WITH partner_first_month AS (SELECT delivery_person_id,MIN(order_month) AS cohort_month FROM orders
WHERE order_month > 0 GROUP BY delivery_person_id),
partner_experience AS (SELECT o.delivery_person_id,
CASE WHEN o.order_month = pfm.cohort_month THEN 'First Month'
WHEN o.order_month = pfm.cohort_month + 1 THEN 'Month 2'
WHEN o.order_month >= pfm.cohort_month + 2 THEN 'Month 3+' END AS experience_stage,
o.sla_breached FROM orders o
JOIN partner_first_month pfm ON o.delivery_person_id = pfm.delivery_person_id WHERE o.order_month > 0)
SELECT experience_stage,COUNT(*) AS total_orders,
ROUND(100.0 * SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END) / COUNT(*),2) AS sla_breach_pct,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_total_orders
FROM partner_experience WHERE experience_stage IS NOT NULL
GROUP BY experience_stage
ORDER BY CASE experience_stage WHEN 'First Month' THEN 1 WHEN 'Month 2' THEN 2 WHEN 'Month 3+' THEN 3 END;