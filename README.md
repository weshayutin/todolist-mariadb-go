# New sample app for OADP

* I'll note most of this was lifted from:
https://github.com/sdil/learning/blob/master/go/todolist-mysql-go/todolist.go


## Local Setup

* Get mariadb running

```
docker/podman run -d -p 3306:3306 --name mariadb -e MYSQL_ROOT_PASSWORD=root mariadb
docker/podman exec -it mariadb mariadb -uroot -proot -e 'CREATE DATABASE todolist'

```

* Get the app running

```
go mod tidy
go run todolist.go

```

