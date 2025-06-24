package main

import (
	"encoding/json"
	"errors"
	"net/http"

	"github.com/nuclyk/medicant/internal/database"
)

type CreateRetreatParams struct {
	Type       string `json:"type"`
	Start_date string `json:"start_date"`
	End_date   string `json:"end_date"`
}

func (cfg Config) handlerRetreatsCreate(w http.ResponseWriter, r *http.Request) {
	var params CreateRetreatParams

	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "coldn't decode the request", err)
		return
	}

	// Check if the start date of the retreat is not after the end date
	// if params.Start_date.After(params.End_date) {
	// 	err := fmt.Errorf("start date: %v after end date: %v", params.Start_date, params.End_date)
	// 	respondWithError(w, http.StatusBadRequest, "couldn't start date can't later than the end date", err)
	// 	return
	// }

	if params.Type != "fixed" && params.Type != "flexible" {
		err := errors.New("type of the retreat is invalid")
		respondWithError(w, http.StatusInternalServerError, "type must be 'fixed' or 'flexible'", err)
		return
	}

	retreat, err := cfg.db.CreateRetreat(database.CreateRetreatParams{
		Type:       params.Type,
		Start_date: &params.Start_date,
		End_date:   &params.End_date,
	})
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't create a new retreat", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRetreatToRetreat(retreat))
}

func (cfg Config) handlerRetreatsGet(w http.ResponseWriter, r *http.Request) {
	retreatID := r.PathValue("retreatID")

	if retreatID != "" {
		retreat, err := cfg.db.GetRetreat(retreatID)

		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "coudn't get the retreat", err)
			return
		}

		respondWithJson(w, http.StatusOK, cfg.databaseRetreatToRetreat(retreat))
	} else {
		retreats, err := cfg.db.GetRetreats()

		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "couldn't get users", err)
		}

		respondWithJson(w, http.StatusOK, cfg.databaseRetreatsToRetreats(*retreats))
	}

}

func (cfg Config) handlerRetreatUpdate(w http.ResponseWriter, r *http.Request) {
	retreatID := r.PathValue("retreatID")

	var params CreateRetreatParams

	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't decode the request body", err)
		return
	}

	retreat, err := cfg.db.GetRetreat(retreatID)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't get the retreat", err)
		return
	}

	if params.Type != "" {
		retreat.Type = params.Type
	}

	if params.Start_date != "" {
		retreat.Start_date = &params.Start_date
	}

	if params.End_date != "" {
		retreat.End_date = &params.End_date
	}

	updatedRetreat, err := cfg.db.UpdateRetreat(retreatID, *retreat)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't update the retreat", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRetreatToRetreat(&updatedRetreat))
}

func (cfg Config) handlerRetreatDelete(w http.ResponseWriter, r *http.Request) {
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
