🛋️ Furniture Sales Analysis Dashboard using SQL Server

This project presents a comprehensive SQL-based analysis of a Furniture Sales dataset. It covers key business metrics such as sales trends, profit analysis, shipping performance, and top-performing categories across U.S. regions.

The entire KPIs are generated exclusively using SQL Server, leveraging powerful SQL concepts like CTEs, subqueries, and window functions.

📌 Project Objectives

Analyze overall sales, profit, and quantity performance
Track YoY and MoM changes in sales and profitability
Understand customer segment behavior and regional sales distribution
Identify top-performing cities, states, and categories
Explore shipping durations and most used shipping modes
🧠 Key SQL Concepts Used
✅ Common Table Expressions (CTEs)
✅ Subqueries
✅ Window Functions (e.g., LAG(), DENSE_RANK())
✅ Aggregate Functions (SUM(), COUNT(), ROUND())
✅ Date Functions (FORMAT(), DATEDIFF())
✅ Conditional Logic and Percentage Calculations
🗂️ Dataset
Filename: Furniture_Sales.csv

Columns:

OrderDate, ShipDate, ShipMode, CustomerName, Segment, City, State, Region
ProductID, Category, SubCategory, ProductName
Sales, Quantity, Discount, Profit
The data simulates sales transactions across various U.S. locations and includes customer, shipping, and product-level details.

📊 SQL KPIs and Metrics
Metric	Description
🔹 Total Sales, Profit, Quantity	Total values across entire dataset
🔹 YoY Analysis	Year-over-Year comparison for sales, profit, and quantity
🔹 MoM Trend	Month-over-Month sales analysis using window functions
🔹 Ship Mode Distribution	Frequency and percentage of each shipping mode used
🔹 Shipping Duration Breakdown	Order fulfillment duration distribution in days
🔹 Regional and Segment Insights	Sales grouped by customer segment and geographic region
🔹 Top Categories and Products	Most profitable and popular product categories
🔹 Top States & Cities	States and cities with highest sales volumes
🛠️ Setup Instructions
Import CSV into SQL Server

Create a table: FurnitureSales
Use SQL Server Import Wizard or BULK INSERT
Run the Provided SQL Scripts

Each script can be run independently to generate views or stored procedures
Future: Visualize in Power BI / Excel

Connect to SQL Server and use views to build dashboards

💡 Future Improvements
Automate data refresh using SQL Server Agent
Integrate live dashboards with Power BI service
Add drill-down capabilities for category and product-level exploration
Enable user-defined filters by Region, Segment, and Year
