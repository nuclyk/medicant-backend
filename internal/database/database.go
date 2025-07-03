package database

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/tursodatabase/libsql-client-go/libsql"
)

// use this driver for local dev
//_ "github.com/tursodatabase/go-libsql"

type Client struct {
	db  *sql.DB
	log *log.Logger
}

func NewClient(url string) (Client, error) {
	log.Println("Creating new database client")
	dbLog := log.New(os.Stdout, "db:", log.Lshortfile)

	db, err := sql.Open("libsql", url)

	if err != nil {
		fmt.Fprintf(os.Stderr, "failed to open db %s", err)
		os.Exit(1)
	}

	if err != nil {
		return Client{}, err
	}

	c := Client{db, dbLog}

	return c, nil
}
