package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/nuclyk/medicant/internal/auth"
	"github.com/nuclyk/medicant/internal/database"
)

type CreateRoomParams struct {
	Number    *int  `json:"number"`
	Capacity  *int  `json:"capacity"`
	CheckedIn *int  `json:"checked_in"`
	PlaceId   *int  `json:"place_id"`
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
		Number:   *params.Number,
		Capacity: *params.Capacity,
		PlaceId:  *params.PlaceId,
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

func (cfg Config) handlerRoomGet(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	id := r.PathValue("id")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role", err)
		return
	}

	if id != "" {
		parsedId, err := strconv.Atoi(id)
		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "Error when parsing string to int ID param", err)
			return
		}

		result, err := cfg.db.GetRoom(parsedId)
		if err != nil {
			respondWithError(w, http.StatusNotFound, fmt.Sprintf("Couldn't find room with id: %s", id), err)
			return
		}

		respondWithJson(w, http.StatusOK, cfg.databaseRoomToRoom(result))
	} else {
		msg := "Room ID can't be empty"
		respondWithError(w, http.StatusInternalServerError, msg, errors.New(msg))
		return
	}
}

func (cfg Config) handlerRoomsUpdate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	id := r.PathValue("id")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role", err)
		return
	}

	var params CreateRoomParams

	if id == "" {
		respondWithError(w, http.StatusBadRequest, "Provide name of the place", fmt.Errorf("room id empty"))
		return
	}

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when decoding the json", err)
		return
	}

	parsedId, err := strconv.Atoi(id)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when parsing string to int ID param", err)
		return
	}

	room, err := cfg.db.GetRoom(parsedId)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Couldn't find place", err)
		return

	}

	if params.Number != nil {
		room.Number = *params.Number
	}

	if params.Capacity != nil {
		room.Capacity = *params.Capacity
	}

	if params.CheckedIn != nil {
		room.CheckedIn = *params.CheckedIn
	}

	if params.PlaceId != nil {
		room.PlaceId = *params.PlaceId
	}

	if params.IsClean != nil {
		room.IsClean = *params.IsClean
	}

	result, err := cfg.db.UpdateRoom(id, *room)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Rrror when updating room", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRoomToRoom(result))
}

func (cfg Config) handlerRoomsDelete(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	roomId := r.PathValue("id")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role", err)
		return
	}

	type msg struct {
		Msg string `json:"msg"`
	}

	successMsg, err := cfg.db.DeleteRoom(roomId)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Couldn't delete a room", err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: successMsg})
}
