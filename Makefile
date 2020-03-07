BINARY_FOLDER := ./dist
IMPORT_FOLDER := ./cmd/import


build:
	go build -o $(BINARY_FOLDER)/ocr ./cmd/ocr
	go build -o $(BINARY_FOLDER)/import $(IMPORT_FOLDER)

clean:
	rm -rf $(BINARY_FOLDER)

import:
	go run $(IMPORT_FOLDER)
