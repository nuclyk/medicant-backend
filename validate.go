package main

import (
	"net/http"

	"github.com/nuclyk/medicant/internal/auth"
)

func validateUser(w http.ResponseWriter, h http.Header, secret string) (auth.ValidUser, bool) {
	token, err := auth.GetBearerToken(h)

	if err != nil {
		respondWithError(w, http.StatusBadRequest, "token might be malformed", err)
		return auth.ValidUser{}, false
	}

	validUser, err := auth.Validate(token, secret)

	if err != nil {
		respondWithError(w, http.StatusUnauthorized, "unauthorized", err)
		return auth.ValidUser{}, false
	}

	validRole := validUser.Role == "admin" || validUser.Role == "volunteer"

	return validUser, validRole
}
