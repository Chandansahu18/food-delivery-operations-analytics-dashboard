## Executive Summary

Analysis of 43,853 food delivery orders reveals that nearly 1 in 3 orders (29.83%) 
breach the 30-minute SLA. Breach rates spike to 100% on festival days, climb above 
50% in high-traffic conditions, and peak during the 8–10 PM dinner window. 
Semi-urban cities show structurally higher breach rates than metro areas. 
Targeted interventions in surge staffing, festival preparedness, and semi-urban 
routing can materially reduce breach rates.

---

## Key Findings

- **29.83%** of all orders breach the 30-minute SLA — roughly 13,081 orders affected
- **Festival days** show a 100% SLA breach rate across 857 orders — zero exceptions
- **Semi-urban cities** have the highest breach rate among all city tiers
- **Cloudy and Foggy weather** conditions drive breach rates of 43.9% and 43.8% respectively
- **8–10 PM** is the peak breach window, coinciding with dinner demand surge

---

## SLA Breach Analysis

### By City
Semi-urban zones show the highest structural breach rates. This likely reflects 
wider delivery radius and fewer available delivery partners relative to order volume, 
compared to metropolitan areas with denser partner supply.

### By Traffic
High-traffic and Jam conditions push breach rates above 50.6%. This is the single 
largest controllable driver of SLA failure after festivals.

### By Weather
Cloudy (43.9%) and Foggy (43.8%) conditions produce near-identical elevated breach 
rates. Both reduce delivery speed through reduced visibility and rider caution.

### By Time of Day
The 8–10 PM window is the highest-risk delivery period. Demand volume peaks while 
available partner capacity does not scale proportionally.

### Festival Impact
857 orders placed on festival days show a 100% breach rate — no order was delivered 
within SLA. This indicates a complete operational breakdown during festival periods, 
not just degraded performance.

---

## Operational Recommendations

**1. Festival Surge Protocol**
Festival days must be treated as a separate operational mode. Recommendations:
pre-position additional delivery partners 2 hours before peak, enforce dynamic 
pricing to suppress low-priority orders, and set customer SLA expectations to 
45 minutes rather than 30.

**2. Semi-Urban Capacity Planning**
Semi-urban zones need dedicated partner allocation models. Current partner density 
is insufficient for order volume. Recommendation: geo-cluster semi-urban orders 
and assign dedicated partner pools rather than sharing with urban supply.

**3. Evening Demand Surge Staffing**
The 8–10 PM window requires mandatory surge staffing. Recommendation: incentivize 
partner availability between 7–10 PM through guaranteed minimum earnings, reducing 
the gap between order demand and fulfillment capacity.

---

## Data Limitations

- No customer_id field available for customer retention or repeat-order analysis.
- Dataset does not include real-time GPS tracking, live weather APIs, or restaurant preparation time metrics.
- Dataset source is from Kaggle. It can not be used for production operational decisions without validation against real delivery data.