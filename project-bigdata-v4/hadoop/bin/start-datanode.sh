#!/usr/bin/env bash
set -euo pipefail
mkdir -p /data/hdfs/data /opt/hadoop/logs
sleep 10
hdfs --daemon start datanode
while true; do sleep 30; done
