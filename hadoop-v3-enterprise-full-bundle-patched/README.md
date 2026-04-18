# Hadoop v3 Enterprise Full Bundle - Patched

This patched bundle includes compatibility fixes for cleaner Docker builds on Ubuntu hosts.

## Main fixes
- Java base image changed from `openjdk:8-jdk` to `eclipse-temurin:8-jdk`
- Postgres init script no longer recreates the `metastore` database
- NameNode starts in foreground for more stable health detection
- NameNode healthcheck uses the HDFS web UI on port 9870
- Longer start periods for Hadoop, Hive, and Spark services

## Quick start
```bash
unzip hadoop-v3-enterprise-full-bundle-patched.zip
cd hadoop-v3-enterprise-full-bundle-patched
docker compose down -v
docker compose up -d --build
docker ps
```

## URLs
- HDFS UI: http://localhost:9870
- YARN UI: http://localhost:8088
- Job History: http://localhost:19888
- Spark Master: http://localhost:8080
- JupyterLab: http://localhost:8888
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

## Defaults
- Jupyter token: `bigdata123`
- Grafana: `admin / admin123`

## First troubleshooting commands
```bash
docker logs postgres-metastore
docker logs namenode
docker logs resourcemanager
docker logs hive-metastore
```
