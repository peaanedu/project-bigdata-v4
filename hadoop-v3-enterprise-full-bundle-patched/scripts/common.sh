#!/bin/bash
set -e

export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
export JAVA_HOME=/opt/java/openjdk
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

mkdir -p /opt/hadoop/logs
mkdir -p /hadoop/dfs/name /hadoop/dfs/data

cp -f /opt/bootstrap/conf/* $HADOOP_HOME/etc/hadoop/ 2>/dev/null || true
