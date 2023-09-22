-- -------------------------------------
-- CSV Lint plug-in v0.4.6.2
-- File: MavenMarket_Stores.csv
-- SQL type: mySQL
-- -------------------------------------
DROP TABLE IF EXISTS MM_Stores;
CREATE TABLE MM_Stores (
	`store_id` integer NOT NULL,
	`region_id` integer,
	`store_type` varchar(255),
	`store_name` varchar(255),
	`store_street_address` varchar(255),
	`store_city` varchar(255),
	`store_state` varchar(255),
	`store_country` varchar(255),
	`store_phone` varchar(255),
	`first_opened_date` date,
	`last_remodel_date` date,
	`total_sqft` integer,
	`grocery_sqft` integer,
	primary key(`store_id`),
	foreign key(`region_id`) REFERENCES MM_Regions(`region_id`)
);

-- -------------------------------------
-- insert records 1 - 24
-- -------------------------------------
insert into MM_Stores (
	`store_id`,
	`region_id`,
	`store_type`,
	`store_name`,
	`store_street_address`,
	`store_city`,
	`store_state`,
	`store_country`,
	`store_phone`,
	`first_opened_date`,
	`last_remodel_date`,
	`total_sqft`,
	`grocery_sqft`
) values
(1, 28, 'Supermarket', 'Store 1', '2853 Bailey Rd', 'Acapulco', 'Guerrero', 'Mexico', '262-555-5124', '1982-01-09 00:00:00', '1990-12-05 00:00:00', 23593, 17475),
(2, 78, 'Small Grocery', 'Store 2', '5203 Catanzaro Way', 'Bellingham', 'WA', 'USA', '605-555-8203', '1970-04-02 00:00:00', '1973-06-04 00:00:00', 28206, 22271),
(3, 76, 'Supermarket', 'Store 3', '1501 Ramsey Circle', 'Bremerton', 'WA', 'USA', '509-555-1596', '1959-06-14 00:00:00', '1967-11-19 00:00:00', 39696, 24390),
(4, 27, 'Gourmet Supermarket', 'Store 4', '433 St George Dr', 'Camacho', 'Zacatecas', 'Mexico', '304-555-1474', '1994-09-27 00:00:00', '1995-12-01 00:00:00', 23759, 16844),
(5, 4, 'Small Grocery', 'Store 5', '1250 Coggins Drive', 'Guadalajara', 'Jalisco', 'Mexico', '801-555-4324', '1978-09-18 00:00:00', '1991-06-29 00:00:00', 24597, 15012),
(6, 47, 'Gourmet Supermarket', 'Store 6', '5495 Mitchell Canyon Road', 'Beverly Hills', 'CA', 'USA', '958-555-5002', '1981-01-03 00:00:00', '1991-03-13 00:00:00', 23688, 15337),
(7, 3, 'Supermarket', 'Store 7', '1077 Wharf Drive', 'Los Angeles', 'CA', 'USA', '477-555-7967', '1971-05-21 00:00:00', '1981-10-20 00:00:00', 23598, 14210),
(8, 26, 'Deluxe Supermarket', 'Store 8', '3173 Buena Vista Ave', 'Merida', 'Yucatan', 'Mexico', '797-555-3417', '1958-09-23 00:00:00', '1967-11-18 00:00:00', 30797, 20141),
(9, 2, 'Mid-Size Grocery', 'Store 9', '1872 El Pintado Road', 'Mexico City', 'DF', 'Mexico', '439-555-3524', '1955-03-18 00:00:00', '1959-06-07 00:00:00', 36509, 22450),
(10, 24, 'Supermarket', 'Store 10', '7894 Rotherham Dr', 'Orizaba', 'Veracruz', 'Mexico', '212-555-4774', '1979-04-13 00:00:00', '1982-01-30 00:00:00', 34791, 26354),
(11, 22, 'Supermarket', 'Store 11', '5371 Holland Circle', 'Portland', 'OR', 'USA', '685-555-8995', '1976-09-17 00:00:00', '1982-05-15 00:00:00', 20319, 16232),
(12, 25, 'Deluxe Supermarket', 'Store 12', '1120 Westchester Pl', 'Hidalgo', 'Zacatecas', 'Mexico', '151-555-1702', '1968-03-25 00:00:00', '1993-12-18 00:00:00', 30584, 21938),
(13, 23, 'Deluxe Supermarket', 'Store 13', '5179 Valley Ave', 'Salem', 'OR', 'USA', '977-555-2724', '1957-04-13 00:00:00', '1997-11-10 00:00:00', 27694, 18670),
(14, 1, 'Small Grocery', 'Store 14', '4365 Indigo Ct', 'San Francisco', 'CA', 'USA', '135-555-4888', '1957-11-24 00:00:00', '1958-01-07 00:00:00', 22478, 15321),
(15, 18, 'Supermarket', 'Store 15', '5006 Highland Drive', 'Seattle', 'WA', 'USA', '893-555-1024', '1969-07-24 00:00:00', '1973-10-19 00:00:00', 21215, 13305),
(16, 87, 'Supermarket', 'Store 16', '5922 La Salle Ct', 'Spokane', 'WA', 'USA', '643-555-3645', '1974-08-23 00:00:00', '1977-07-13 00:00:00', 30268, 22063),
(17, 84, 'Deluxe Supermarket', 'Store 17', '490 Risdon Road', 'Tacoma', 'WA', 'USA', '855-555-5581', '1970-05-30 00:00:00', '1976-06-23 00:00:00', 33858, 22123),
(18, 25, 'Mid-Size Grocery', 'Store 18', '6764 Glen Road', 'Hidalgo', 'Zacatecas', 'Mexico', '528-555-8317', '1969-06-28 00:00:00', '1975-08-30 00:00:00', 38382, 30351),
(19, 5, 'Deluxe Supermarket', 'Store 19', '6644 Sudance Drive', 'Vancouver', 'BC', 'Canada', '862-555-7395', '1977-03-27 00:00:00', '1990-10-25 00:00:00', 23112, 16418),
(20, 6, 'Mid-Size Grocery', 'Store 20', '3706 Marvelle Ln', 'Victoria', 'BC', 'Canada', '897-555-1931', '1980-02-06 00:00:00', '1987-04-09 00:00:00', 34452, 27463),
(21, 106, 'Deluxe Supermarket', 'Store 21', '4093 Steven Circle', 'San Andres', 'DF', 'Mexico', '493-555-4781', '1986-02-07 00:00:00', '1990-04-16 00:00:00', 32717, 25453),
(22, 88, 'Small Grocery', 'Store 22', '9606 Julpum Loop', 'Walla Walla', 'WA', 'USA', '881-555-5117', '1951-01-24 00:00:00', '1969-10-17 00:00:00', 35918, 24837),
(23, 89, 'Mid-Size Grocery', 'Store 23', '3920 Noah Court', 'Yakima', 'WA', 'USA', '170-555-8424', '1977-07-16 00:00:00', '1987-07-24 00:00:00', 29182, 19283),
(24, 7, 'Supermarket', 'Store 24', '2342 Waltham St.', 'San Diego', 'CA', 'USA', '111-555-0303', '1979-05-22 00:00:00', '1986-04-20 00:00:00', 27372, 18293);

