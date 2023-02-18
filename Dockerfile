FROM golang:1.20.1-alpine3.17 AS builder

RUN apk update
RUN apk add git
RUN git clone https://github.com/FiloSottile/mkcert --depth=1 mkcert
WORKDIR ./mkcert
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o app .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /go/mkcert/app /mkcert
CMD ["/mkcert"]

