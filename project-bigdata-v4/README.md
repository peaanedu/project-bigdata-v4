# Enterprise Big Data Lab v4.1 (full Hadoop cluster compose)

This pack extends the earlier v4 starter into a full Docker Compose stack with:
- HDFS: NameNode, SecondaryNameNode, 2 DataNodes
- YARN: ResourceManager, 2 NodeManagers, HistoryServer
- Hive 4.1.0: Metastore + HiveServer2
- Trino 472
- PostgreSQL metastore database
- Spark 3.5.1 master/worker
- Jupyter PySpark notebook

## What was verified before building this pack
- `apache/hadoop` is an actively maintained official Apache Docker image and recent tags such as `3.4.3` and `3.5.0` are available on Docker Hub.
- `apache/hive` official tags include `4.1.0` and `standalone-metastore-4.1.0`.
- Trino current docs require HDFS-backed catalogs to enable `fs.hadoop.enabled=true`.

## Important honesty note
This pack is verified for image/tag availability and current configuration direction, but I did not execute Docker inside this chat environment. So this is the strongest safe deliverable I can provide here: a production-style compose and config set aligned to current images and docs.

## Quick start
```bash
cp .env.example .env
docker compose up -d
./scripts/init-hdfs.sh
./scripts/check-stack.sh
```

## Expected service URLs
- NameNode: http://localhost:9870
- YARN ResourceManager: http://localhost:8088
- MapReduce HistoryServer: http://localhost:19888
- HiveServer2: localhost:10000
- Trino: http://localhost:8081
- Spark Master UI: http://localhost:8080
- Spark Worker UI: http://localhost:8082
- Jupyter: http://localhost:8888
