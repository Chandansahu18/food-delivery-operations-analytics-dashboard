## Project Overview
Power BI dashboard analyzing ~44K food delivery orders to identify operational inefficiencies, SLA breach rates, delivery efficiency trends, and business optimization opportunities.

## Tool
Microsoft Power BI Desktop → Published to Power BI Service

## Pages

| Page | What it shows |
|------|--------------|
| Executive Summary | 4 KPI cards, breach by city, speed distribution, slicers |
| Delivery Performance | Weather, traffic, hourly trend, vehicle type analysis |
| Partner Performance | Partner scorecard table, age group, simultaneous delivery impact |
| Time & Location | Day of week, weekend vs weekday, distance, hour × traffic |
| Key Findings | Business recommendations for non-technical stakeholders |

## DAX Measures Created

| Measure | Formula Logic |
|---------|--------------|
| Total Orders | COUNTROWS |
| SLA Breach Rate | Breached orders / Total orders |
| Avg Delivery Time | AVERAGE of time_taken_min |
| Total Breaches | COUNTROWS with TRUE filter |
| Avg Partner Rating | AVERAGE of delivery_person_rating |
| On Time Rate | On-time orders / Total orders |

## Data Source
CSV: orders_clean.csv (~44,000 rows, 28 columns)
Loaded via Power BI Desktop → Get Data → Text/CSV