ARG HIVE_VERSION=4.0.1
ARG HADOOP_VERSION=3.5.0
FROM eclipse-temurin:17-jre-jammy

ARG HIVE_VERSION
ARG HADOOP_VERSION
ARG APACHE_MIRROR=https://archive.apache.org/dist
ARG POSTGRES_JDBC_VERSION=42.7.4

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/opt/java/openjdk \
    HIVE_HOME=/opt/hive \
    HADOOP_HOME=/opt/hadoop \
    HIVE_CONF_DIR=/opt/hive/conf \
    PATH=/opt/hive/bin:/opt/hadoop/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl wget ca-certificates netcat-openbsd postgresql-client procps tini python3 \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    HADOOP_URL="${APACHE_MIRROR}/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"; \
    HIVE_URL="${APACHE_MIRROR}/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz"; \
    wget --tries=5 --timeout=30 -O /tmp/hadoop.tgz "$HADOOP_URL" \
      || curl -fL --retry 5 --retry-delay 5 "$HADOOP_URL" -o /tmp/hadoop.tgz; \
    wget --tries=5 --timeout=30 -O /tmp/hive.tgz "$HIVE_URL" \
      || curl -fL --retry 5 --retry-delay 5 "$HIVE_URL" -o /tmp/hive.tgz; \
    tar -xzf /tmp/hadoop.tgz -C /opt; \
    tar -xzf /tmp/hive.tgz -C /opt; \
    mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop; \
    mv /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive; \
    rm -f /tmp/hadoop.tgz /tmp/hive.tgz

RUN wget --tries=5 --timeout=30 -O /opt/hive/lib/postgresql.jar https://jdbc.postgresql.org/download/postgresql-${POSTGRES_JDBC_VERSION}.jar \
      || curl -fL --retry 5 --retry-delay 5 https://jdbc.postgresql.org/download/postgresql-${POSTGRES_JDBC_VERSION}.jar -o /opt/hive/lib/postgresql.jar; \
    mkdir -p /opt/bootstrap/scripts /opt/hive/logs; \
    echo 'export JAVA_HOME=/opt/java/openjdk' >> /opt/hive/conf/hive-env.sh

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash"]
