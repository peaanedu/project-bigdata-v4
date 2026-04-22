#!/usr/bin/env bash
set -euo pipefail
mkdir -p /data/mapred/history /opt/hadoop/logs
sleep 20
mapred --daemon start historyserver
while true; do sleep 30; done
