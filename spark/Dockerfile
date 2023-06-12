FROM hadoop-base as spark-base

# Download and install Spark
RUN set -eux  && \
    mkdir -p /opt/spark && \
	curl -O https://dlcdn.apache.org/spark/spark-3.4.0/spark-3.4.0-bin-without-hadoop.tgz && \
	curl -O https://dlcdn.apache.org/spark/spark-3.4.0/spark-3.4.0-bin-without-hadoop.tgz.asc && \
	curl -O https://downloads.apache.org/spark/KEYS && \
	gpg --import KEYS && \
    rm KEYS && \
	gpg --verify spark-3.4.0-bin-without-hadoop.tgz.asc spark-3.4.0-bin-without-hadoop.tgz && \
	tar -xvf spark-3.4.0-bin-without-hadoop.tgz -C /opt/spark && \
	rm spark-3.4.0-bin-without-hadoop.tgz*

# Set Spark-related environment variables
ENV SPARK_HOME=/opt/spark/spark-3.4.0-bin-without-hadoop
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
ENV SPARK_LAUNCHER_OPTS="-Dio.netty.tryReflectionSetAccessible=true"

# Make the load-spark-env.sh and spark-config.sh scripts executable
RUN chmod +x $SPARK_HOME/bin/load-spark-env.sh && \
	chmod +x $SPARK_HOME/sbin/spark-config.sh


FROM spark-base as spark-master

# Copy the entrypoint script for the Spark master
COPY master/entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose ports for the Spark master web UI, Spark master, and Spark worker
EXPOSE 8080 7077 6066

# Start the Spark master
ENTRYPOINT [ "/entrypoint.sh" ]


FROM spark-base as spark-worker

# Copy the entrypoint script for the Spark worker
COPY worker/entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose port for the Spark worker web UI
EXPOSE 8081

# Start the Spark worker
ENTRYPOINT [ "/entrypoint.sh" ]


FROM spark-base as spark-jupyter

# Install JupyterLab
RUN set -eux && \
	pip3 install --no-cache-dir jupyterlab

# Create a directory for worskpace
RUN mkdir -p /opt/workspace

# Copy the entrypoint script for JupyterLab
COPY jupyter/entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose port for JupyterLab
EXPOSE 8888

WORKDIR /opt/workspace

# Start JupyterLab
ENTRYPOINT [ "/entrypoint.sh" ]


