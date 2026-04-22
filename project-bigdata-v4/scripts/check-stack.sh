#!/usr/bin/env bash
set -euo pipefail

echo "== docker compose ps =="
docker compose ps

echo
echo "== HDFS report =="
docker compose exec namenode hdfs dfsadmin -report | sed -n '1,80p'

echo
echo "== YARN cluster info =="
curl -fsS http://localhost:8088/ws/v1/cluster/info | sed 's/,/,&\n/g' | head -40

echo
echo "== Trino /v1/info =="
curl -fsS http://localhost:8081/v1/info | sed 's/,/,&\n/g'

echo
echo "== Trino SHOW CATALOGS =="
docker compose exec trino trino --execute "SHOW CATALOGS;"

echo
echo "== Hive SHOW DATABASES =="
docker compose exec hiveserver2 beeline -u jdbc:hive2://localhost:10000 -n hive -e "SHOW DATABASES;"
