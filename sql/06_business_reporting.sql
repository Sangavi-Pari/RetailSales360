-- Report 1: Daily sales revenue

SELECT
    order_date,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_revenue
FROM retailsales360_db.curated_sales
GROUP BY order_date
ORDER BY order_date;


-- Report 2: Product-wise sales revenue

SELECT
    product,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_revenue
FROM retailsales360_db.curated_sales
GROUP BY product
ORDER BY total_revenue DESC;


-- Create daily sales reporting view

CREATE OR REPLACE VIEW retailsales360_db.vw_daily_sales AS
SELECT
    order_date,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_revenue
FROM retailsales360_db.curated_sales
GROUP BY order_date;


-- Validate reporting view

SELECT *
FROM retailsales360_db.vw_daily_sales
ORDER BY order_date;