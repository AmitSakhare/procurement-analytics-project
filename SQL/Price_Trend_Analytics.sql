=================================================================
 PRICE TREND ANALYTICS
=================================================================

=================================================================
-- Query - Latest Price per Material
=================================================================

SELECT material_id,
  MAX(price_date) latest_price_date
FROM price_history
GROUP BY material_id;

=================================================================
-- Query - Price Change Range
=================================================================
SELECT material_id,
  MAX(price_per_ton) - MIN(price_per_ton) price_change
FROM price_history
GROUP BY material_id;

=================================================================
-- Query - Price Volatility
=================================================================
SELECT material_id,
    STDDEV(price_per_ton) volatility
FROM price_history
GROUP BY material_id
ORDER BY volatility DESC;

=================================================================
-- Query - Average Price Per Year
=================================================================
SELECT YEAR(price_date) year,
  AVG(price_per_ton) avg_price
FROM price_history
GROUP BY year

=================================================================
-- Query - Monthly Price Trend
=================================================================

SELECT material_id,
  YEAR(price_date) year,
  MONTH(price_date) month,
  AVG(price_per_ton) avg_price
FROM price_history
GROUP BY material_id, year, month;
