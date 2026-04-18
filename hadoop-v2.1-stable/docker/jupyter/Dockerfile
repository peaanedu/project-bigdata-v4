FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PYSPARK_PYTHON=python3 \
    PYSPARK_DRIVER_PYTHON=jupyter

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl netcat-openbsd openjdk-17-jre-headless tini procps \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    jupyterlab \
    pyspark==3.5.2 \
    pyhive thrift thrift-sasl sasl pandas pyarrow findspark

RUN mkdir -p /workspace /opt/hadoop-conf
WORKDIR /workspace

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bash", "-lc", "jupyter lab --ServerApp.token=${JUPYTER_TOKEN:-bigdata123} --ServerApp.allow_origin='*' --ip=0.0.0.0 --port=8888 --no-browser --ServerApp.root_dir=/workspace"]
