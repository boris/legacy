include make_env

NS ?= boris
TAG ?= latest

IMAGE_NAME = <image>

.PHONY: build login push

build:
	docker build -t $(NS)/$(IMAGE_NAME):$(TAG) -f Dockerfile .

login:
	$(aws ecr get-login --no-include-email)

push:
	docker push $(NS)/$(IMAGE_NAME):$(TAG)
