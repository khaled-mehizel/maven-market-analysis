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
 - Using **CONCAT()**, we merge the first and last names of the customers in a new calculated column, and drop the original columns (this can only be done later as the new column is dependent on the old ones, we'll get back to it in the PQ part).
 - Using **YEAR()** in a calculated column, we extract the birth year from the birthdate.
      - We can also just switch the datatype of the birthdate column to *YEAR*, but we might need it.
      - The calculated column is saved in the *YEAR* datatype because *INT* would be way too overkill for such a small range.
 - Add a conditional column using a **CASE** statement, to show whether the customer has children or not.

### Products
 - We added a 10% discount price calculated column using the previous technique, by simply multiplying the values by 0.9.
      - New column will have the numeric datatype with 2 decimal places.
 - We clean the "low_fat" and "recyclable" from null values and replace them with zeroes, better to be safe than sorry.

### Stores
- Set Region_ID as a foreign key that references the primary key in the 'Regions' table using the following statement:
      
      foreign key ("region_id") REFERENCES MM_region("region_id")
- Created a full_address calculated column by concatenating the address columns, this time using **CONCAT_WS()** because it's there, and it's very neat! We'll specify a space as the seperator, and it'll add it in automatically.
- We extract the area code from the store's phone number using ~~LEFT() and CHARINDEX()~~ **SUBSTRING_INDEX()**
  - I don't know how US area codes work, so I must assume that the area codes aren't necessarily only 3 digits.
  - We add a -1 inside the LEFT function so that it doesn't extract the hyphen as well.
      UPDATE: MySQL hates CHARINDEX now, so we'll **SUBSTRING_INDEX()** which is a lot more intuitive and like the Excel equivalent.



### Calendar
 - We separate the dates into the following calculated columns:
      - Start of Week (starting Sunday): We'll do this in PQ because I wasn't able to find an equivalent function.
      - Name of Day: **DAYNAME()** function.
      - Start of Month: See above.
      - Name of Month: **MONTHNAME()** function.
      - Quarter of Year: **QUARTER()** function.
      - Year: **YEAR()** function.
### Regions
- Set Region_ID as primary key.

When we're done, we export the views as .csv files and import them into Power Query where we'll clean the rest of the files.

# Data Prep in Power Query

### Calendar
- Added the start_of_week and start_of_month calculated columns.

### Returns
- Promoted the headers and verified data types.

### Transactions
- Imported both the 1997 and 1998 and combined them using folder import. (Could've used **UNION** as well)
- Double-checked the dates.

# Data Modeling in Power BI
- We import the lookup tables, and notice that the Stores and Regions tables are already connected in a one-to-many relationship to the primary and foreign keys we set earlier.
- We added the transactions table and combined them, and notice that they're full of foreign keys, so we create relationships between and the rest of the lookup tables.
- We added the returns table 

- We make certain of the following:
  - All the relationships are one-to-many.
  - All the filters are one-way.
  - The data flows "downstream", we put the lookup tables above.
  - The data tables are connected via shared lookup tables rather than directly to each other.

- We verify the data categories (especially the geographical ones) in the data view.
# Visualization