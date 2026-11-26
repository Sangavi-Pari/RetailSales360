from pyspark.sql import SparkSession
from pyspark.sql.functions import col, trim, to_date, regexp_replace

spark = SparkSession.builder.appName("RetailSales360").getOrCreate()

# Source and target paths
source_path = "s3://retailsales360-sangavai/raw/"
target_path = "s3://retailsales360-sangavai/curated/glue_sales/"

# Read raw CSV
df = spark.read \
    .option("header", "true") \
    .option("quote", "") \
    .csv(source_path)

# Remove unwanted quotation marks
df = df.withColumn("order_id", regexp_replace(col("order_id"), '"', '')) \
       .withColumn("price", regexp_replace(col("price"), '"', ''))

# Data type conversion
df = df.withColumn("order_id", col("order_id").cast("int")) \
       .withColumn("order_date", to_date(col("order_date"), "yyyy-MM-dd")) \
       .withColumn("product", trim(col("product"))) \
       .withColumn("quantity", col("quantity").cast("int")) \
       .withColumn("price", col("price").cast("decimal(12,2)"))

# Remove null records
df = df.dropna()

# Remove duplicate records
df = df.dropDuplicates()

# Remove invalid records
df = df.filter(
    (col("quantity") > 0) &
    (col("price") > 0) &
    (col("product") != "")
)

# Calculate total amount
df = df.withColumn(
    "total_amount",
    col("quantity") * col("price")
)

# Write curated data in Parquet format
df.write.mode("overwrite").parquet(target_path)

print("ETL completed successfully")