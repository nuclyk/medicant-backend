package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"

	"github.com/nuclyk/medicant/internal/auth"
	"github.com/nuclyk/medicant/internal/database"
)

func (cfg Config) handlerPlacesCreate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	var params database.Place

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "wrong user or role", err)
		return
	}

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "error while decoding request body", err)
		return
	}

	result, err := cfg.db.CreatePlace(params)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "creating new place failed", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databasePlaceToPlace(result))
}

func (cfg Config) handlerPlacesGet(w http.ResponseWriter, r *http.Request) {
	result, err := cfg.db.GetPlaces()
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "getting all places failed", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databasePlacesToPlaces(result))
}

func (cfg Config) handlerPlaceGet(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	id := r.PathValue("id")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "wrong user or role", err)
		return
	}

	if id != "" {
		parsedId, err := strconv.Atoi(id)
		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "Error when parsing string to int ID param", err)
			return
		}

		result, err := cfg.db.GetPlace(parsedId)
		if err != nil {
			respondWithError(w, http.StatusNotFound, fmt.Sprintf("couldn't find: %s", id), err)
			return
		}

		respondWithJson(w, http.StatusOK, cfg.databasePlaceToPlace(&result))
	} else {
		msg := "Place ID can't be empty"
		respondWithError(w, http.StatusInternalServerError, msg, errors.New(msg))
		return
	}
}

func (cfg Config) handlerPlacesUpdate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	id := r.PathValue("id")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role", err)
		return
	}

	var params Place

	if id == "" {
		respondWithError(w, http.StatusBadRequest, "Provide name of the place", fmt.Errorf("id empty"))
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

	place, err := cfg.db.GetPlace(parsedId)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Couldn't find place", err)
		return

	}

	if params.Name != "" {
		place.Name = params.Name
	}

	result, err := cfg.db.UpdatePlace(id, place)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when updating a place", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databasePlaceToPlace(result))
}

func (cfg Config) handlerPlacesDelete(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	placeId := r.PathValue("id")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "wrong user or role", err)
		return
	}

	type msg struct {
		Msg string `json:"msg"`
	}

	successMsg, err := cfg.db.DeletePlace(placeId)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't delete the place", err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: successMsg})
}
