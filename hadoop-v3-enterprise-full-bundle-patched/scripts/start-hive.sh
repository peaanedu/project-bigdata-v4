#!/bin/bash
set -e
source /opt/bootstrap/scripts/common.sh

export HIVE_HOME=/opt/hive
export PATH=$PATH:$HIVE_HOME/bin
cp -f /opt/hive/conf/* $HIVE_HOME/conf/ 2>/dev/null || true

until nc -z postgres 5432; do
  echo "Waiting for postgres:5432..."
  sleep 5
done

case "${SERVICE_NAME}" in
  metastore)
    echo "Initializing Hive schema if needed..."
    schematool -dbType postgres -initSchema || true
    echo "Starting Hive Metastore..."
    exec hive --service metastore
    ;;
  hiveserver2)
    until nc -z hive-metastore 9083; do
      echo "Waiting for hive-metastore:9083..."
      sleep 5
    done
    echo "Starting HiveServer2..."
    exec hiveserver2
    ;;
  *)
    echo "Unknown SERVICE_NAME=${SERVICE_NAME}"
    exit 1
    ;;
esac
