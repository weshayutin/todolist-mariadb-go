#!/usr/bin/bash
rm -Rf BUILD/amd64/*
GOOS=linux GOARCH=amd64 go build -o BUILD/amd64/todolist-linux-amd64 .
cp -rv resources BUILD/amd64/
cp -v favicon.ico BUILD/amd64/
cp -v index.html BUILD/amd64/
zip -r BUILD/amd64/todolist-linux-amd64.zip BUILD/amd64/*
echo "done"
