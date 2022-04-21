FROM --platform=$BUILDPLATFORM golang:1.17.8-alpine AS build-env

ARG TARGETOS
ARG TARGETARCH

ENV GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    GOARM=${TARGETVARIANT}

RUN mkdir /build
WORKDIR /build
COPY *.go .
COPY go.mod .
COPY go.sum .
RUN go mod download
RUN go mod tidy
RUN CGO_ENABLED=0 go build -v -a -installsuffix cgo -o app 

FROM scratch
COPY --from=build-env /build/app /app
COPY resources/ /resources/
COPY index.html .
EXPOSE 8000
# use entrypoint for debug
#ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["./app"]
