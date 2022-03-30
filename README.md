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
```
* Update the db for a local connection:
HERE: https://github.com/weshayutin/todolist-mariadb-go/blob/main/todolist.go#L44

```
var db, _ = gorm.Open("mysql", "root:root@tcp/todolist?charset=utf8&parseTime=True")

```

Execute:
```
go run todolist.go
```

Initial Page should have two entries, one complete and one incomplete.

![gnome-shell-screenshot-edww3e](https://user-images.githubusercontent.com/138787/160934609-a77798a1-3986-46a0-a334-a8b53ceccb7d.png)


