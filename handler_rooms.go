package main

import (
	"encoding/json"
	"errors"
	"log"
	"net/http"

	"github.com/nuclyk/medicant/internal/auth"
	"github.com/nuclyk/medicant/internal/database"
)

type CreateRoomParams struct {
	Number    int   `json:"number"`
	Capacity  int   `json:"capacity"`
	CheckedIn int   `json:"checked_in"`
	PlaceId   int   `json:"place_id"`
	IsClean   *bool `json:"is_clean"`
}

func (cfg Config) handlerRoomsCreate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	var params CreateRoomParams

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role", err)
		return
	}

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error while decoding request body", err)
		return
	}

	log.Println(params)

	result, err := cfg.db.CreateRoom(database.CreateRoomParams{
		Number:   params.Number,
		Capacity: params.Capacity,
		PlaceId:  params.PlaceId,
	})

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Creating new room failed", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRoomToRoom(result))
}

func (cfg Config) handlerRoomsGet(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role", err)
		return
	}

	result, err := cfg.db.GetRooms()
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Getting all rooms failed", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRoomsToRooms(*result))
}
