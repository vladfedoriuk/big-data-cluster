#!/bin/bash

# Fail on error
set -euo pipefail

# Make hadoop configuration files available to Spark
export SPARK_DIST_CLASSPATH="$($HADOOP_HOME/bin/hadoop classpath)"

# Load Spark environment variables
."${SPARK_HOME}/sbin/spark-config.sh"
."${SPARK_HOME}/bin/load-spark-env.sh"

# Run the jupyter lab server
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root