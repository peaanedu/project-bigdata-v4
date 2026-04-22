#!/usr/bin/env bash
set -euo pipefail
mkdir -p /data/yarn/local /data/yarn/log /opt/hadoop/logs
sleep 20
yarn --daemon start nodemanager
while true; do sleep 30; done
