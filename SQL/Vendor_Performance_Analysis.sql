=========================================================================
PROCUREMENT ANALYTICS – BUSINESS SQL QUERIES
=========================================================================

=========================================================================
-- QUERY - Top Vendors by Total Procurement Spend
-- Purpose:- Identify vendors contributing the highest procurement cost.
-- Useful for supplier dependency analysis and negotiation strategy.
=========================================================================
SELECT
    v.vendor_name,
    SUM(p.total_value) AS total_spend
FROM purchase_orders p
JOIN vendors v
    ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name
ORDER BY total_spend DESC;

=========================================================================
-- QUERY - Top 10 Vendors by Number of Purchase Orders
-- Purpose:- Identify vendors most frequently used by the procurement team.
=========================================================================

SELECT TOP 10
    v.vendor_name,
    COUNT(p.po_id) AS total_orders
FROM purchase_orders p
JOIN vendors v
    ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name
ORDER BY total_orders DESC;

=========================================================================
-- QUERY - Average Vendor Rating by Location
-- Purpose:- Evaluate supplier performance across geographic regions.
=========================================================================

SELECT
    location,
    AVG(rating) AS avg_vendor_rating
FROM vendors
GROUP BY location
ORDER BY avg_vendor_rating DESC;

=========================================================================
-- QUERY - Vendors with High Lead Time
-- Purpose:- Identify suppliers with long delivery times.
-- Useful for supply chain risk analysis.
=========================================================================
       
SELECT
    vendor_name,
    lead_time_days
FROM vendors
WHERE lead_time_days > 10
ORDER BY lead_time_days DESC;

=========================================================================
-- QUERY - Vendors with Highest Average Order Value
-- Purpose:- Identify strategic suppliers handling high value orders.
=========================================================================

SELECT
    v.vendor_name,
    AVG(p.total_value) AS avg_order_value
FROM purchase_orders p
JOIN vendors v
    ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_name
ORDER BY avg_order_value DESC;


