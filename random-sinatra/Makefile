include make_env

NS ?= boris
TAG ?= latest

IMAGE_NAME = pwgen-web

.PHONY: build push run stop login

build:
	docker build -t $(NS)/$(IMAGE_NAME):$(TAG) -f Dockerfile .

push:
	docker push $(NS)/$(IMAGE_NAME):$(TAG)

run:
	docker run -P -d --rm --name pwgen-local-dev $(NS)/$(IMAGE_NAME):$(TAG)
	docker logs --follow pwgen-local-dev

stop:
	docker stop pwgen-local-dev

login:
	docker login
