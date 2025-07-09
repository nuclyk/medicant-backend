package main

import (
	"log"
	"net/http"
	"os"
	"time"

	"github.com/joho/godotenv"

	"github.com/nuclyk/medicant/internal/database"
)

type Config struct {
	db          *database.Client
	tokenSecret string
	log         *log.Logger
}

var cfg Config

func main() {
	var envFile string

	if len(os.Args) > 1 && os.Args[1] == "dev" {
		log.Println(".env.dev loaded")
		envFile = ".env.dev"
	} else {
		log.Println(".env loaded")
		envFile = ".env"
	}

	err := godotenv.Load(envFile)
	if err != nil {
		log.Printf("Error loading .env file: %v", err)
	}

	turso := os.Getenv("TURSO")
	if turso == "" {
		log.Println("Turso database url has to be set")
	}

	port := os.Getenv("PORT")
	if port == "" {
		log.Println("PORT has not been set")
	}

	secret := os.Getenv("SECRET")
	if secret == "" {
		log.Println("Secret token has to be set")
	}

	assets := os.Getenv("ASSETS_ROOT")
	if assets == "" {
		log.Println("Assets root has to be set")
	}

	// Create new DB
	dbClient, err := database.NewClient(turso)
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
	server := &http.Server{
		Addr:         "0.0.0.0:" + port,
		Handler:      enableCORS(mux),
		ReadTimeout:  30 * time.Second,
		WriteTimeout: 30 * time.Second,
		IdleTimeout:  120 * time.Second,
	}

	// Assets directory
	assetsHandler := http.StripPrefix("/assets", http.FileServer(http.Dir(assets)))
	mux.Handle("/assets/", noCacheMiddleware(assetsHandler))

	// Roles Handlers
	mux.HandleFunc("POST /api/roles", cfg.JWTAuth(cfg.handlerRolesCreate))
	mux.HandleFunc("GET /api/roles", cfg.JWTAuth(cfg.handlerRolesGet))
	mux.HandleFunc("GET /api/roles/{name}", cfg.JWTAuth(cfg.handlerRolesGet))
	mux.HandleFunc("PUT /api/roles/{name}", cfg.JWTAuth(cfg.handlerRolesUpdate))
	mux.HandleFunc("DELETE /api/roles/{name}", cfg.JWTAuth(cfg.handlerRolesDelete))

	// Users Handlers
	mux.HandleFunc("POST /api/users", cfg.handlerUsersCreate)
	mux.HandleFunc("GET /api/users/{userID}", cfg.JWTAuth(cfg.handlerUserGet))
	mux.HandleFunc("GET /api/users", cfg.JWTAuth(cfg.handlerUsersGet))
	mux.HandleFunc("PUT /api/users/{userID}", cfg.JWTAuth(cfg.handlerUsersUpdate))
	mux.HandleFunc("PUT /api/users/password/{userID}", cfg.JWTAuth(cfg.handlerUsersChangePassword))
	mux.HandleFunc("DELETE /api/users/{userID}", cfg.JWTAuth(cfg.handlerUsersDelete))

	mux.HandleFunc("POST /api/users/exists", cfg.handlerCheckForUser)

	// Checkout
	mux.HandleFunc("PUT /api/users", cfg.handlerUserCheckout)

	// Retreat Handlers
	mux.HandleFunc("POST /api/retreats", cfg.JWTAuth(cfg.handlerRetreatsCreate))
	mux.HandleFunc("GET /api/retreats", cfg.handlerRetreatsGet)
	mux.HandleFunc("GET /api/retreats/{retreatID}", cfg.JWTAuth(cfg.handlerRetreatGet))
	mux.HandleFunc("PUT /api/retreats/{retreatID}", cfg.JWTAuth(cfg.handlerRetreatUpdate))
	mux.HandleFunc("DELETE /api/retreats/{retreatID}", cfg.JWTAuth(cfg.handlerRetreatDelete))

	// Place handlers
	mux.HandleFunc("POST /api/places", cfg.JWTAuth(cfg.handlerPlacesCreate))
	mux.HandleFunc("GET /api/places", cfg.handlerPlacesGet)
	mux.HandleFunc("GET /api/places/{id}", cfg.JWTAuth(cfg.handlerPlaceGet))
	mux.HandleFunc("PUT /api/places/{id}", cfg.JWTAuth(cfg.handlerPlacesUpdate))
	mux.HandleFunc("DELETE /api/places/{id}", cfg.JWTAuth(cfg.handlerPlacesDelete))

	// Room handlers
	mux.HandleFunc("POST /api/rooms", cfg.JWTAuth(cfg.handlerRoomsCreate))
	mux.HandleFunc("GET /api/rooms", cfg.JWTAuth(cfg.handlerRoomsGet))
	mux.HandleFunc("GET /api/rooms/{id}", cfg.JWTAuth(cfg.handlerRoomGet))
	mux.HandleFunc("PUT /api/rooms/{id}", cfg.JWTAuth(cfg.handlerRoomsUpdate))
	mux.HandleFunc("DELETE /api/rooms/{id}", cfg.JWTAuth(cfg.handlerRoomsDelete))

	// Refresh Tokens
	mux.HandleFunc("POST /api/refresh", cfg.handlerRefresh)
	mux.HandleFunc("POST /api/revoke", cfg.handlerRevoke)

	// Auth
	mux.HandleFunc("POST /api/login", cfg.handlerLogin)

	// Stats
	mux.HandleFunc("GET /api/stats", cfg.handlerStatsGet)

	// QR codes
	mux.HandleFunc("POST /api/qrcode", cfg.JWTAuth(cfg.handlerQrcode))

	log.Println("Server starting on port", port)
	err = server.ListenAndServe()
	if err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}

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
