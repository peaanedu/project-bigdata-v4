# Hadoop v2 Production Edition for Docker on Ubuntu

This package provides a fuller big data lab for Ubuntu using Docker Compose:

- Hadoop HDFS + YARN
- MapReduce example job
- Spark master + workers
- Jupyter Notebook
- Hive Metastore + HiveServer2
- PostgreSQL metastore database
- Persistent volumes for data and logs
- Healthchecks and startup ordering

## Included services

- `namenode`
- `datanode1`, `datanode2`, `datanode3`
- `resourcemanager`
- `nodemanager1`, `nodemanager2`, `nodemanager3`
- `historyserver`
- `spark-master`, `spark-worker1`, `spark-worker2`
- `postgres`
- `hive-metastore`
- `hiveserver2`
- `jupyter`

## Recommended Ubuntu host

- Ubuntu 22.04 or 24.04
- Docker Engine + Docker Compose plugin
- Minimum 8 vCPU, 16 GB RAM, 80+ GB free disk
- Open these ports if you want remote browser access:
  - 9870 NameNode
  - 8088 YARN
  - 19888 JobHistory
  - 8080 Spark Master
  - 8081 / 8082 Spark Workers
  - 10000 HiveServer2
  - 8888 Jupyter

## Deploy

```bash
cd hadoop-v2-production
sudo docker compose up -d --build
sudo docker compose ps
```

## Initialize HDFS

Run this once after the core Hadoop services are healthy:

```bash
sudo docker exec -it namenode bash /opt/bootstrap/scripts/init-hdfs.sh
```

That command will:
- create `/tmp`
- create `/user/hive/warehouse`
- create `/spark-logs`
- upload `datasets/sales.csv` into HDFS at `/input/sales.csv`

## Test MapReduce

```bash
sudo docker exec -it namenode bash /opt/bootstrap/scripts/run-mapreduce-wordcount.sh
```

Expected result: a small wordcount output printed to the terminal.

## Test Spark

```bash
sudo docker exec -it spark-master bash /opt/bootstrap/scripts/run-spark-pi.sh
```

## Use Jupyter

Open:

```text
http://YOUR_UBUNTU_IP:8888
```

Token:

```text
bigdata123
```

Inside Jupyter, you can use `notebooks/pyspark_sales_demo.py` as a starter.

## Hive check

```bash
sudo docker exec -it hiveserver2 bash
beeline -u jdbc:hive2://localhost:10000
```

Then inside Beeline:

```sql
SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS demo;
USE demo;
CREATE EXTERNAL TABLE IF NOT EXISTS sales (
  order_id INT,
  order_date STRING,
  region STRING,
  product STRING,
  category STRING,
  quantity INT,
  unit_price INT,
  total_amount INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/input';
```

## Main URLs

- NameNode: `http://YOUR_UBUNTU_IP:9870`
- ResourceManager: `http://YOUR_UBUNTU_IP:8088`
- JobHistory: `http://YOUR_UBUNTU_IP:19888`
- Spark Master: `http://YOUR_UBUNTU_IP:8080`
- Spark Worker 1: `http://YOUR_UBUNTU_IP:8081`
- Spark Worker 2: `http://YOUR_UBUNTU_IP:8082`
- Jupyter: `http://YOUR_UBUNTU_IP:8888`

## Stop and clean

Stop:

```bash
sudo docker compose down
```

Stop and remove volumes:

```bash
sudo docker compose down -v
```

## Notes

- This is a strong lab / PoC stack, not a hardened enterprise HA production cluster.
- Hive and Hadoop image downloads rely on Apache mirrors at build time.
- If memory is low, reduce the number of workers or increase Docker host RAM.
- If Jupyter healthcheck fails at first boot, wait a little longer and re-check because notebook startup can take longer on slower hosts.
