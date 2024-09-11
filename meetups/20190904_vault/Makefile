.PHONY: build-vault clean shit run-mysql run-vault

build-vault:
	docker build -t boris/vault-meetup:latest -f vault/Dockerfile ./vault

clean:
	docker stop vault-meetup
	docker stop vault-mysql

shit:
	docker stop vault-meetup
	docker stop vault-mysql
	rm init.txt
	sudo rm -rf $(PWD)/vault/data
	sudo rm -rf $(PWD)/mysql/data

run-mysql:
	docker run -P -d --rm \
	    -e MYSQL_ROOT_PASSWORD=supersecret \
	    -v $(PWD)/mysql/data:/var/lib/mysql \
	    --name vault-mysql \
	    mysql:5.7

run-vault:
	docker run -P -d --rm \
	    -v $(PWD)/vault/data:/vault/file \
	    --name vault-meetup \
	    boris/vault-meetup:latest
	@echo "Remember to check vault port and export VAULT_ADDR!!"

