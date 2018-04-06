package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	vision "cloud.google.com/go/vision/apiv1"
	"golang.org/x/net/context"
)

func main() {
	flag.Parse()
	args := flag.Args()
	if len(args) != 1 {
		fmt.Fprintln(os.Stderr, "Usage: ./ocr <FILE>")
		os.Exit(1)
	}

	ctx := context.Background()
	client, err := vision.NewImageAnnotatorClient(ctx)
	if err != nil {
		log.Fatalf("Failed to create client: %v", err)
	}

	filename := args[0]
	file, err := os.Open(filename)
	if err != nil {
		log.Fatalf("Failed to read file: %v", err)
	}
	image, err := vision.NewImageFromReader(file)
	if err != nil {
		log.Fatalf("Failed to create image: %v", err)
	}
	file.Close()

	text, err := client.DetectDocumentText(ctx, image, nil)
	if err != nil {
		log.Fatalf("Failed to detect document text: %v", err)
	}
	fmt.Println(text.Text)
}
