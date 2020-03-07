package main

import (
	"io/ioutil"
	"log"

	"github.com/myhro/malvados/storage"
	"github.com/nleof/goyesql"
)

func main() {
	db, err := storage.NewDB()
	if err != nil {
		log.Fatal(err)
	}

	queries, err := goyesql.ParseFile("sql/comic.sql")
	if err != nil {
		log.Fatal(err)
	}

	content, err := ioutil.ReadFile("data/malvados.json")
	if err != nil {
		log.Fatal(err)
	}

	_, err = db.Exec(queries["import-json"], string(content))
	if err != nil {
		log.Fatal(err)
	}
}
