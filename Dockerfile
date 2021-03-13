FROM golang:alpine as golang
WORKDIR /go/src/full
COPY main.go .
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go mod init
RUN go build -ldflags '-w -s' -a -installsuffix cgo -o cycle

FROM scratch
COPY --from=golang /go/src/full/cycle ./fullcycle
ENTRYPOINT ["./fullcycle"]