-- =====================================================
-- PROCUREMENT ANALYTICS DATABASE
-- Designed for Supply Chain & Data Analytics Projects
-- =====================================================

-- -----------------------------------------------------
-- CREATE DATABASE
-- -----------------------------------------------------
-- This database stores procurement related information
-- such as vendors, materials, purchase orders,
-- inventory levels and price history.

CREATE DATABASE procurement_analytics;

-- Select the database
USE procurement_analytics;

-- =====================================================
-- VENDORS TABLE
-- =====================================================
-- Stores supplier/vendor master information.
-- Each vendor provides materials to the organization.

CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(150) NOT NULL,
    location VARCHAR(100),
    rating DECIMAL(3,2),
    lead_time_days INT
);

-- =====================================================
-- MATERIALS TABLE
-- =====================================================
-- Stores list of raw materials purchased from vendors.

CREATE TABLE materials (
    material_id INT PRIMARY KEY,
    material_name VARCHAR(100) NOT NULL,
    category VARCHAR(100)
);

-- =====================================================
-- PURCHASE ORDERS TABLE
-- =====================================================
-- Stores procurement transactions.
-- Each record represents a purchase order made to a vendor.

CREATE TABLE purchase_orders (
    po_id INT PRIMARY KEY,
    vendor_id INT,
    material_id INT,
    quantity_tons DECIMAL(10,2),
    price_per_ton DECIMAL(10,2),
    total_value DECIMAL(15,2),
    order_date DATE,

    -- Foreign key linking vendor
    CONSTRAINT fk_vendor
    FOREIGN KEY (vendor_id)
    REFERENCES vendors(vendor_id),

    -- Foreign key linking material
    CONSTRAINT fk_material
    FOREIGN KEY (material_id)
    REFERENCES materials(material_id)
);

-- =====================================================
-- INVENTORY TABLE
-- =====================================================
-- Tracks warehouse stock levels for each material.

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    material_id INT,
    stock_qty DECIMAL(10,2),
    reorder_level DECIMAL(10,2),
    daily_usage DECIMAL(10,2),
    warehouse_location VARCHAR(100),
    states VARCHAR(100),

    -- Foreign key linking to materials table
    CONSTRAINT fk_inventory_material
    FOREIGN KEY (material_id)
    REFERENCES materials(material_id)
);

-- =====================================================
-- PRICE HISTORY TABLE
-- =====================================================
-- Stores historical pricing of materials to analyze
-- price trends and volatility over time.

CREATE TABLE price_history (
    price_id INT PRIMARY KEY,
    material_id INT,
    price_per_ton DECIMAL(10,2),
    price_date DATE,

    -- Foreign key linking material
    CONSTRAINT fk_price_material
    FOREIGN KEY (material_id)
    REFERENCES materials(material_id)
);
