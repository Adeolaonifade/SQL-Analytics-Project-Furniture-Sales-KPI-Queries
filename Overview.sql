-- --------------------------------------------------------------------------------------------------------
--						SQL Analytics Project: Furniture Sales KPI Queries
-- --------------------------------------------------------------------------------------------------------
/* Analysis 1: SQL Queries for Metrics
	Total Sales, Profit, Quantity, and Profit Margin */
-- --------------------------------------------------------------------------------------------------------
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
-- ----------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
/* Analysis 2: Year over Year Comparison (YoY)
Total Sales, Profit, Quantity with YoY Change Using CTE + Window Function */
-- ----------------------------------------------------------------------------------------------------------
WITH YearlySales AS	
	(SELECT
		YEAR(order_date) AS SalesYear,
		ROUND(SUM(sales),2) as SalesTotal,
		ROUND(SUM(Profit),2) as ProfitTotal,
		ROUND(SUM(Quantity),2) as QtyTotal
	FROM furniture_sales
	GROUP BY YEAR(order_date)),

SalesWithYoY AS
	(SELECT *,
		LAG(SalesTotal) OVER(ORDER BY SalesYear) as PrevYearSales,
		LAG(ProfitTotal) OVER(ORDER BY SalesYear) as PrevYearProfit,
		LAG(QtyTotal) OVER(ORDER BY SalesYear) as PrevYearQty
	FROM YearlySales)

SELECT 
	SalesYear,
	SalesTotal,
	PrevYearSales,
		CASE WHEN ROUND((SalesTotal - PrevYearSales) * 100 / SalesTotal, 2) IS NULL 
			THEN ''
			ELSE CONCAT(ROUND((SalesTotal - PrevYearSales) * 100 / SalesTotal, 2),'%')
		END AS YoYSalesChangePct,
	ProfitTotal,
	PrevYearProfit,
		CASE WHEN ROUND((ProfitTotal - PrevYearProfit) * 100 / ProfitTotal, 2) IS NULL 
			THEN ''
			ELSE CONCAT(ROUND((ProfitTotal - PrevYearProfit) * 100 / ProfitTotal, 2),'%')
		END AS YoYProfitChangePct,
	QtyTotal,
	PrevYearQty,
		CASE WHEN ROUND((QtyTotal - PrevYearQty) * 100 / QtyTotal, 2) IS NULL 
			THEN ''
			ELSE CONCAT(ROUND((QtyTotal - PrevYearQty) * 100 / QtyTotal, 2),'%')
		END AS YoYQtyChangePct
FROM  SalesWithYoY;
-- ----------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
/* Analysis 3: Month over Month Comparison (MoM)
	Monthly Sales Trend with Month-over-Month (MoM) Growth */
-- ----------------------------------------------------------------------------------------------------------
WITH MonthlySales AS
	(SELECT
		FORMAT(order_date, 'yyyy-MMM') AS SalesMonth,
		ROUND(SUM(sales),2) as SalesTotal
	FROM furniture_sales
	GROUP BY FORMAT(order_date, 'yyyy-MMM')
	),

SalesWithMoM AS
	(SELECT *,
		LAG(SalesTotal) OVER(ORDER BY SalesMonth) AS PrevMonthSales
	FROM MonthlySales)

SELECT 
	SalesMonth,
	SalesTotal,
	PrevMonthSales,
		CASE WHEN ROUND((SalesTotal - PrevMonthSales) * 100 / SalesTotal, 2) IS NULL 
			THEN ''
			ELSE CONCAT(ROUND((SalesTotal - PrevMonthSales) * 100 / SalesTotal, 2),'%')
		END AS MoMChangePct
FROM SalesWithMoM;
-- ----------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
/* Analysis 4: Top 5 Cities by Sales */
-- ----------------------------------------------------------------------------------------------------------
SELECT TOP 5
	City,
	SUM(Sales) AS TotalSales
FROM furniture_sales
GROUP BY City
ORDER BY TotalSales DESC;


-- Shipping Mode Distribution
SELECT 
    Ship_Mode,
    COUNT(*) AS OrderCount,
    CONCAT(
		LEFT
			(ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2),5),
	'%') AS PercentageOfOrders
FROM furniture_sales
GROUP BY Ship_Mode
ORDER BY OrderCount DESC;

-- Shipping Duration Breakdown
SELECT 
    ShippingDuration,
    COUNT(*) AS TotalOrders,
    CONCAT(
		LEFT(ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2),4),
	'%') AS PercentTotal
FROM 
	(
		SELECT DATEDIFF(DAY, Order_Date, Ship_Date) AS ShippingDuration
		FROM furniture_sales
	) AS DurationTable

GROUP BY ShippingDuration
ORDER BY ShippingDuration;
-- ----------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
/* Analysis 5: Sales by Region and Segment */
-- ----------------------------------------------------------------------------------------------------------
-- Region Breakdown
SELECT 
    Region,
    SUM(Sales) AS TotalSales
FROM furniture_sales
GROUP BY Region
ORDER BY TotalSales DESC;


-- Segment Breakdown
SELECT 
    Segment,
    SUM(Sales) AS TotalSales
FROM furniture_sales
GROUP BY Segment
ORDER BY TotalSales DESC;


WITH RegionSegmentSales AS
	(SELECT 
		Region,
		Segment,
		SUM(Sales) AS TotalSales
	FROM furniture_sales
	GROUP BY Region, Segment)
SELECT *
FROM RegionSegmentSales
ORDER BY Region, Segment, TotalSales DESC;
-- ----------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
/* Analysis 6: Top 3 Categories by Sales Using DENSE_RANK() */
-- ----------------------------------------------------------------------------------------------------------
WITH CategorySales AS (
    SELECT 
		Sub_Category,
        SUM(Sales) AS TotalSales
    FROM furniture_sales
    GROUP BY Sub_Category
),
Ranked AS (
    SELECT *,
        DENSE_RANK() OVER (ORDER BY TotalSales DESC) AS RankBySales
    FROM CategorySales
)
SELECT *
FROM Ranked
WHERE RankBySales <= 2;
-- ----------------------------------------------------------------------------------------------------------