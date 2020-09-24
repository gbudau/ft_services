all:
	docker build -t mysql-test .
	docker run --name=mysql -e MYSQL_ROOT_PASSWORD=password -e DATABASE_USER=dbuser -e DATABASE_USER_PASSWORD=dbuserpassword -e PMA_USER_DATABASE_PASSWORD=pmapassword -p 3306:3306 -d mysql-test:latest

clean:
	docker stop mysql
	docker rm mysql
	docker rmi mysql-test:latest

exec:
	docker exec -u 0 -it mysql /bin/sh

show:
	docker ps -a
	docker images -a

logs:
	docker logs mysql
