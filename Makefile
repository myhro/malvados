BINARY_FOLDER := ./dist

build:
	go build -o $(BINARY_FOLDER)/ocr ./cmd/ocr

clean:
	rm -rf $(BINARY_FOLDER)
