==================================================================
  ADVANCED SQL QUERIES
==================================================================

==================================================================
-- Query - Materials Supplied by Each Vendor
==================================================================
  
SELECT v.vendor_name,
  COUNT(DISTINCT p.material_id) material_count
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name;

==================================================================
-- Query - Vendors Supplying Most Materials
==================================================================

SELECT vendor_id,
  COUNT(DISTINCT material_id) materials
FROM purchase_orders
GROUP BY vendor_id
ORDER BY materials DESC;

==================================================================
-- Query - Vendor Material Spend
==================================================================

SELECT v.vendor_name,
  m.material_name,
  SUM(p.total_value) spend
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
JOIN materials m
ON p.material_id = m.material_id
GROUP BY v.vendor_name, m.material_name;

==================================================================
-- Query - Vendor Contribution Percentage
==================================================================

SELECT v.vendor_name,
  SUM(p.total_value) /
  (SELECT SUM(total_value) FROM purchase_orders) * 100 contribution_percent
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name;

==================================================================
-- Query - Low Rating Vendors with High Spend
==================================================================
SELECT v.vendor_name,
  v.rating,
  SUM(p.total_value) spend
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
WHERE v.rating < 3
GROUP BY v.vendor_name, v.rating;

==================================================================
-- Query - Rank Vendors by Spend
==================================================================

SELECT v.vendor_name,
  SUM(p.total_value) spend,
  RANK() OVER (ORDER BY SUM(p.total_value) DESC) vendor_rank
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name;

==================================================================
-- Query - Running Total Procurement Spend
==================================================================

SELECT order_date,
  SUM(total_value) OVER(ORDER BY order_date) running_total
FROM purchase_orders;

==================================================================
-- Query - Moving Average Material Price
==================================================================

SELECT material_id,
  price_date,
  AVG(price_per_ton) OVER(
ORDER BY price_date
ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
) moving_avg
FROM price_history;

==================================================================
-- Query - Vendor Spend Percentage (Window Function)
==================================================================
  
SELECT vendor_id,
  SUM(total_value),
  SUM(total_value) * 100 /
  SUM(SUM(total_value)) OVER() percent_spend
FROM purchase_orders
GROUP BY vendor_id;

==================================================================
-- Query - Top 3 Vendors per Location
==================================================================
SELECT *
FROM (
    SELECT vendor_name,
    location,
    rating,
    RANK() OVER(PARTITION BY location ORDER BY rating DESC) r
FROM vendors
) x
WHERE r <= 3;
