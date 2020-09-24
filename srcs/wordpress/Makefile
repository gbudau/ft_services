all:
	docker build -t wp-test .
	docker run --name=wordpress -p 5050:5050 -d wp-test:latest

clean:
	docker stop wordpress
	docker rm wordpress
	docker rmi wp-test:latest

exec:
	docker exec -u 0 -it wordpress /bin/sh

show:
	docker ps -a
	docker images -a

logs:
	docker logs wordpress

connect:
	xdg-open http://localhost:5050
