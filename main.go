package main

import (
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"

	"github.com/nuclyk/medicant/internal/database"
)

type Config struct {
	db          *database.Client
	tokenSecret string
	log         *log.Logger
}

var cfg Config

func enableCORS(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}

		next.ServeHTTP(w, r)
	})
}

func main() {
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}

	dbURL := os.Getenv("DATABASE_URL")
	if dbURL == "" {
		log.Fatal("Database url has to be set in .env")
	}

	secret := os.Getenv("SECRET")
	if secret == "" {
		log.Fatal("Secret token has to be set")
	}

	assets := os.Getenv("ASSETS_ROOT")
	if assets == "" {
		log.Fatal("Assets root has to be set")
	}

	dbClient, err := database.NewClient(dbURL)
	if err != nil {
		log.Fatalf("couldn't create new database client: %v", err)
	}

	myLog := log.New(os.Stdout, "log:", log.Lshortfile)

	cfg = Config{
		db:          &dbClient,
		tokenSecret: secret,
		log:         myLog,
	}

	mux := http.NewServeMux()

	// Assets directory
	assetsHandler := http.StripPrefix("/assets", http.FileServer(http.Dir(assets)))
	mux.Handle("/assets/", noCacheMiddleware(assetsHandler))

	// Roles Handlers
	mux.HandleFunc("POST /api/roles", cfg.handlerRolesCreate)
	mux.HandleFunc("GET /api/roles", cfg.handlerRolesGet)
	mux.HandleFunc("GET /api/roles/{name}", cfg.handlerRolesGet)
	mux.HandleFunc("PUT /api/roles/{name}", cfg.handlerRolesUpdate)
	mux.HandleFunc("DELETE /api/roles/{name}", cfg.handlerRolesDelete)

	// Users Handlers
	mux.HandleFunc("POST /api/users", cfg.handlerUsersCreate)
	mux.HandleFunc("GET /api/users/{searchValue}", cfg.handlerUsersGet)
	mux.HandleFunc("GET /api/users", cfg.handlerUsersGet)
	mux.HandleFunc("PUT /api/users/{searchValue}", cfg.handlerUsersUpdate)
	mux.HandleFunc("PUT /api/users/password/{searchValue}", cfg.handlerUsersChangePassword)
	mux.HandleFunc("DELETE /api/users/{userID}", cfg.handlerUsersDelete)

	// Retreat Handlers
	mux.HandleFunc("POST /api/retreats", cfg.handlerRetreatsCreate)
	mux.HandleFunc("GET /api/retreats/{retreatID}", cfg.handlerRetreatsGet)
	mux.HandleFunc("GET /api/retreats", cfg.handlerRetreatsGet)
	mux.HandleFunc("PUT /api/retreats/{retreatID}", cfg.handlerRetreatUpdate)
	mux.HandleFunc("DELETE /api/retreats/{retreatID}", cfg.handlerRetreatDelete)

	// Place handlers
	mux.HandleFunc("POST /api/places", cfg.handlerPlacesCreate)
	mux.HandleFunc("GET /api/places/{name}", cfg.handlerPlacesGet)
	mux.HandleFunc("GET /api/places", cfg.handlerPlacesGet)
	mux.HandleFunc("PUT /api/places/{name}", cfg.handlerPlacesUpdate)
	mux.HandleFunc("DELETE /api/places/{name}", cfg.handlerPlacesDelete)

	// Refresh Tokens
	mux.HandleFunc("POST /api/refresh", cfg.handlerRefresh)
	mux.HandleFunc("POST /api/revoke", cfg.handlerRevoke)

	// Auth
	mux.HandleFunc("POST /api/login", cfg.handlerLogin)

	// QR codes
	mux.HandleFunc("POST /api/qrcode", cfg.handlerQrcode)

	log.Fatal(http.ListenAndServe(":8080", enableCORS(mux))) // #nosec G114
}
