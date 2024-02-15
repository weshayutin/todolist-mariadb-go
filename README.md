# New sample app for OADP

* I'll note most of this was lifted from:
https://github.com/sdil/learning/blob/master/go/todolist-mysql-go/todolist.go


## Local Setup

* Get mariadb running

```
docker/podman run -d -p 3306:3306 --name mariadb -e MYSQL_ROOT_PASSWORD=root mariadb
docker/podman exec -it mariadb mariadb -uroot -proot -e 'CREATE DATABASE todolist'

```
### Note: Mariadb password settings:
* localhost
```
dsn := "test:test@tcp(127.0.0.1:3306)/todolist?charset=utf8mb4&parseTime=True&loc=Local"
```
* As deployed on OpenShift with templates
```
dsn := "changeme:changeme@tcp(mysql:3306)/todolist?charset=utf8mb4&parseTime=True&loc=Local"
```


* Get the app running

```
go mod tidy
```

Execute:
```
go run todolist.go
```

Navigate your browser to:
 * http://localhost:8000
 * http://fqdn

Show items in the db:
```
Server version: 10.5.9-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| test               |
| todolist           |
+--------------------+
5 rows in set (0.001 sec)

MariaDB [(none)]> use todolist;
Database changed
MariaDB [todolist]> show tables;
+--------------------+
| Tables_in_todolist |
+--------------------+
| todo_item_models   |
+--------------------+
1 row in set (0.001 sec)

MariaDB [todolist]> select * from todo_item_models;
+----+-------------------------+-----------+
| id | description             | completed |
+----+-------------------------+-----------+
|  1 | time to make the donuts |         0 |
|  2 | prepopulate the db      |         1 |
+----+-------------------------+-----------+
2 rows in set (0.000 sec)

MariaDB [todolist]>
```

![gnome-shell-screenshot-edww3e](https://user-images.githubusercontent.com/138787/160934609-a77798a1-3986-46a0-a334-a8b53ceccb7d.png)

## Deploy to OpenShift
```
oc create -f mysql-persistent-template.yaml
OR
oc create -f mysql-persistent-csi-template.yaml -f pvc/$cloud.yaml 
```

## testing
There are some basic curl and python tests in the tests directory where you can
see the api is exercised and the database is populated.
```
cd tests
python test.py
```

## building
Here's a quick example:
```
podman build  -t quay.io/rhn_engineering_whayutin/todolist-mariadb-go-2 .
podman push
```

## updates
* Note that the app will NO longer create two items in the the todo list at start up. 
