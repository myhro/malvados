build:
	go build -o ocr ocr.go

clean:
	rm ocr

deps:
	dep ensure
