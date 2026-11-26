-- Check 1: Duplicate order IDs
-- Expected result: No records

SELECT
    order_id,
    COUNT(*) AS record_count
FROM retailsales360_db.curated_sales
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Check 2: Null and invalid records
-- Expected result: 0

SELECT COUNT(*) AS invalid_records
FROM retailsales360_db.curated_sales
WHERE order_id IS NULL
   OR order_date IS NULL
   OR product IS NULL
   OR TRIM(product) = ''
   OR quantity IS NULL
   OR quantity <= 0
   OR price IS NULL
   OR price <= 0
   OR total_amount IS NULL
   OR total_amount <> quantity * price;


-- Check 3: Source record count

SELECT COUNT(*) AS raw_record_count
FROM retailsales360_db.raw_sales;


-- Check 4: Target record count

SELECT COUNT(*) AS curated_record_count
FROM retailsales360_db.curated_sales;


-- Check 5: Business totals

SELECT
    COUNT(*) AS total_records,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_revenue
FROM retailsales360_db.curated_sales;