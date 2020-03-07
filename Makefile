API_FOLDER := ./api
BINARY_FOLDER := ./dist
IMPORT_FOLDER := ./cmd/import
MIGRATION_FOLDER := ./sql/migrations
POSTGRES_URL ?= postgres:///malvados?sslmode=disable

export GOBIN := $(PWD)/.bin

.PHONY: api

api:
	go run $(API_FOLDER)

build:
	go build -o $(BINARY_FOLDER)/api $(API_FOLDER)
	go build -o $(BINARY_FOLDER)/import $(IMPORT_FOLDER)
	go build -o $(BINARY_FOLDER)/ocr ./cmd/ocr

clean:
	rm -rf $(BINARY_FOLDER)

create:
	@$(GOBIN)/migrate create -dir $(MIGRATION_FOLDER) -ext sql -seq $(name)

deps:
	go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate

destroy:
	@$(GOBIN)/migrate -database $(POSTGRES_URL) -path $(MIGRATION_FOLDER) down -all

import:
	go run $(IMPORT_FOLDER)

migrate:
	@$(GOBIN)/migrate -database $(POSTGRES_URL) -path $(MIGRATION_FOLDER) up
