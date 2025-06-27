package main

import (
	"net/http"

	"github.com/nuclyk/medicant/internal/auth"
	"github.com/skip2/go-qrcode"
)

func (cfg Config) handlerQrcode(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	type response struct {
		QrCheckin string `json:"qr_checkin"`
	}

	if err := qrcode.WriteFile("http://localhost:5173/form/checkin", qrcode.Medium, 256, "./assets/qr_checkin.png"); err != nil {
		respondWithError(w, http.StatusInternalServerError, "error when generating qr code", err)
		return
	}

	respondWithJson(w, http.StatusOK, response{"http://0:0:0:0:8080/assets/qr_checkin.png"})
}
