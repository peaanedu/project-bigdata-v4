ARG HADOOP_VERSION=3.5.0
ARG SPARK_VERSION=3.5.2
FROM eclipse-temurin:17-jre-jammy

ARG HADOOP_VERSION
ARG SPARK_VERSION
ARG APACHE_MIRROR=https://archive.apache.org/dist

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/opt/java/openjdk \
    HADOOP_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    YARN_CONF_DIR=/opt/hadoop/etc/hadoop \
    SPARK_HOME=/opt/spark \
    PATH=/opt/hadoop/bin:/opt/hadoop/sbin:/opt/spark/bin:/opt/spark/sbin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl wget ca-certificates procps netcat-openbsd python3 tini rsync openssh-client libsnappy1v5 \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    HADOOP_URL="${APACHE_MIRROR}/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"; \
    SPARK_URL="${APACHE_MIRROR}/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz"; \
    wget --tries=5 --timeout=30 -O /tmp/hadoop.tgz "$HADOOP_URL" \
      || curl -fL --retry 5 --retry-delay 5 "$HADOOP_URL" -o /tmp/hadoop.tgz; \
    wget --tries=5 --timeout=30 -O /tmp/spark.tgz "$SPARK_URL" \
      || curl -fL --retry 5 --retry-delay 5 "$SPARK_URL" -o /tmp/spark.tgz; \
    tar -xzf /tmp/hadoop.tgz -C /opt; \
    tar -xzf /tmp/spark.tgz -C /opt; \
    mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop; \
    mv /opt/spark-${SPARK_VERSION}-bin-hadoop3 /opt/spark; \
    rm -f /tmp/hadoop.tgz /tmp/spark.tgz

RUN mkdir -p /opt/bootstrap/conf /opt/bootstrap/scripts /opt/bootstrap/spark-conf /opt/spark/logs /opt/hadoop/logs \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/hadoop-env.sh \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/yarn-env.sh \
    && echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hadoop/etc/hadoop/mapred-env.sh \
    && echo 'export HADOOP_MAPRED_HOME=/opt/hadoop' >> /opt/hadoop/etc/hadoop/mapred-env.sh \
    && echo 'export SPARK_DIST_CLASSPATH=$(/opt/hadoop/bin/hadoop classpath)' >> /opt/spark/conf/spark-env.sh

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
