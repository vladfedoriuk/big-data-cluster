# Big Data Cluster

A big data cluster using Hadoop and Spark.

## Set up

- To set up the cluster, run the following command:
```shell
docker-compose up -d
```

- To use the HDFS Web UI, go to http://localhost:9870
- **Note**: The HDFS Web UI may take a few minutes to start up.
- To use the file-browser, add the following to `/etc/hosts`
```shell
127.0.0.1       namenode
127.0.0.1       datanode1
127.0.0.1       datanode2
```
- To use the Spark Web UI, go to http://localhost:8080

## Jupyter Notebook

- To use the Jupyter Notebook, go to the logs of the `jupyter-notebook` container and follow the URL with the token.
```shell
docker logs jupyter-notebook
```
- There are some example notebooks in the `worspace` directory.
- It is possible to use `PySpark` in the Jupyter Notebook.

## Kafka

- The Kafka broker is available at `localhost:9092`. Docker compose is used to set up the Kafka broker
and the Zookeeper server with replication factor of 1.
- To create a topic, run the following command:
```shell
make create-test-topic
```