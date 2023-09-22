-- DROP DATABASE IF EXISTS MavenMarket;
-- CREATE DATABASE MavenMarket;
-- USE MavenMarket;

-- ------------------- CUSTOMERS ----------------------------------------
-- 1- Merging the first and last names of the customer-----------
SELECT first_name, last_name, CONCAT(first_name, " ", last_name) AS full_name
FROM MM_Customers;

-- adding the dull_ame column into the table
ALTER TABLE MM_Customers
ADD COLUMN full_name VARCHAR(255) AS (CONCAT(first_name, " ",last_name)) AFTER last_name;

SELECT full_name
FROM MM_Customers;

-- 2- Extracting the birth year from the customer's birthday ---------
SELECT birthdate, YEAR(birthdate) AS birth_year
FROM MM_Customers;

-- adding the birth_year column
ALTER TABLE MM_Customers
ADD COLUMN birth_year YEAR AS (YEAR(birthdate)) AFTER birthdate;

SELECT birth_year
FROM MM_Customers;
-- 3- Adding the "has children?" column--------------------------------
SELECT total_children, 
	CASE
		WHEN total_children < 1 THEN "N"
        ELSE "Y"
	END AS has_children
FROM MM_Customers;

-- adding the column
ALTER TABLE MM_Customers
ADD COLUMN has_children VARCHAR(1) AS (CASE
								WHEN  total_children < 1 THEN "N"
								ELSE "Y"
							END) AFTER total_children;
SELECT has_children
FROM MM_Customers;
                            
-- ------------------------------------------------------------------------------------------------------

-- ----------------------- PRODUCTS ---------------------------                            
-- 1- Adding the 10% discounted price column---------
SELECT product_retail_price, ROUND((product_retail_price * 0.9),2) AS discount_retail_price
FROM MM_Products;

ALTER TABLE MM_Products
ADD COLUMN discount_retail_price DECIMAL(8,2) AS (product_retail_price * 0.9) AFTER product_retail_price;

SELECT discount_retail_price
FROM MM_Products;

-- 2- Replacing null values with zeroes
SELECT low_fat, recyclable
FROM MM_Products
WHERE low_fat IS NULL OR recyclable IS NULL;
-- that's a lot of null values

UPDATE MM_Products
SET low_fat = 0
WHERE low_fat IS NULL;

UPDATE MM_Products
SET recyclable = 0
WHERE recyclable IS NULL;

SELECT low_fat, recyclable
FROM MM_Products;
-- Rerunning the SELECT query, we find that we don't have any null values anymore!

----------------------------------------------------------------------------------------------------------
-- ---------------------- STORES --------------------------------------------
-- 1- Creating the full address column
SELECT store_street_address, store_city, store_state, store_country
FROM MM_Stores;

-- We'll use a CONCAT_WS() to automatically insert a seperator between each item
ALTER TABLE MM_Stores
ADD COLUMN full_address VARCHAR(255) AS (CONCAT_WS(", ", store_street_address, store_city, store_state, store_country)) AFTER store_country;

SELECT full_address
FROM MM_Stores;

-- 2- Extract the area code
SELECT store_phone
FROM MM_Stores;

ALTER TABLE MM_Stores
ADD COLUMN area_code INT AS (SUBSTRING_INDEX(store_phone, "-", 1)) AFTER store_phone;

SELECT area_code
FROM MM_Stores;
-- ---------------------------------------------------------------------------------------------
-- ------------------------- CALENDAR ----------------------------------------------------------
SELECT date
FROM MM_Calendar;

-- 1 - Adding the day_name column
ALTER TABLE MM_Calendar
ADD COLUMN day_name VARCHAR(15) AS (DAYNAME(date));

-- 2 - Adding the month_name column
ALTER TABLE MM_Calendar
ADD COLUMN month_name VARCHAR(15) AS (MONTHNAME(date));

-- 3 - Adding the quarter column
ALTER TABLE MM_Calendar
ADD COLUMN quarter INT AS (QUARTER(date));

-- 4 - Adding the year column
ALTER TABLE MM_Calendar
ADD COLUMN year INT AS (YEAR(date));

SELECT day_name, month_name, quarter, year
FROM MM_Calendar

