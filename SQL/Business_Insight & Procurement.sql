========================================================================
 BUSINESS & PROCUREMENT INSIGHT QUERIES
========================================================================

========================================================================
-- Query - Vendors Above Average Rating
========================================================================

SELECT vendor_name
FROM vendors
WHERE rating >
(SELECT AVG(rating) FROM vendors);

========================================================================
-- Query - Orders Above Average Value
========================================================================

SELECT *
FROM purchase_orders
WHERE total_value >
(SELECT AVG(total_value) FROM purchase_orders);

========================================================================
-- Query - Vendors Without Orders
========================================================================

SELECT vendor_name
FROM vendors
WHERE vendor_id NOT IN
(SELECT vendor_id FROM purchase_orders);

========================================================================
-- Query - Highest Spending Vendor
========================================================================

SELECT TOP 1 vendor_id
FROM purchase_orders
GROUP BY vendor_id
ORDER BY SUM(total_value) DESC;

========================================================================
-- Query - Vendor Order Frequency
========================================================================
SELECT vendor_id,
  COUNT(po_id) order_count
FROM purchase_orders
GROUP BY vendor_id;

========================================================================
-- Query - Fastest Delivery Vendor
========================================================================

SELECT TOP 1 vendor_name
FROM vendors
ORDER BY lead_time_days;

========================================================================
-- Query - Procurement Spend by Category
========================================================================
SELECT m.category,
  SUM(p.total_value) spend
FROM purchase_orders p
JOIN materials m
ON p.material_id = m.material_id
GROUP BY m.category;

========================================================================
-- Query - Average Quantity per Order
========================================================================

SELECT AVG(quantity_tons)
FROM purchase_orders;

========================================================================
-- Query - Top Material per Vendor
========================================================================
SELECT vendor_id,
  material_id,
  SUM(quantity_tons)
FROM purchase_orders
GROUP BY vendor_id, material_id;

========================================================================
-- Query - Procurement Spend by Vendor Location
========================================================================
SELECT v.location,
  SUM(p.total_value) total_spend
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
GROUP BY v.location;

========================================================================
                  SUPPLY CHAIN ANALYTICS
========================================================================

========================================================================
-- Query - Inventory Value Estimation
========================================================================
SELECT m.material_name,
  stock_qty * AVG(ph.price_per_ton) inventory_value
FROM inventory i
JOIN materials m
ON i.material_id = m.material_id
JOIN price_history ph
ON ph.material_id = m.material_id
GROUP BY m.material_name, stock_qty;

========================================================================
-- Query - Most Frequently Ordered Material
========================================================================

SELECT TOP 1 material_id,
  COUNT(*) orders
FROM purchase_orders
GROUP BY material_id
ORDER BY orders DESC;

========================================================================
-- Query - Average Lead Time of Active Vendors
========================================================================

SELECT 
  AVG(lead_time_days)
FROM vendors
WHERE vendor_id IN
  (SELECT DISTINCT vendor_id FROM purchase_orders);

========================================================================
-- Query - Total Inventory Stock
========================================================================
SELECT 
  SUM(stock_qty) as total_inventory
FROM inventory;
