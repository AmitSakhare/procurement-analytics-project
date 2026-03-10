===============================================================================
PROCUREMENT SPEND ANALYSIS
===============================================================================

===============================================================================
-- Query - Total Procurement Spend
-- Purpose:- Identify spend of total procurement of purchase order.
===============================================================================
       
SELECT 
       SUM(total_value) AS total_procurement_spend
FROM purchase_orders;

===============================================================================
-- Query - Monthly Procurement Spend
-- Purpose:- Identify spend of total procurement of purchase order monthwise.
===============================================================================

SELECT 
       YEAR(order_date) AS year,
       MONTH(order_date) AS month,
       SUM(total_value) AS monthly_spend
FROM purchase_orders
GROUP BY year, month
ORDER BY year, month;

===============================================================================
-- Query - Yearly Procurement Spend
-- Purpose:- Identify spend of total procurement of purchase order Yearly.
===============================================================================

SELECT 
       YEAR(order_date) AS year,
       SUM(total_value) AS yearly_spend
FROM purchase_orders
GROUP BY year;

===============================================================================
-- Query - Highest Purchase Order
-- Purpose:- Identify of Highest  of purchase order .
===============================================================================
SELECT *
       FROM purchase_orders
       ORDER BY total_value DESC
LIMIT 1;

===============================================================================
-- Query - Average Purchase Order Value
-- Purpose:- Identify of Average of purchase order .
===============================================================================
       
SELECT 
       AVG(total_value) AS avg_order_value
FROM purchase_orders;
