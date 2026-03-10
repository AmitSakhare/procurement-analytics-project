=====================================================================
INVENTORY ANALYTICS
=====================================================================
  
=====================================================================
-- QUERY - Materials Below Reorder Level
-- Purpose:-  Identify inventory items that need replenishment.
=====================================================================
  
SELECT
    m.material_name,
    i.stock_qty,
    i.reorder_level
FROM inventory i
JOIN materials m
    ON i.material_id = m.material_id
WHERE i.stock_qty < i.reorder_level;

=====================================================================
-- Query : Estimated Days Until Stockout
=====================================================================
SELECT m.material_name,
    stock_qty/daily_usage as days_remaining
FROM inventory i
JOIN materials m
ON i.material_id = m.material_id;

=====================================================================
-- Query - Warehouse Stock Distribution
=====================================================================
SELECT warehouse_location,
  SUM(stock_qty) total_stock
FROM inventory
GROUP BY warehouse_location;

=====================================================================
-- Query - Average Daily Usage per Material
=====================================================================

SELECT m.material_name,
  AVG(daily_usage) avg_usage
FROM inventory i
JOIN materials m
ON i.material_id = m.material_id
GROUP BY m.material_name;

=====================================================================
-- Query - Highest Inventory Materials
=====================================================================
SELECT m.material_name,
stock_qty
FROM inventory i
JOIN materials m
ON i.material_id = m.material_id
ORDER BY stock_qty DESC;
