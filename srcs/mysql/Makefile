all:
	docker build -t my-mysql .
	docker run --name=test-mysql -e MYSQL_ROOT_PASSWORD=password -e DATABASE_USER=dbuser -e DATABASE_USER_PASSWORD=dbuserpassword -e PMA_USER_DATABASE_PASSWORD=pmapassword -p 3306:3306 -d my-mysql:latest

clean:
	docker stop test-mysql
	docker rm test-mysql
	docker rmi my-mysql:latest

exec:
	docker exec -u 0 -it test-mysql /bin/sh

show:
	docker ps -a
	docker images -a

logs:
	docker logs test-mysql
