package main

import (
	"net/http"
	"time"

	"github.com/nuclyk/medicant/internal/auth"
)

func (cfg Config) handlerRefresh(w http.ResponseWriter, r *http.Request) {
	type response struct {
		Token string `json:"token"`
	}

	token, err := auth.GetBearerToken(r.Header)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, err.Error(), err)
		return
	}

	refreshToken, err := cfg.db.GetRefreshToken(token)

	if err != nil {
		respondWithError(w, http.StatusUnauthorized, "refresh token not found", err)
		return
	}

	if refreshToken.RevokedAt != nil {
		respondWithError(w, http.StatusUnauthorized, `refresh token revoked, login again with email and password`, err)
		return
	}

	user, err := cfg.db.GetUserByRefreshToken(token)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't find a user with the provider token", err)
		return
	}

	accessToken, err := auth.MakeJWT(user.ID, user.Role, cfg.tokenSecret, time.Hour)

	if err != nil {
		respondWithError(w, http.StatusUnauthorized, "Couldn't make token", err)
		return
	}

	respondWithJson(w, http.StatusOK, response{
		Token: accessToken,
	})

}

func (cfg Config) handlerRevoke(w http.ResponseWriter, r *http.Request) {
	token, err := auth.GetBearerToken(r.Header)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "token might be malformed", err)
		return
	}

	if err = cfg.db.RevokeRefreshToken(token); err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't revoke session", err)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
