#!/usr/bin/env bash
set -euo pipefail

./scripts/init-hdfs.sh

docker compose exec hiveserver2 beeline -u jdbc:hive2://localhost:10000 -n hive <<'SQL'
CREATE DATABASE IF NOT EXISTS lab;
USE lab;
CREATE TABLE IF NOT EXISTS demo_sales (
  order_id STRING,
  customer_name STRING,
  product_name STRING,
  quantity INT,
  unit_price DOUBLE,
  order_date STRING
)
STORED AS PARQUET;
SHOW TABLES;
SQL

docker compose exec trino trino --execute "SHOW SCHEMAS FROM hive;"
docker compose exec trino trino --execute "SHOW TABLES FROM hive.lab;"
