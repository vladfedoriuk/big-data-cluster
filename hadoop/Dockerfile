FROM ubuntu:22.10 as hadoop-base

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -y && \
    apt-get install -y  \
    --no-install-recommends \
    --no-install-suggests \
    curl \
    wget \
    gnupg \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    openjdk-11-jdk \
    python3 \
    python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Set Hadoop-related environment variables
ENV HADOOP_HOME=/opt/hadoop/hadoop-3.3.5
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV MULTIHOMED_NETWORK=1

#  Download and install Hadoop
RUN set -eux && \
    curl -O https://dlcdn.apache.org/hadoop/common/KEYS && \
    gpg --import KEYS \
    && rm KEYS \
    && mkdir -p /opt/hadoop \
    && curl -O https://dlcdn.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz \
    && curl -O https://dlcdn.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz.asc \
    && gpg --verify hadoop-3.3.5.tar.gz.asc hadoop-3.3.5.tar.gz \
    && tar -xvf hadoop-3.3.5.tar.gz -C /opt/hadoop \
    && rm hadoop-3.3.5.tar.gz*

# Create a hadoop tmp dir
RUN mkdir -p /hadoop && \
    chmod 777 /hadoop

# Copy the configuration files
COPY [ "conf/core-site.xml", "conf/hdfs-site.xml", "$HADOOP_CONF_DIR/" ]

FROM hadoop-base as hadoop-namenode

# Format the namenode
RUN $HADOOP_HOME/bin/hdfs namenode -format

# Expose ports for the namenode web UI and namenode
EXPOSE 9870 9000

# Start the namenode
ENTRYPOINT $HADOOP_HOME/bin/hdfs namenode


FROM hadoop-base as hadoop-datanode

# Expose port for the datanode
EXPOSE 9864

# Start the datanode
ENTRYPOINT $HADOOP_HOME/bin/hdfs datanode



