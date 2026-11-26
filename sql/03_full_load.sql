-- Create curated table and store data in Parquet format

CREATE TABLE retailsales360_db.curated_sales
WITH (
    format = 'PARQUET',
    external_location = 's3://retailsales360-sangavai/curated/sales/'
) AS

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
    order_id,
    order_date,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM cleaned_data
WHERE order_id IS NOT NULL
    AND order_date IS NOT NULL
    AND product IS NOT NULL
    AND product <> ''
    AND quantity > 0
    AND price > 0;


-- Validate curated data
SELECT *
FROM retailsales360_db.curated_sales
ORDER BY order_id;