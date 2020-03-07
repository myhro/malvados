package storage

import (
	"database/sql"
	"fmt"
	"os"

	"github.com/jmoiron/sqlx"
	// Load Postgres driver
	_ "github.com/lib/pq"
)

// DB is an interface to make database handlers more flexible
type DB interface {
	Exec(query string, args ...interface{}) (sql.Result, error)
	Get(dest interface{}, query string, args ...interface{}) error
	Select(dest interface{}, query string, args ...interface{}) error
}

// NewDB creates a Postgres database handler
func NewDB() (*sqlx.DB, error) {
	conn := os.Getenv("POSTGRES_CONN")
	if conn == "" {
		conn = "dbname=malvados sslmode=disable"
	}

	db, err := sqlx.Open("postgres", conn)
	if err != nil {
		return nil, fmt.Errorf("sqlx error: %w", err)
	}

	return db, nil
}
