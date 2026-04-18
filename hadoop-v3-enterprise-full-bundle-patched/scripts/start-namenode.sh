#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

if [ ! -d "/hadoop/dfs/name/current" ]; then
  echo "Formatting NameNode..."
  hdfs namenode -format -force -nonInteractive
fi

echo "Initializing HDFS in background..."
(
  for i in $(seq 1 30); do
    if curl -fsS http://localhost:9870/ >/dev/null 2>&1; then
      bash /opt/bootstrap/scripts/init-hdfs.sh || true
      exit 0
    fi
    sleep 2
  done
) &

echo "Starting NameNode in foreground..."
exec hdfs namenode
