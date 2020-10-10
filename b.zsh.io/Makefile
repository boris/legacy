include make_env

.PHONY: build deploy push

build:
	docker build -t boris/web:$(TAG) -f Dockerfile .

push:
	docker save boris/web:${TAG} | ssh -C moby docker load

deploy:
	ssh moby docker stop boris-web ; \
		ssh moby docker run --rm -d --name boris-web -p 5000:5000 boris/web:dev
