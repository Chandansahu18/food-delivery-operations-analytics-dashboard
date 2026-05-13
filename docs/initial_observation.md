
Date reviewed: 09/05/2026

## What I noticed visually in Excel

- Dataset has approximately 45585 rows of order data
- Order_Date appears to be in MM-DD-YYYY format — need to parse carefully
- Some rows appear to have NaN values in Delivery_person_Age and Time_Ordered — need to clean for better analysis
- City column has 3 values: Metropolitian, Urban, Semi-Urban — note the 
  spelling "Metropolitian" is a typo in the data, the spelling will be retained intentionally to maintain consistency across preprocessing and Power BI visuals.
- multiple_deliveries column has some NaN values visible
- Weather_conditions has 6 categories: Sunny, Stormy, Sandstorms, 
  Cloudy, Fog, Windy

## Questions I have about the data

- Does Time_taken(min) include the pickup wait time or only travel time?
- What does Vehicle_condition = 0 mean — is 0 bad or good?
- Are all cities Indian cities? Yes, based on lat/lon values

## What I'm confident about

- Time_taken(min) is our main metric — it's clean and numeric
- SLA threshold of 30 minutes is a fair benchmark for food delivery
- Dataset is large enough for meaningful analysis