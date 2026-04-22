#!/usr/bin/env bash
set -euo pipefail

docker compose exec namenode hdfs dfs -mkdir -p /tmp /tmp/hive /user/hive/warehouse /warehouse/tablespace/external/hive /data/raw /data/curated /spark-events /mr-history/tmp /mr-history/done
docker compose exec namenode hdfs dfs -chmod -R 777 /tmp /tmp/hive /user/hive/warehouse /warehouse /data /spark-events /mr-history
docker compose exec namenode hdfs dfs -ls /
