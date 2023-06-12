#!/bin/bash

# Fail on error
set -euo pipefail

# Make hadoop configuration files available to Spark
export SPARK_DIST_CLASSPATH="$($HADOOP_HOME/bin/hadoop classpath)"

# Load Spark environment variables
."${SPARK_HOME}/sbin/spark-config.sh"
."${SPARK_HOME}/bin/load-spark-env.sh"

# If SPARK_MASTER_HOST is unset then set it to the container's hostname
: ${SPARK_MASTER_HOST:=$(hostname -f)}

# If SPARK_MASTER_PORT is unset then set it to 7077
: ${SPARK_MASTER_PORT:=7077}

# If SPARK_MASTER_WEBUI_PORT is unset then set it to 8080
: ${SPARK_MASTER_WEBUI_PORT:=8080}

# If SPARK_MASTER_LOG is unset then set it to ${SPARK_HOME}/logs
: ${SPARK_MASTER_LOG:="${SPARK_HOME}/logs"}

# Create the Spark logs directory
mkdir -p "${SPARK_MASTER_LOG}"

# Create a symbolic link to the Spark logs
ln -sf /dev/stdout "${SPARK_MASTER_LOG}/spark-master.out"

# Start Spark Master
"${SPARK_HOME}/bin/spark-class" org.apache.spark.deploy.master.Master \
    --host $SPARK_MASTER_HOST \
    --port $SPARK_MASTER_PORT \
    --webui-port $SPARK_MASTER_WEBUI_PORT >> "${SPARK_MASTER_LOG}/spark-master.out"