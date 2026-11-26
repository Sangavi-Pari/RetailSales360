-- Insert only new orders into the curated table

INSERT INTO retailsales360_db.curated_sales

WITH cleaned_data AS (
    SELECT
        TRY_CAST(REPLACE(order_id, '"', '') AS INT) AS order_id,
        TRY_CAST(order_date AS DATE) AS order_date,
        TRIM(product) AS product,
        quantity,
        TRY_CAST(REPLACE(price, '"', '') AS DECIMAL(12,2)) AS price
    FROM retailsales360_db.raw_sales
)

SELECT DISTINCT
    r.order_id,
    r.order_date,
    r.product,
    r.quantity,
    r.price,
    r.quantity * r.price AS total_amount
FROM cleaned_data r
WHERE r.order_id IS NOT NULL
    AND r.order_date IS NOT NULL
    AND r.product IS NOT NULL
    AND r.product <> ''
    AND r.quantity > 0
    AND r.price > 0
    AND NOT EXISTS (
        SELECT 1
        FROM retailsales360_db.curated_sales c
        WHERE c.order_id = r.order_id
    );


-- Validate incremental load
SELECT
    COUNT(*) AS total_records,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_revenue
FROM retailsales360_db.curated_sales;