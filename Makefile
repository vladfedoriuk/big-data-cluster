all: build-hadoop-base

build-hadoop-base:
	docker build -t hadoop-base --target hadoop-base hadoop

build-spark-base:
	docker build -t spark-base --target spark-base spark