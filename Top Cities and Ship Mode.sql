/* Analysis 4: Top 5 Cities by Sales */

SELECT TOP 5
	City,
	SUM(Sales) AS TotalSales
FROM furniture_sales
GROUP BY City
ORDER BY TotalSales DESC;


-- Shipping Mode Distribution Using Window Function
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
