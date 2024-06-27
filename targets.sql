WITH orders_full AS 

(
SELECT
     details.OrderID AS OrderID
    ,orders.CustomerName
    ,orders.OrderDate
    ,details.Amount AS Amount
    ,details.Profit AS Profit
    ,details.Quantity AS Quantity
    ,details.Category AS Category
    ,details."Sub-Category" AS SubCategory
    
FROM 
    details
    
LEFT JOIN orders
ON details.OrderID = orders.OrderId
),

sales AS
(
SELECT
    substr(OrderDate,4,7) AS month
    ,category
    ,SUM(amount) AS amount
    ,SUM(profit) AS profit
    
    
FROM
 
    orders_full
GROUP BY month, category
),

sales_target AS
(
SELECT 
     CASE substr(MonthofOrderDate, 1, 3)
  WHEN 'Jan' THEN '01'
  WHEN 'Feb' THEN '02'
  WHEN 'Mar' THEN '03'
  WHEN 'Apr' THEN '04'
  WHEN 'May' THEN '05'
  WHEN 'Jun' THEN '06'
  WHEN 'Jul' THEN '07'
  WHEN 'Aug' THEN '08'
  WHEN 'Sep' THEN '09'
  WHEN 'Oct' THEN '10'
  WHEN 'Nov' THEN '11'
  WHEN 'Dec' THEN '12'
  END ||
    '-20' || substr(MonthofOrderDate, 5, 2) AS month
    ,Category
    ,Target
FROM
    target
)

SELECT
 sales.month
 ,sales.category
 ,sales.amount
 ,sales.profit
 ,sales_target.Target AS target
 ,sales.amount - sales_target.Target AS difference
 ,CASE 
  WHEN (sales.amount - sales_target.Target) > 0 THEN 'ACHIEVED'
  ELSE 'FAILED'
  END AS realisation
 
FROM 
    sales
    
LEFT JOIN 
    sales_target
ON 
    sales.month = sales_target.month AND
    sales.category =sales_target.category;
