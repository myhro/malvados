package main

import (
	"log"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/myhro/malvados/storage"
)

func main() {
	db, err := storage.NewDB()
	if err != nil {
		log.Fatal(err)
	}

	handler, err := NewHandler(db)
	if err != nil {
		log.Fatal(err)
	}

	r := gin.Default()

	config := cors.DefaultConfig()
	config.AllowOrigins = []string{"*"}
	r.Use(cors.New(config))

	r.GET("/", handler.Search)

	port := ":8080"
	if gin.Mode() == gin.ReleaseMode {
		log.Printf("Starting server on port ", port)
	}
	r.Run(port)
}
