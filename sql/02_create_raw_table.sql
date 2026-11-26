CREATE EXTERNAL TABLE IF NOT EXISTS retailsales360_db.raw_sales (
    order_id STRING,
    order_date STRING,
    product STRING,
    quantity INT,
    price STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3://retailsales360-sangavai/raw/'
TBLPROPERTIES ('skip.header.line.count'='1');


-- Validate raw data
SELECT *
FROM retailsales360_db.raw_sales;


-- Validate source record count
SELECT COUNT(*) AS total_records
FROM retailsales360_db.raw_sales;