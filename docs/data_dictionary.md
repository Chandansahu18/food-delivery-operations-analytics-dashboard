## Source
Kaggle: Zomato Delivery Operations Analytics Dataset by Saurabh Badole  
URL: https://www.kaggle.com/datasets/saurabhbadole/zomato-delivery-operations-analytics-dataset
Downloaded: 09/05/2026  
Raw file location: data/raw/zomato-delivery-dataset.csv  

## Dataset Overview
- Total rows: 45585 
- Total columns: 20  
- Date range: 03/01/2026 to 03/12/2026  
- Grain: One row = one food delivery order  

## Column Reference

| Column | Type | Description | Sample Values | Nulls? |
|--------|------|-------------|---------------|--------|
| ID | String | Unique order identifier | 0x13ca | No |
| Delivery_person_ID | String | Unique delivery partner ID | MYSRES01DEL01 | No |
| Delivery_person_Age | Integer | Age of delivery partner | 25 | Check |
| Delivery_person_Ratings | Float | Partner rating out of 5 | 4.2 | Check |
| Restaurant_latitude | Float | GPS lat of restaurant | 12.311072 | No |
| Restaurant_longitude | Float | GPS lon of restaurant | 76.654878 | No |
| Delivery_location_latitude | Float | GPS lat of customer | 12.351072 | No |
| Delivery_location_longitude | Float | GPS lon of customer | 76.694878 | No |
| Order_Date | String | Date of order | 01-03-2022 | No |
| Time_Ordered | String | Time order was placed | 14:55 | Check |
| Time_Order_picked | String | Time order was picked up | 15:10 | Check |
| Weather_conditions | String | Weather at delivery time | Sunny, Stormy | Check |
| Road_traffic_density | String | Traffic level | Low, Medium, High, Jam | Check |
| Vehicle_condition | Integer | Vehicle condition rating | 0, 1, 2 | No |
| Type_of_order | String | Food category ordered | Snack, Meal, Drinks, Buffet | No |
| Type_of_vehicle | String | Vehicle used for delivery | motorcycle, scooter | No |
| multiple_deliveries | Float | Simultaneous deliveries | 0, 1, 2, 3 | Check |
| Festival | String | Festival day or not | Yes, No | Check |
| City | String | City tier | Metropolitian, Urban, Semi-Urban | No |
| Time_taken(min) | Integer | Actual delivery time in minutes | 24, 38 | No |

## Key Column for Analysis
`Time_taken(min)` is our primary target variable.  
SLA threshold: 30 minutes.  
Any order where Time_taken(min) > 30 will be flagged as SLA_breached = True.
