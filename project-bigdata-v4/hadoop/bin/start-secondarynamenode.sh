#!/usr/bin/env bash
set -euo pipefail
mkdir -p /data/hdfs/namesecondary /opt/hadoop/logs
sleep 10
hdfs --daemon start secondarynamenode
while true; do sleep 30; done
