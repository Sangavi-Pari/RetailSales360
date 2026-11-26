# RetailSales360 — AWS Data Engineering Project

## Project Overview

RetailSales360 is an end-to-end AWS data engineering project that processes retail sales transactions, performs data cleaning and transformation, supports incremental loading, and delivers business reporting.

## Technologies Used

- Amazon S3
- AWS Glue Data Catalog
- Amazon Athena
- AWS IAM
- SQL
- Apache Parquet
- Python and PySpark (alternative ETL implementation)

## Architecture

```text
Source CSV Files
       |
       v
Amazon S3 - Raw Layer
       |
       v
AWS Glue Data Catalog - Raw Table
       |
       v
Amazon Athena - SQL Transformation
       |
       v
Amazon S3 - Curated Layer (Parquet)
       |
       v
AWS Glue Data Catalog - Curated Table
       |
       v
Athena Reporting Views
```

## Project Features

- Raw and curated data layers
- External table creation
- Data type conversion
- Special character removal
- Null and invalid record handling
- Duplicate removal
- Revenue calculation
- CSV to Parquet conversion
- Full and incremental data loading
- Idempotency testing
- Data quality validation
- Business reporting views

## Project Structure

```text
RetailSales360/
├── data/
│   ├── sales.csv
│   └── sales_20261104.csv
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_raw_table.sql
│   ├── 03_full_load.sql
│   ├── 04_incremental_load.sql
│   ├── 05_data_quality.sql
│   └── 06_business_reporting.sql
├── scripts/
│   └── sales_etl.py
├── iam/
│   └── s3_access_policy.json
├── README.md
└── .gitignore
```

## Implementation Results

| Metric | Full Load | Incremental Load |
|---|---:|---:|
| Total records | 5 | 8 |
| Total quantity | 13 | 21 |
| Total revenue | 8100 | 11100 |

## Data Quality Results

| Validation | Result |
|---|---|
| Duplicate order IDs | 0 |
| Invalid records | 0 |
| Incremental rerun | Passed |
| Reporting view validation | Passed |

## Business Reporting

- Daily sales revenue
- Product-wise sales revenue
- Total orders
- Total quantity sold
- Total revenue

## Challenges and Solutions

### AWS Glue Access Restriction

AWS Glue ETL job creation encountered an account-level access denial. Amazon Athena CTAS was used as an alternative transformation engine to generate curated Parquet data.

### Source Data Formatting

The source CSV contained unwanted quotation marks. SQL transformations were implemented to clean the values before converting them into numeric data types.

### Incremental Loading

The NOT EXISTS condition was implemented using order_id to prevent previously processed orders from being inserted again.

## Current Limitations

- The PySpark ETL script is prepared but has not been tested on AWS Glue.
- Incremental loading supports new orders only.
- Updates and deletions are not currently supported.
- Pipeline execution is manual.

## Future Enhancements

- AWS Glue ETL execution
- Automated pipeline orchestration
- CloudWatch monitoring
- SNS notifications
- Watermark-based incremental processing
- Terraform
- CI/CD using GitHub Actions
- Business intelligence dashboard