/* Analysis 5: Sales by Region and Segment */

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