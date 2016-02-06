.PHONY: build clean start stop remove_images clean pgcli
default: start

start:
	docker-compose up -d

stop:
	docker-compose stop && docker-compose rm -f

# build images from Dockerfiles
build:
	docker build -t navi7/jupyter -f Dockerfile.jupyter .
	docker build -t navi7/pgcli -f Dockerfile.python .

pgcli:
	docker run -it --link alchemist_alchemist_db_1:alchemist_db navi7/pgcli pgcli -h alchemist_db -U alchemist

# remove built images
remove_images:
	docker rmi navi7/jupyter

# remove stopped containers
clean:
	docker rm `docker ps -a | grep jupyter | awk -- { print $3 }`
