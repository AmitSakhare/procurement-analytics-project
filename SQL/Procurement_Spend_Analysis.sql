/* Procurement Spend Analysis */ 
-------------------------------------------------------------------------
-- Analyze procurement spend per month
SELECT YEAR(order_date) AS year,
MONTH(order_date) AS month,
SUM(total_value) AS monthly_spend
FROM purchase_orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- Annual procurement expenditure
SELECT YEAR(order_date) AS year,
       SUM(total_value) AS yearly_spend
FROM purchase_orders
GROUP BY YEAR(order_date);

-- Find the largest purchase order
SELECT TOP 1 *
FROM purchase_orders
ORDER BY total_value DESC;

-- Average procurement transaction value
SELECT AVG(total_value)
FROM purchase_orders;

-- Identify materials that require replenishment
SELECT m.material_name,
i.stock_qty,
i.reorder_level
FROM inventory i
JOIN materials m
ON i.material_id = m.material_id
WHERE stock_qty < reorder_level;

-- Calculate remaining days before stock runs out
SELECT m.material_name,
stock_qty / daily_usage AS days_remaining
FROM inventory i
JOIN materials m
ON i.material_id = m.material_id;

-- Total stock across warehouse locations
SELECT warehouse_location,
SUM(stock_qty) AS total_stock
FROM inventory
GROUP BY warehouse_location;

-- Understand material consumption rate
SELECT m.material_name,
AVG(daily_usage) AS avg_daily_usage
FROM inventory i
JOIN materials m
ON i.material_id = m.material_id
GROUP BY m.material_name;

--Highest Inventory Materials
SELECT m.material_name,
stock_qty
FROM inventory i
JOIN materials m
ON i.material_id = m.material_id
ORDER BY stock_qty DESC;
