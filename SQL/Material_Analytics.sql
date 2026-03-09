-- Material Analytics
---------------------------------------------------------------------------------
-- Most Purchased Materials
SELECT m.material_name,
SUM(p.quantity_tons) AS total_qty
FROM purchase_orders p
JOIN materials m
ON p.material_id = m.material_id
GROUP BY m.material_name
ORDER BY total_qty DESC;

-- Find highest recorded price of each material
SELECT m.material_name,
MAX(price_per_ton) AS highest_price
FROM price_history ph
JOIN materials m
ON ph.material_id = m.material_id
GROUP BY m.material_name
ORDER BY highest_price DESC;

-- Calculate average historical price
SELECT m.material_name,
AVG(price_per_ton) AS avg_price
FROM price_history ph
JOIN materials m
ON ph.material_id = m.material_id
GROUP BY m.material_name;

-- Track price movement over time
SELECT material_id,
price_date,
price_per_ton
FROM price_history
ORDER BY material_id, price_date;

-- Number of vendors supplying each material
SELECT m.material_name,
COUNT(DISTINCT p.vendor_id) AS vendor_count
FROM purchase_orders p
JOIN materials m
ON p.material_id = m.material_id
GROUP BY m.material_name
ORDER BY vendor_count DESC;
