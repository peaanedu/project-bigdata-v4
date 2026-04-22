#!/usr/bin/env bash
set -euo pipefail
mkdir -p /opt/hadoop/logs
sleep 15
yarn --daemon start resourcemanager
while true; do sleep 30; done
