/* Top Vendors by Total Procurement Spend */
----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

-- WAQ Calculate total spend per vendor
SELECT v.vendor_name,
SUM(p.total_value) AS total_spend
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name
ORDER BY total_spend DESC;

-- Find vendors with highest order frequency TOP 10
SELECT TOP 10 v.vendor_name,
       COUNT(p.po_id) AS total_orders
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name
ORDER BY total_orders DESC;

-- Average Vendor Rating by Location 
-- Understand supplier quality distribution by location
SELECT location,
AVG(rating) AS avg_rating
FROM vendors
GROUP BY location;

-- Vendors with Lead Time Greater Than 10 Days
SELECT vendor_name,
lead_time_days
FROM vendors
WHERE lead_time_days > 10;

-- Vendors with Highest Average Order Value
SELECT v.vendor_name,
AVG(p.total_value) AS avg_order_value
FROM purchase_orders p
JOIN vendors v
ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name
ORDER BY avg_order_value DESC;



