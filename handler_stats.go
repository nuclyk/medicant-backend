package main

import "net/http"

func (cfg Config) handlerStatsGet(w http.ResponseWriter, r *http.Request) {

	stats, err := cfg.db.GetStats()
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Error when fetching stats", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.dbStatsToStats(stats))
}
