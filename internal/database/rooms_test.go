package database

import (
	"log"
	"os"
	"testing"

	"github.com/joho/godotenv"
)

var client Client

func TestMain(m *testing.M) {
	var err error
	if err = godotenv.Load("../../.env"); err != nil {
		log.Fatal("Could not load .env!")
	}

	url := os.Getenv("TURSO_DEV")
	if url == "" {
		log.Fatal("TURSO_DEV not defined")
	}

	client, err = NewClient(url)
	if err != nil {
		log.Fatalf("couldn't create new database client: %v", err)
	}

	code := m.Run()

	client.db.Close()

	os.Exit(code)
}

func TestCreateRoom(t *testing.T) {
	room := Room{Number: 1, Capacity: 5, PlaceId: 1, IsClean: true}

	r, err := client.CreateRoom(room)
	if err != nil {
		t.Fatal(err)
	}

	if r.Number != room.Number && r.Capacity != room.Capacity &&
		r.PlaceId != room.PlaceId && r.IsClean != room.IsClean {
		t.Error("Result doesn't match")
	}

	client.db.Exec("DELETE * FROM rooms WHERE id = ?", r.Id)
}
