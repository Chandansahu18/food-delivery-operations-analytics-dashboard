-- Database Setup Script

-- Step 1: Create database
-- CREATE DATABASE food_delivery_db;
-- \c food_delivery_db

-- Step 2: Create table
CREATE TABLE orders (
    order_id VARCHAR(50),
    delivery_person_id VARCHAR(50),
    delivery_person_age INTEGER,
    delivery_person_rating FLOAT,
    restaurant_lat FLOAT,
    restaurant_lon FLOAT,
    delivery_lat FLOAT,
    delivery_lon FLOAT,
    order_date DATE,
    time_ordered TIME,
    time_picked TIME,
    weather VARCHAR(50),
    traffic_density VARCHAR(50),
    vehicle_condition INTEGER,
    order_type VARCHAR(50),
    vehicle_type VARCHAR(50),
    multiple_deliveries INTEGER,
    festival VARCHAR(10),
    city VARCHAR(50),
    time_taken_min FLOAT,
    sla_breached BOOLEAN,
    order_hour INTEGER,
    order_day_of_week VARCHAR(20),
    is_weekend BOOLEAN,
    order_month INTEGER,
    distance_km FLOAT,
    delivery_speed VARCHAR(30),
    is_outlier BOOLEAN	
);

-- Step 3: Load data
-- COPY orders FROM 'your/path/to/orders_clean.csv'
-- WITH (FORMAT csv, HEADER true, NULL 'nan');

-- Step 4: Verify
SELECT COUNT(*) AS total_rows FROM orders;