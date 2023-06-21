all: build-hadoop-base

build-hadoop-base:
	docker build -t hadoop-base --target hadoop-base hadoop

build-spark-base:
	docker build -t spark-base --target spark-base spark

create-test-topic:
	docker compose exec broker \
  		kafka-topics --create \
		--topic test \
		--bootstrap-server localhost:9092 \
		--replication-factor 1 \
		--partitions 1