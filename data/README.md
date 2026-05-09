## How to get the data

This project uses the Food Delivery Dataset from Kaggle.

1. Go to: https://www.kaggle.com/datasets/saurabhbadole/zomato-delivery-operations-analytics-dataset
2. Click Download
3. Extract the ZIP file
4. Place `delivery-dataset.csv` inside `data/raw/`

## Why raw data is not committed to GitHub

Raw data files are excluded via .gitignore because:
- CSV files can be large and slow down the repo
- The source dataset is freely available on Kaggle
- Committing data directly can cause issues with sensitive information

## File schema

After download, `data/raw/` should contain:
- `delivery-dataset.csv` — 20 columns, ~45,000 rows, one row per order