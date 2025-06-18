/* Analysis 1: SQL Queries for Metrics
	Total Sales, Profit, Quantity, and Profit Margin */

SELECT
	'Total Sales' AS 'Measure', ROUND(SUM(sales),2) as 'KPIs Value'
FROM Furniture_Sales
UNION
SELECT
	'Total Profit', ROUND(SUM(Profit),2)
FROM Furniture_Sales
UNION
SELECT
	'Total Quantity', ROUND(SUM(Quantity),2)
FROM Furniture_Sales
UNION
SELECT
	'Total Profit', ROUND(SUM(Profit),2)
FROM Furniture_Sales
UNION
SELECT
	'Profit Margin %', ROUND(((SUM(sales)-SUM(Profit)) *100 /SUM(Sales)),2)
FROM Furniture_Sales

ORDER BY 'KPIs Value' DESC;