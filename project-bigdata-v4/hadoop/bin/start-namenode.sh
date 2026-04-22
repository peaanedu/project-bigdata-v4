#!/usr/bin/env bash
set -euo pipefail
mkdir -p /data/hdfs/name /opt/hadoop/logs
if [ ! -f /data/hdfs/name/current/VERSION ]; then
  hdfs namenode -format -force -nonInteractive
fi
hdfs --daemon start namenode
while true; do sleep 30; done
