# maven-market-analysis
 A project offered by Maven Analytics: EDA and dashboard on the sales of a fictional market

# Overview
This is a bonus project included in Maven Analytics' Power BI for Business Intelligence course, it gives some data about the market, like information about the customers, products, regions, dates, stores, returns, and transactions for the years 1997 and 1998.

Timeframe: 1997-1998

All the data prep can be performed in Power Query but for demonstration purposes we'll also do some of it in SQL.

# Resources and Tools Used
- Dataset provided by Maven Analytics.
- CSV Lint (Notepad++ login) to convert the .csv files into .sql scripts and easily import them.
- MySQL for preparing the lookup tables.
- Power Query for the rest of the data prep.
- Power BI for the modeling and visualization of the data.

# Preliminary Data Check
- Verified data types.
- Converted the .csv files to be cleaned in MySQL Workbench into .sql scripts for importing.

# Data Prep and querying in MySQL
We'll import 5 of the 8 csv files into MySQL, particularly the lookup tables:
### Customers:

### Products

### Stores
- Set Region_ID as a foreign key that references the primary key in the 'Regions' table using the following statement:
      
      foreign key ("region_id") REFERENCES MM_region("region_id")

### Calendar

### Regions
- Set Region_ID as primary key.

When we're done, we export the views as .csv files and import them into Power Query where we'll clean the rest of the files.

# Data Prep in Power Query

# Data Modeling in Power BI

# Visualization