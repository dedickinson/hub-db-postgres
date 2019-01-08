
.PHONY: default build run stop install disable clean

IMAGE_NAME = hub-db-postgres
CONTAINER_NAME = postgres
VOLUME_NAME = postgres-data
SERVICE_NAME = postgres.service

default: build

build:
	docker volume create $(VOLUME_NAME)
	docker build -t $(IMAGE_NAME) .

run: build
	docker run -d --rm --volume $(VOLUME_NAME):/var/lib/postgresql/data -p 5432:5432 --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)

install: build
	sudo cp $(SERVICE_NAME) /etc/systemd/system/
	sudo systemctl enable $(SERVICE_NAME)

disable:
	sudo systemctl disable $(SERVICE_NAME)

clean: stop disable
	docker rmi $(IMAGE_NAME)
	sudo rm /etc/systemd/system/$(SERVICE_NAME)
	echo "I don't delete the $(VOLUME_NAME) volume"
