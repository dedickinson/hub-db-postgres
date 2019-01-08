
.PHONY: default build run

IMAGE_NAME = hub-db-postgres
CONTAINER_NAME = postgres
VOLUME_NAME = postgres-data

default: build

build:
	docker volume create $(VOLUME_NAME)
	docker build -t $(IMAGE_NAME) .

run: build
	docker run -d --rm --volume postgres-data:/var/lib/postgresql/data -p 5432:5432 --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)
