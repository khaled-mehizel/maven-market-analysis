# maven-market-analysis
 A project offered by Maven Analytics: EDA and dashboard on the sales of a fictional market using MySQL, Power BI, and a whole lotta DAX.


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
We'll import 5 of the 8 CSV files into MySQL, particularly the lookup tables:
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
- Created a full_address calculated column by concatenating the address columns, this time using **CONCAT_WS()** because it's there, and it's very neat! We'll specify a space as the separator, and it'll add it in automatically.
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

# Adding the DAX measures and calculated columns
- We already added a bunch of these in SQL, so we should flex our DAX muscles a bit!
### Calendar

- Added a column that returns "Y" or "N" based on whether the date is a weekend or not, using **IF()**, a **SWITCH()** will work as well, but we'll leave it for later.
- Added a column that returns the date of the end of each month, using the intuitive **EOMONTH()**.
### Customers
- Added a column that returns the customer's age via **DATEDIFF()** and **TODAY()**.
     - Since we're using the TODAY function some customers will be really old.
- Added a column that returns the country code, via a **LEFT()** function.
### Products
- Segregated the columns to three price categories via a **SWITCH()** function, nested IFs are not elegant.
### Transactions
Created the following measures:
- "Quantity Sold" measure using **SUM()**
- "Total Sales" measure using **COUNTROWS()**
- "Weekend Transactions" using **CALCULATE()** and the "is_weekend" column as filter.
- "% Weekend Transactions"
- "Total Revenue" using **SUMX()**, by multiplying the transaction quantity by number of transactions, we need it to iterate by each row (day), **RELATED()** is to use columns from different tables
- "Total Cost" using **SUMX()** and **RELATED()**, by multiplying the transaction quantity by product costs.
- "Total Profit" by simply subtracting the total cost from the total revenue, no need for an iterator.
- "Profit Margin" by dividing the profit by the revenue
- "YTD Revenue" using **DATESYTD()** nested in the ever-amazing **CALCULATE()**.
- "60-day Revenue" using **DATESINPERIOD()** and **MAX()** (to select the latest date) also nested in a **CALCULATE()**. It's a running total over a selected 60 days, like how you would do with a parameter on Tableau except I chose it instead of the user, I did this in my [London Bike Share project](https://github.com/khaled-mehizel/bike-share-lndn).
- "Last Month Revenue" this for our Revenue Target KPI, created using **DATEADD()** nested in the **CALCULATE()**, my beloved. Added similar measures for losses, profit, and sales for each KPI.
- "Revenue Target": The baseline is set as 105% of Last Month's Revenue.

### Returns
Created the following measures:
- "Quantity Returned" measure using **SUM()**
- "Total Returns" measure using **COUNTROWS()**
- "Return Rate" by dividing total returns by total sales
- "Total Loss due to Returns" using **SUMX()**, by multiplying the return quantity by product costs.
- "YTD Losses","Last Month Losses" calculated the same way as above

# Visualization
- Added the Maven Market logo to the top left.
- Added a matrix containing the product brand, total sales, total profit, and its return rate. Each conditionally and visually formatted.
- Added a few KPIs:
     - Current Month's sales vs last month's.
     - Current Month's revenue vs last month's.
     - Current Month's returns vs last month's.
     - Current Month's losses (due to returns) vs last month's.
- Added an area chart to display the trends in profit over the timeline, which can be adjusted using a zoom slider or the slicer at the top.
- Added a gauge to compare current month's revenue against the target.

# Insights
- The USA and Mexico are Maven's biggest customers, dwarfing the Canadian portion.
- Compared to last month, Sales and returns have increased and Losses have decreased, however, revenue hasn't reached the target yet.
- In terms of sales, Hermanos brand enjoys the highest number of sales, but as the profit margin goes, ADJ rules supreme at 68% despite having the second-highest return rate.
- In terms of return rate, King, ADJ, and Dollars are the highest, but unlike ADJ, the profit margin for these brands is mediocre.
- We notice a very sharp increase in revenue in early 1998, going well over double the amounts achieved in October of the previous year (42k to 98k) and after a steady spell spanning a few months, it seems to only be going up from there!
- Holiday season and the months leading up to it also enjoy a large increase in revenue.

# Recap
- We acquired a dataset about the transactions, returns, store locations, customers, and products of the Maven Market in North America in the years 1997 and 1998.
- Used both MySQL and Power Query to clean up the data, make it more useful and useable, as well as model relationships between the tables.
- Visualized the data and took care to make it very easy and quick for the end user to gleam information.
- Extracted multiple insights that should help the company gather more profit and hopefully exceed next month's goals.
