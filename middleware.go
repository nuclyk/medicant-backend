package main

import (
	"net/http"

	"github.com/nuclyk/medicant/internal/auth"
)

type authedHandler func(http.ResponseWriter, *http.Request, auth.ValidUser)

func (cfg Config) JWTAuth(handler authedHandler) http.HandlerFunc {
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

		validUser.Permissions.Editor = validUser.Role == "admin" || validUser.Role == "volunteer"

		handler(w, r, validUser)
	}
}
