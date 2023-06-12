#!/bin/bash

# Fail on error
set -euo pipefail

# Make hadoop configuration files available to Spark
export SPARK_DIST_CLASSPATH="$($HADOOP_HOME/bin/hadoop classpath)"

# Load Spark environment variables
."${SPARK_HOME}/sbin/spark-config.sh"
."${SPARK_HOME}/bin/load-spark-env.sh"

# If SPARK_WORKER_WEBUI_PORT is unset then set it to 8081
: ${SPARK_WORKER_WEBUI_PORT:=8081}

# If SPARK_WORKER_LOG is unset then set it to ${SPARK_HOME}/logs

: ${SPARK_WORKER_LOG:="${SPARK_HOME}/logs"}

# Create the Spark logs directory
mkdir -p "${SPARK_WORKER_LOG}"

# Create a symbolic link to the Spark logs
ln -sf /dev/stdout "${SPARK_WORKER_LOG}/spark-worker.out"

# Start Spark Worker
"${SPARK_HOME}/bin/spark-class" org.apache.spark.deploy.worker.Worker \
    --webui-port $SPARK_WORKER_WEBUI_PORT \
    "$SPARK_MASTER" >> "${SPARK_WORKER_LOG}/spark-worker.out"