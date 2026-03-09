=======================================================================
MATERIAL ANALYTICS
=======================================================================

=======================================================================
-- QUERY - Most Purchased Materials
-- Purpose:- Identify materials with the highest procurement volume.
=======================================================================
  
SELECT
    m.material_name,
    SUM(p.quantity_tons) AS total_quantity
FROM purchase_orders p
JOIN materials m
    ON p.material_id = m.material_id
GROUP BY m.material_name
ORDER BY total_quantity DESC;

=======================================================================
-- Query - Materials Purchased from Most Vendors
-- Purpose:- Identify materials with diversified supplier base.
=======================================================================

SELECT 
    m.material_name,
    COUNT(DISTINCT p.vendor_id) AS vendor_count
FROM purchase_orders p
JOIN materials m
ON p.material_id = m.material_id
GROUP BY m.material_name
ORDER BY vendor_count DESC;

=======================================================================
-- Query - Average Price per Material
-- Purpose:- Analyze average material price trends.
=======================================================================

SELECT 
    m.material_name,
    AVG(ph.price_per_ton) AS avg_price
FROM price_history ph
JOIN materials m
ON ph.material_id = m.material_id
GROUP BY m.material_name;

=======================================================================
-- Query - Highest Material Price Recorded
-- Purpose:- Identify most expensive materials historically.
=======================================================================
  
SELECT 
    m.material_name,
    MAX(ph.price_per_ton) AS highest_price
FROM price_history ph
JOIN materials m
ON ph.material_id = m.material_id
GROUP BY m.material_name
ORDER BY highest_price DESC;

=======================================================================
-- Query - Materials Never Purchased
-- Purpose:- Identify unused materials in the catalog.
=======================================================================

SELECT material_name
FROM materials
WHERE material_id NOT IN
(SELECT material_id FROM purchase_orders);
