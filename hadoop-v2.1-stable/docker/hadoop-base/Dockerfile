ARG HADOOP_VERSION=3.5.0
FROM eclipse-temurin:17-jre-jammy

ARG HADOOP_VERSION
ARG APACHE_MIRROR=https://archive.apache.org/dist

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/opt/java/openjdk \
    HADOOP_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    YARN_CONF_DIR=/opt/hadoop/etc/hadoop \
    PATH=/opt/hadoop/bin:/opt/hadoop/sbin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl wget ca-certificates procps netcat-openbsd python3 python3-pip tini rsync openssh-client libsnappy1v5 \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    HADOOP_URL="${APACHE_MIRROR}/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"; \
    wget --tries=5 --timeout=30 -O /tmp/hadoop.tgz "$HADOOP_URL" \
      || curl -fL --retry 5 --retry-delay 5 "$HADOOP_URL" -o /tmp/hadoop.tgz; \
    tar -xzf /tmp/hadoop.tgz -C /opt; \
    mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop; \
    rm -f /tmp/hadoop.tgz

RUN mkdir -p /hadoop/dfs/name /hadoop/dfs/data /opt/bootstrap/conf /opt/bootstrap/scripts /opt/bootstrap/spark-conf /opt/hadoop/logs \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export HDFS_NAMENODE_USER=root' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export HDFS_DATANODE_USER=root' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export HDFS_SECONDARYNAMENODE_USER=root' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export YARN_RESOURCEMANAGER_USER=root' >> /opt/hadoop/etc/hadoop/yarn-env.sh \
    && echo 'export YARN_NODEMANAGER_USER=root' >> /opt/hadoop/etc/hadoop/yarn-env.sh \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/yarn-env.sh \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/mapred-env.sh \
    && echo 'export HADOOP_MAPRED_HOME=/opt/hadoop' >> /opt/hadoop/etc/hadoop/mapred-env.sh

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
