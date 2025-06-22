package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func respondWithError(w http.ResponseWriter, code int, msg string, err error) {
	log.Printf("%v", err)

	w.Header().Add("Content-Type", "application/json")

	type badRequest struct {
		Error string `json:"error"`
	}

	res, err := json.Marshal(badRequest{
		Error: msg,
	})

	if err != nil {
		log.Printf("couldn't marshal the request: %v", err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(code)
	_, err = w.Write(res)
	if err != nil {
		log.Printf("Error writing response: %s", err)
		return
	}
}

func respondWithJson(w http.ResponseWriter, code int, payload any) {
	w.Header().Add("Content-Type", "application/json")
	res, err := json.Marshal(payload)

	if err != nil {
		log.Printf("couldn't marshal the payload: %v", err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(code)
	_, err = w.Write(res)
	if err != nil {
		log.Printf("Error writing response: %s", err)
		return
	}
}
