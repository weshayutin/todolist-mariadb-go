#FROM golang:1.17.8-alpine
FROM centos
COPY resources/ /resources/
COPY index.html .
COPY app .
COPY todolist.go .

EXPOSE 8000
# use entrypoint for debug
ENTRYPOINT ["tail", "-f", "/dev/null"]
#CMD ["./app"]
