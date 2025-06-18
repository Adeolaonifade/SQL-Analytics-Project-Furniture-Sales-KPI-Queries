/* Analysis 2: Year over Year Comparison (YoY)
Total Sales, Profit, Quantity with YoY Change Using CTE + Window Function */

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