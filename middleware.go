package main

import (
	"errors"
	"net/http"

	"github.com/nuclyk/medicant/internal/auth"
)

type authedHandler func(http.ResponseWriter, *http.Request)

func (cfg Config) checkRole(handler authedHandler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		token, err := auth.GetBearerToken(r.Header)
		if err != nil {
			respondWithError(w, http.StatusBadRequest, "token might be malformed", err)
			return
		}

		validUser, err := auth.Validate(token, cfg.tokenSecret)
		if err != nil {
			respondWithError(w, http.StatusUnauthorized, "unauthorized", err)
			return
		}

		validRole := validUser.Role == "admin" || validUser.Role == "volunteer"
		if !validRole {
			respondWithError(w, http.StatusNotFound, "Your role doesn't have a permission",
				errors.New("role doesn't have permission"))
			return
		}

		handler(w, r)
	}
}
