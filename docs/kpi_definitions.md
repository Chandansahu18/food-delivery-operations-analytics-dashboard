# KPI Definitions

| KPI | Definition | Formula | Target |
|-----|-----------|---------|--------|
| Avg Delivery Time | Mean time from order placed to delivered | sum(delivery_time) / count(orders) | < 30 min |
| SLA Breach Rate | % of orders exceeding 30-min delivery window | breached_orders / total_orders × 100 | < 10% |
| Cancellation Rate | % of placed orders cancelled before delivery | cancelled / total × 100 | < 5% |
| Repeat Order Rate (30d) | % of customers who order again within 30 days | repeat_customers / total_customers × 100 | > 40% |
| Restaurant On-Time Rate | % of orders where restaurant prepared within promised time | on_time_prep / total_orders × 100 | > 85% |