FROM golang:1.14-alpine AS builder

RUN apk add make upx
WORKDIR /app
COPY . /app
RUN make deps
RUN make build
RUN upx .bin/migrate dist/*

FROM alpine:latest

RUN apk add make

WORKDIR /app

COPY --from=builder /app/dist/* /app/
COPY --from=builder /app/.bin/migrate /app/.bin/

COPY ./Makefile /app/Makefile
COPY ./data /app/data
COPY ./sql /app/sql
