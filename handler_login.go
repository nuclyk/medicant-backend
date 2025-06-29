package main

import (
	"encoding/json"
	"net/http"
	"time"

	"github.com/nuclyk/medicant/internal/auth"
	"github.com/nuclyk/medicant/internal/database"
)

func (cfg Config) handlerLogin(w http.ResponseWriter, r *http.Request) {
	cfg.log.Println("-- Logging in")

	type reqBody struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}

	type response struct {
		Token        string `json:"token"`
		RefreshToken string `json:"refresh_token"`
	}

	var req reqBody

	cfg.log.Println("Decoding request body")

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&req); err != nil {
		respondWithError(w, http.StatusBadRequest, "can't decode request body", err)
		return
	}

	user, err := cfg.db.GetUser(req.Email)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "can't find user", err)
		return
	}

	cfg.log.Println("Making JWT")

	jwt, err := auth.MakeJWT(user.ID, user.Role, cfg.tokenSecret, 15*time.Minute)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't make jwt", err)
		return
	}

	cfg.log.Println("Create refresh token")

	rt, err := auth.MakeRefreshToken()

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "error when creating refresh token", err)
		return
	}

	_, err = cfg.db.CreateRefreshToken(database.CreateRefreshTokenParams{
		Token:     rt,
		UserID:    user.ID,
		ExpiresAt: time.Now().Add(time.Hour * 24 * 30).String(),
	})

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "error inserting refresh token to db", err)
		return
	}

	cfg.log.Println("Checking password")

	valid := auth.CheckPasswordHash(user.Password, req.Password)

	if valid == nil {
		respondWithJson(w, http.StatusOK, response{jwt, rt})
	} else {
		respondWithError(w, http.StatusUnauthorized, "wrong password, try again", err)
		return
	}
}
