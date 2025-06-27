package main

import (
	"errors"
	"net/http"

	"github.com/skip2/go-qrcode"

	"github.com/nuclyk/medicant/internal/auth"
)

func (cfg Config) handlerQrcode(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	type response struct {
		QrCheckin string `json:"qr_checkin"`
	}

	if !validUser.Editor {
		err := "no permission to generate new qrcode"
		respondWithError(w, http.StatusInternalServerError, err, errors.New(err))
		return
	}

	if err := qrcode.WriteFile("http://localhost:5173/form/checkin", qrcode.Medium, 256, "./assets/qr_checkin.png"); err != nil {
		respondWithError(w, http.StatusInternalServerError, "error when generating qr code", err)
		return
	}

	respondWithJson(w, http.StatusOK, response{"http://0:0:0:0:8080/assets/qr_checkin.png"})
}
