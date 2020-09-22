all:
	docker build -t test .
	docker run --name=testing -p 5000:5000 -d test:latest

clean:
	docker stop testing
	docker rm testing
	docker rmi test:latest

exec:
	docker exec -u 0 -it testing /bin/sh

show:
	docker ps -a
	docker images -a

logs:
	docker logs testing

connect:
	xdg-open http://localhost:5000
