-- 
-- Q1. Monthly Sales Report: This query returns the total number of unique orders and total wholesale revenue grouped by month

SELECT
    DATE_TRUNC('month', o.order_date) AS ORDER_MONTH,             -- Truncate order_date to the first day of the month
    COUNT(DISTINCT o.order_id) AS TOTAL_ORDERS,                   -- Count of unique orders per month
    SUM(oi.quantity_cases * p.wholesale_price) AS TOTAL_REVENUE   -- Total revenue = cases * price
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id                    -- Join orders with order_items
JOIN
    products p ON oi.product_id = p.product_id                    -- Join order_items with products for pricing
GROUP BY
    DATE_TRUNC('month', o.order_date)                             -- Group by month
ORDER BY
    ORDER_MONTH;

-- Question 2: Top 2 Selling Brands by Category: Returns the top 2 brands (by total revenue) within each product category

SELECT
    category,
    brand,
    total_revenue
FROM (
    SELECT
        p.category,
        p.brand,
        SUM(oi.quantity_cases * p.wholesale_price) AS total_revenue, -- Total revenue = quantity * price
        
        -- Assigns a rank to each brand within its category based on total revenue
        RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity_cases * p.wholesale_price) DESC) AS brand_rank

    FROM
        order_items oi
    JOIN
        products p ON oi.product_id = p.product_id

    GROUP BY
        p.category, p.brand
) ranked_brands

-- Keep only the top 2 ranked brands for each category
WHERE
    brand_rank <= 2;


-- Q2. Top 2 Selling Brands by Category
-- This query finds the top 2 brands (by total revenue) in each product category

-- Step 1: Calculate total revenue for each brand in each category
WITH brand_revenue AS (
    SELECT
        p.category,                                               -- Product category (e.g., Carbonated, Juice)
        p.brand,                                                  -- Brand name (e.g., FizzUp)
        SUM(oi.quantity_cases * p.wholesale_price) AS total_revenue -- Total revenue = quantity * price
    FROM
        order_items oi
    JOIN
        products p ON oi.product_id = p.product_id               -- Join order_items with products to get category and price
    GROUP BY
        p.category, p.brand                                      -- Group by category and brand
),

-- Step 2: Rank brands within each category by total revenue (highest first)
ranked_brands AS (
    SELECT
        category,
        brand,
        total_revenue,
        RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS brand_rank -- Assigns rank within each category
    FROM
        brand_revenue
)

-- Step 3: Select only the top 2 brands per category
SELECT
    category,
    brand,
    total_revenue
FROM
    ranked_brands
WHERE
    brand_rank <= 2;

-- Q3: Retailer Order Patterns: This query calculates total orders, total cases purchased, and average order value per retailer

SELECT
    r.retailer_id,                                           -- Unique ID of the retailer
    r.retailer_name,                                         -- Name of the retailer
    COUNT(DISTINCT o.order_id) AS total_orders,              -- Total number of unique orders
    SUM(oi.quantity_cases) AS total_cases_purchased,         -- Total number of cases purchased
    SUM(oi.quantity_cases * p.wholesale_price) / 
        COUNT(DISTINCT o.order_id) AS average_order_value    -- Total revenue divided by total orders
FROM
    retailers r
JOIN
    orders o ON r.retailer_id = o.retailer_id                -- Join retailers with orders
JOIN
    order_items oi ON o.order_id = oi.order_id               -- Join orders with order_items
JOIN
    products p ON oi.product_id = p.product_id               -- Join order_items with products for pricing
GROUP BY
    r.retailer_id, r.retailer_name;

-- Question 4: New Retailer Retention (Cohort Analysis): This query calculates the repeat purchase rate for retailers whose first-ever order was in January 2025

WITH cohort_orders AS (
    -- Step 1: Get all orders along with each retailer's first-ever order date
    SELECT
        o.retailer_id,                                                 -- Retailer ID
        MIN(o.order_date) OVER (PARTITION BY o.retailer_id) AS first_order_date, -- First order date per retailer
        o.order_id                                                     -- Current order ID
    FROM
        orders o
)

-- Step 2: Calculate repeat purchase rate for retailers whose first order was in Jan 2025
SELECT
    ROUND(
        100.0 * COUNT_IF(order_count > 1) / COUNT(*), 2                -- Repeat rate formula in percentage
    ) AS repeat_purchase_rate_percentage
FROM (
    -- Step 2.1: Count total number of orders placed by each retailer in the Jan 2025 cohort
    SELECT
        retailer_id,
        COUNT(order_id) AS order_count                                 -- Total orders by each retailer
    FROM
        cohort_orders
    WHERE
        DATE_TRUNC('month', first_order_date) = '2025-01-01'           -- Filter to only Jan 2025 cohort
    GROUP BY
        retailer_id
);






-- =======================================
-- IBM HR Attrition EDA 
-- =======================================

-- Basic row count
SELECT COUNT(*) AS Total_Employees FROM HR;

-- Attrition breakdown
SELECT Attrition, COUNT(*) AS Count
FROM HR
GROUP BY Attrition;

-- Average Age, Income, and Tenure by Attrition
SELECT Attrition,
       ROUND(AVG(Age), 1) AS Avg_Age,
       ROUND(AVG(MonthlyIncome), 2) AS Avg_Income,
       ROUND(AVG(YearsAtCompany), 1) AS Avg_YearsAtCompany
FROM HR
GROUP BY Attrition;

-- Attrition by Department
SELECT Department, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY Department, Attrition
ORDER BY Department, Attrition;

-- Attrition by Job Role
SELECT JobRole, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY JobRole, Attrition
ORDER BY JobRole, Attrition;

-- Attrition by Gender
SELECT Gender, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY Gender, Attrition;

-- Attrition by Marital Status
SELECT MaritalStatus, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY MaritalStatus, Attrition;

-- Does OverTime impact Attrition?
SELECT OverTime, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY OverTime, Attrition;

-- Impact of Business Travel
SELECT BusinessTravel, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY BusinessTravel, Attrition;

-- Average Distance From Home by Attrition
SELECT Attrition, ROUND(AVG(DistanceFromHome), 2) AS Avg_Distance
FROM HR
GROUP BY Attrition;

-- Job Satisfaction vs Attrition
SELECT JobSatisfaction, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY JobSatisfaction, Attrition
ORDER BY JobSatisfaction, Attrition;

-- Relationship Satisfaction vs Attrition
SELECT RelationshipSatisfaction, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY RelationshipSatisfaction, Attrition
ORDER BY RelationshipSatisfaction, Attrition;

-- Years Since Last Promotion
SELECT Attrition, ROUND(AVG(YearsSinceLastPromotion), 2) AS Avg_YearsSinceLastPromotion
FROM HR
GROUP BY Attrition;

-- Performance Rating by Attrition
SELECT PerformanceRating, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY PerformanceRating, Attrition
ORDER BY PerformanceRating, Attrition;

-- Work Life Balance vs Attrition
SELECT WorkLifeBalance, Attrition, COUNT(*) AS Count
FROM HR
GROUP BY WorkLifeBalance, Attrition
ORDER BY WorkLifeBalance, Attrition;
