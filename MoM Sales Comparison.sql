/* Analysis 3: Month over Month Comparison (MoM)
	Monthly Sales Trend with Month-over-Month (MoM) Growth */

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