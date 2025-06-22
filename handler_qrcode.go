package main

import (
	"net/http"

	"github.com/skip2/go-qrcode"
)

func (cfg Config) handlerQrcode(w http.ResponseWriter, r *http.Request) {
	type response struct {
		QrCheckin string `json:"qr_checkin"`
	}
	err := qrcode.WriteFile("http://localhost:5173/form/checkin", qrcode.Medium, 256, "./assets/qr_checkin.png")
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "error when generating qr code", err)
	}
	respondWithJson(w, http.StatusOK, response{"http://localhost:8080/assets/qr_checkin.png"})
}
