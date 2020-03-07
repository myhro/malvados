package main

import (
	"fmt"
	"log"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/myhro/malvados/models"
	"github.com/myhro/malvados/storage"
	"github.com/nleof/goyesql"
)

type Handler struct {
	DB      storage.DB
	Queries goyesql.Queries
}

func NewHandler(db storage.DB) (*Handler, error) {
	queries, err := goyesql.ParseFile("sql/comic.sql")
	if err != nil {
		return nil, fmt.Errorf("goyesql error: %w", err)
	}

	handler := &Handler{
		DB:      db,
		Queries: queries,
	}

	return handler, nil
}

func queryToFTS(q string) string {
	words := strings.Fields(q)
	return strings.Join(words, " & ")
}

func (h *Handler) Search(c *gin.Context) {
	q := c.Query("q")
	if q == "" {
		body := gin.H{
			"error": "missing 'q' query parameter",
		}
		c.AbortWithStatusJSON(http.StatusBadRequest, body)
		return
	}
	q = queryToFTS(q)

	comics := []models.Comic{}
	err := h.DB.Select(&comics, h.Queries["search"], q)
	if err != nil {
		log.Print("DB.Select error: ", err)
		c.AbortWithStatus(http.StatusInternalServerError)
	}

	c.JSON(http.StatusOK, comics)
}
