#FROM golang:1.17.8-alpine
FROM registry.access.redhat.com/ubi8/ubi-minimal
USER root
RUN microdnf install -y golang vim
COPY resources/ /resources/
COPY index.html .
COPY app .
# dev
#WORKDIR /go/src/github.com/weshayutin/todolist-mariadb-go
#
#COPY ./ .
#
#RUN chmod -R 777 ./
#RUN go mod download

EXPOSE 8000
# use entrypoint for debug
#ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["./app"]
