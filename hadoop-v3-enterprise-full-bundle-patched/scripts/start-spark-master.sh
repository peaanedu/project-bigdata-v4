#!/bin/bash
set -e
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
mkdir -p /opt/spark/logs
cp -f /opt/bootstrap/spark-conf/* $SPARK_HOME/conf/ 2>/dev/null || true

echo "Starting Spark Master..."
exec $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master --host spark-master --port 7077 --webui-port 8080
