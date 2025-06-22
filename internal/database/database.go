package database

import (
	"database/sql"
	"log"
	"os"

	_ "github.com/mattn/go-sqlite3"

	"github.com/nuclyk/medicant/internal/auth"
)

type Client struct {
	db  *sql.DB
	log *log.Logger
}

func NewClient(pathToDB string) (Client, error) {
	log.Println("Creating new database client")

	db, err := sql.Open("sqlite3", pathToDB)
	if err != nil {
		return Client{}, err
	}

	dbLog := log.New(os.Stdout, "db:", log.Lshortfile)
	c := Client{db, dbLog}

	err = c.createAdmin()
	if err != nil {
		return Client{}, err
	}

	return c, nil
}

const createAdmin = `
	INSERT OR IGNORE INTO users ( id, first_name, last_name, password, email,
		phone, gender, nationality, role, retreat_id, check_in_date, leave_date
	  )
	VALUES
	  (
		"00000000-0000-0000-0000-000000000000", "", "", ?,
		"admin@papae.com", "", "", "", "admin", "0", "", ""
	  );
	`

func (c Client) createAdmin() error {
	password, _ := auth.HashPassword("1234")
	_, err := c.db.Exec(createAdmin, password)
	return err
}
