package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"

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
	placeName := r.PathValue("name")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "wrong user or role", err)
		return
	}

	if placeName != "" {
		result, err := cfg.db.GetPlace(placeName)
		if err != nil {
			respondWithError(w, http.StatusNotFound, fmt.Sprintf("couldn't find: %s", placeName), err)
			return
		}

		respondWithJson(w, http.StatusFound, cfg.databasePlaceToPlace(&result))
	} else {
		msg := "place name can't be empty"
		respondWithError(w, http.StatusInternalServerError, msg, errors.New(msg))
		return
	}
}

func (cfg Config) handlerPlacesUpdate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	placeName := r.PathValue("name")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "wrong user or role", err)
		return
	}

	var params Place

	if placeName == "" {
		respondWithError(w, http.StatusBadRequest, "provide name of the place", fmt.Errorf("placeName empty"))
		return
	}

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "error when decoding the json", err)
		return
	}

	place, err := cfg.db.GetPlace(placeName)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't find place", err)
		return

	}

	if params.Name != "" {
		place.Name = params.Name
	}

	if params.Capacity != "" {
		place.Capacity = params.Capacity
	}

	result, err := cfg.db.UpdatePlace(placeName, place)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "error when updating", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databasePlaceToPlace(result))
}

func (cfg Config) handlerPlacesDelete(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	placeName := r.PathValue("name")

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "wrong user or role", err)
		return
	}

	type msg struct {
		Msg string `json:"msg"`
	}

	successMsg, err := cfg.db.DeletePlace(placeName)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't delete the place", err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: successMsg})
}
