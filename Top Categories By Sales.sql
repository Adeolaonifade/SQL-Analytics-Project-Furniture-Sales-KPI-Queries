/* Analysis 6: Top 3 Categories by Sales Using DENSE_RANK() */


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
