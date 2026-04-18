# Hadoop v2.1 Stable for Docker on Ubuntu

This package is a hardened refresh of the earlier v2 build.

## What changed
- Hadoop upgraded and pinned to **3.5.0**
- Java **17** used for Hadoop services
- Broken direct download steps replaced with retryable `wget` + `curl` fallback
- Apache mirror path centralized with `APACHE_MIRROR` in `.env`
- Core Hadoop services start by default
- Spark, Hive, PostgreSQL, and Jupyter moved behind the optional `analytics` profile so a core Hadoop cluster can build even if analytics components are not needed
- Jupyter image simplified to `python:3.11-slim` + `pyspark==3.5.2` instead of relying on a notebook tag that may vary over time

## Official version basis
- Hadoop 3.5.0 is the first stable release of the Hadoop 3.5 line.
- Hadoop 3.5.0 requires Java 17 on the server side.
- Spark 3.5.2 is a stable maintenance release in the 3.5 branch.

## Project layout
- `docker-compose.yml` : cluster definition
- `.env` : version pins and settings
- `docker/hadoop-base` : base image for HDFS/YARN/MapReduce
- `docker/spark` : optional Spark image
- `docker/hive` : optional Hive image
- `docker/jupyter` : optional Jupyter + PySpark image
- `conf/` : Hadoop configuration
- `scripts/` : startup and helper scripts

## Start core Hadoop only
```bash
docker compose up -d --build
```

## Start full stack including Spark + Hive + Jupyter
```bash
docker compose --profile analytics up -d --build
```

## Initialize HDFS
```bash
docker exec -it namenode bash /opt/bootstrap/scripts/init-hdfs.sh
```

## Run MapReduce wordcount
```bash
docker exec -it namenode bash /opt/bootstrap/scripts/run-mapreduce-wordcount.sh
```

## Web UIs
- NameNode: `http://YOUR_SERVER_IP:9870`
- ResourceManager: `http://YOUR_SERVER_IP:8088`
- JobHistory: `http://YOUR_SERVER_IP:19888`
- Spark Master (analytics profile): `http://YOUR_SERVER_IP:8080`
- Jupyter (analytics profile): `http://YOUR_SERVER_IP:8888`

## If archive access is blocked
Change `.env` and set `APACHE_MIRROR` to another reachable Apache mirror path that contains the same release files.

## Notes
This package improves stability of the build logic, but you may still need host-specific adjustments for Docker memory, open ports, or DNS reachability on your Ubuntu server.
