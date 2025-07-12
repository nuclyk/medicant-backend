package main

import (
	"encoding/json"
	"errors"
	"net/http"
	"time"

	"github.com/nuclyk/medicant/internal/auth"
	"github.com/nuclyk/medicant/internal/database"
)

type CreateRetreatParams struct {
	Type       string     `json:"type,omitempty"`
	Start_date *time.Time `json:"start_date,omitempty"`
	End_date   *time.Time `json:"end_date,omitempty"`
}

func (cfg Config) handlerRetreatsCreate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	var params CreateRetreatParams

	if !validUser.Editor {
		err := errors.New("wrong user or role")
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role", err)
		return
	}

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when decoding JSON request", err)
		return
	}

	if params.Type != "fixed" && params.Type != "flexible" {
		err := errors.New("type of the retreat is invalid")
		respondWithError(w, http.StatusInternalServerError, "Type of the retreat must be 'fixed' or 'flexible'", err)
		return
	}

	retreat, err := cfg.db.CreateRetreat(database.CreateRetreatParams{
		Type:       params.Type,
		Start_date: params.Start_date,
		End_date:   params.End_date,
	})

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when creating a new retreat", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRetreatToRetreat(retreat))
}

func (cfg Config) handlerRetreatsGet(w http.ResponseWriter, r *http.Request) {
	retreats, err := cfg.db.GetRetreats()

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when fetching users", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRetreatsToRetreats(*retreats))
}

func (cfg Config) handlerRetreatGet(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	if !validUser.Editor {
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role",
			errors.New("wrong user or role"))
		return
	}

	retreatID := r.PathValue("retreatID")

	if retreatID != "" {
		retreat, err := cfg.db.GetRetreat(retreatID)

		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "Error when fetching the retreat", err)
			return
		}

		respondWithJson(w, http.StatusOK, cfg.databaseRetreatToRetreat(retreat))
	} else {
		respondWithError(w, http.StatusInternalServerError, "Retreat ID can't be empty", errors.New("retreat id can't be empty"))
		return
	}

}

func (cfg Config) handlerRetreatUpdate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	if !validUser.Editor {
		respondWithError(w, http.StatusUnauthorized, "Wrong User or Role",
			errors.New("wrong user or role"))
		return
	}

	retreatID := r.PathValue("retreatID")
	var params CreateRetreatParams

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when decoding JSON request", err)
		return
	}

	retreat, err := cfg.db.GetRetreat(retreatID)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when fetching the retreat", err)
		return
	}

	if params.Type != "" {
		retreat.Type = params.Type
	}

	if params.Start_date != nil {
		retreat.Start_date = params.Start_date
	}

	if params.End_date != nil {
		retreat.End_date = params.End_date
	}

	updatedRetreat, err := cfg.db.UpdateRetreat(retreatID, *retreat)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when updating the retreat", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRetreatToRetreat(&updatedRetreat))
}

func (cfg Config) handlerRetreatDelete(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	if !validUser.Editor {
		respondWithError(w, http.StatusUnauthorized, "Wrong user or role",
			errors.New("wrong user or role"))
		return
	}

	retreatID := r.PathValue("retreatID")

	type msg struct {
		Msg string `json:"msg"`
	}

	successMsg, err := cfg.db.DeleteRetreat(retreatID)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't delete the retreat", err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: successMsg})
}
