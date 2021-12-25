API_FOLDER := ./api
BINARY_FOLDER := ./dist
BUILD_FLAGS := -ldflags "-s -w"
IMAGE := myhro/malvados
IMPORT_FOLDER := ./cmd/import
MIGRATION_FOLDER := ./sql/migrations
POSTGRES_URL ?= postgres:///malvados?sslmode=disable
VERSION ?= $(shell git rev-parse --short HEAD)

export GOBIN := $(PWD)/.bin

.PHONY: api

api:
	go run $(API_FOLDER)

build:
	go build $(BUILD_FLAGS) -o $(BINARY_FOLDER)/api $(API_FOLDER)
	go build $(BUILD_FLAGS) -o $(BINARY_FOLDER)/import $(IMPORT_FOLDER)
	go build $(BUILD_FLAGS) -o $(BINARY_FOLDER)/ocr ./cmd/ocr

clean:
	rm -rf $(BINARY_FOLDER)

create:
	@$(GOBIN)/migrate create -dir $(MIGRATION_FOLDER) -ext sql -seq $(name)

deps:
	go install golang.org/x/lint/golint@latest
	go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@v4.15.1

destroy:
	@$(GOBIN)/migrate -database $(POSTGRES_URL) -path $(MIGRATION_FOLDER) down -all

docker:
	docker build -t $(IMAGE) .

import:
	go run $(IMPORT_FOLDER)

lint:
	@$(GOBIN)/golint -set_exit_status ./...

migrate:
	@$(GOBIN)/migrate -database $(POSTGRES_URL) -path $(MIGRATION_FOLDER) up

push:
	docker tag $(IMAGE):latest $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest
