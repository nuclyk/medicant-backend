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
	dbLog := log.New(os.Stdout, "db:", log.Lshortfile)

	db, err := sql.Open("sqlite3", pathToDB)

	if err != nil {
		return Client{}, err
	}

	c := Client{db, dbLog}

	if err = c.createAdmin(); err != nil {
		return Client{}, err
	}

	return c, nil
}

const createAdmin = `
	INSERT
	OR IGNORE INTO users (
	  id,
	  first_name,
	  last_name,
	  password,
	  email,
	  phone,
	  gender,
	  nationality,
	  role,
	  retreat_id,
	  check_in_date,
	  leave_date
	)
	VALUES
	  (
		"00000000-0000-0000-0000-000000000000",
		"",
		"",
		?,
		"admin@papae.com",
		"",
		"",
		"",
		"admin",
		"0",
		"",
		""
	  );
	`

const createVolunteer = `
	INSERT
	OR IGNORE INTO users (
	  id,
	  first_name,
	  last_name,
	  password,
	  email,
	  phone,
	  gender,
	  nationality,
	  role,
	  retreat_id,
	  check_in_date,
	  leave_date
	)
	VALUES
	  (
		"00000000-0000-0000-0000-000000000001",
		"John",
		"Doe",
		?,
		"john@papae.com",
		"07098987876",
		"Male",
		"American",
		"volunteer",
		"0",
		"",
		""
	  );
	`

const createParticipant = `
	INSERT
	OR IGNORE INTO users (
	  id,
	  first_name,
	  last_name,
	  password,
	  email,
	  phone,
	  gender,
	  nationality,
	  role,
	  retreat_id,
	  check_in_date,
	  leave_date
	)
	VALUES
	  (
		"00000000-0000-0000-0000-000000000002",
		"Zak",
		"Moore",
		?,
		"zak@mail.com",
		"0987234987",
		"Male",
		"British",
		"participant",
		"0",
		"",
		""
	  );
	`

func (c Client) createAdmin() error {
	password, _ := auth.HashPassword("1234")
	_, err := c.db.Exec(createAdmin, password)

	if err != nil {
		return err
	}

	_, err = c.db.Exec(createVolunteer, password)
	if err != nil {
		return err
	}

	_, err = c.db.Exec(createParticipant, password)
	if err != nil {
		return err
	}

	return err
}
