package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/nuclyk/medicant/internal/auth"
	"github.com/nuclyk/medicant/internal/database"
)

type CreateUserParams struct {
	FirstName    string  `json:"first_name,omitempty"`
	LastName     string  `json:"last_name,omitempty"`
	Email        string  `json:"email,omitempty"`
	Password     string  `json:"password,omitempty"`
	Phone        string  `json:"phone,omitempty"`
	Age          string  `json:"age,omitempty"`
	Gender       string  `json:"gender,omitempty"`
	Nationality  string  `json:"nationality,omitempty"`
	Role         string  `json:"role,omitempty"`
	RetreatID    int     `json:"retreat_id,omitempty"`
	CheckOutDate *string `json:"check_out_date,omitempty"`
	LeaveDate    string  `json:"leave_date,omitempty"`
	Diet         *string `json:"diet,omitempty"`
	Place        string  `json:"place,omitempty"`
}

func (cfg Config) handlerUsersCreate(w http.ResponseWriter, r *http.Request) {
	var params CreateUserParams

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "error while decoding request body", err)
		return
	}

	// If password is provided then hash it
	if params.Password != "" {
		hashedPassword, err := auth.HashPassword(params.Password)

		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "error while hashing the password", err)
			return
		}

		params.Password = string(hashedPassword)
	}

	// Check if the user with this email already exists
	users, err := cfg.db.GetUsers()

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't get users", err)
		return
	}

	for _, user := range users {
		if user.Email == params.Email {
			respondWithError(w, http.StatusConflict, "Email already exists.", errors.New("email not unique"))
			return
		}
	}

	user, err := cfg.db.CreateUser(database.CreateUserParams{
		FirstName:    params.FirstName,
		LastName:     params.LastName,
		Password:     params.Password,
		Email:        params.Email,
		Phone:        params.Phone,
		Age:          params.Age,
		Gender:       params.Gender,
		Nationality:  params.Nationality,
		Role:         params.Role,
		RetreatID:    params.RetreatID,
		CheckOutDate: params.CheckOutDate,
		LeaveDate:    params.LeaveDate,
		Diet:         params.Diet,
		Place:        params.Place,
	})

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't create a new user", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseUserToUser(user))
}

func (cfg Config) handlerUserGet(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	userID := r.PathValue("userID")

	if userID == "" {
		respondWithError(w, http.StatusInternalServerError, "search value can't be empty",
			errors.New("empty search value"))
		return
	}

	user, err := cfg.db.GetUser(userID)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't get user", err)
		return
	}

	validUser.Owner = user.ID == validUser.ID

	if !validUser.Owner && !validUser.Editor {
		respondWithError(w, http.StatusUnauthorized, "Wrong user or role",
			errors.New("wrong user or role"))
		return
	}

	respondWithJson(w, http.StatusFound, cfg.databaseUserToUser(user))
}

func (cfg Config) handlerUsersGet(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	users, err := cfg.db.GetUsers()
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Couldn't get users", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseUsersToUsers(users))
}

func (cfg Config) handlerCheckForUser(w http.ResponseWriter, r *http.Request) {
	type Email struct {
		Value string `json:"email"`
	}

	type Response struct {
		Token  string `json:"token"`
		UserID string `json:"userID"`
	}

	var email Email

	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&email); err != nil {
		respondWithError(w, http.StatusInternalServerError, "Could not decode the request", err)
		return
	}

	user, err := cfg.db.GetUser(email.Value)
	if err != nil {
		respondWithError(w, http.StatusNotFound, "User nof found", err)
		return
	}

	token, err := auth.MakeJWT(user.ID, user.Role, cfg.tokenSecret, time.Minute)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Token could not be generated", err)
		return
	}

	respondWithJson(w, http.StatusOK, Response{token, user.ID.String()})
}

func (cfg Config) handlerUsersChangePassword(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	var params database.UpdatePasswordParams
	userID := r.PathValue("userID")

	type msg struct {
		Msg string `json:"msg"`
	}

	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusBadRequest, "couldn't decode the request body", err)
		return
	}

	if userID == "" {
		respondWithError(w, http.StatusBadRequest, "provide valid search value", fmt.Errorf("invalid user id"))
		return
	}

	if len(params.Password) < 4 {
		err := errors.New("password needs to be minimum 4 characters long")
		respondWithError(w, http.StatusBadRequest, err.Error(), err)
		return
	}

	result, err := cfg.db.UpdatePassword(userID, params)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, result, err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: result})
}

func (cfg Config) handlerUserCheckout(w http.ResponseWriter, r *http.Request) {
	cfg.log.Println("user checkout")

	type params struct {
		Email string `json:"email"`
	}

	type msg struct {
		Success bool `json:"success"`
	}

	var user params
	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&user); err != nil {
		respondWithError(w, http.StatusInternalServerError, "error while decoding", err)
		return
	}

	log.Println(user.Email)

	err := cfg.db.CheckoutUser(user.Email)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "error when checking out the user", err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Success: true})
}

func (cfg Config) handlerUsersUpdate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	var params CreateUserParams
	userID := r.PathValue("userID")

	if userID == "" {
		respondWithError(w, http.StatusBadRequest, "provide valid id or email", fmt.Errorf("invalid id or email"))
		return
	}

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "error while decoding", err)
		return
	}

	user, err := cfg.db.GetUser(userID)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't fetch a user", err)
		return
	}

	validUser.Owner = user.ID == validUser.ID

	if !validUser.Owner && !validUser.Editor {
		respondWithError(w, http.StatusUnauthorized, "Wrong user or role",
			errors.New("wrong user or role"))
		return
	}

	// admin or volunteer can fetch any use
	if params.FirstName != "" {
		user.FirstName = params.FirstName
	}

	if params.LastName != "" {
		user.LastName = params.LastName
	}

	if params.Email != "" {
		user.Email = params.Email
	}

	if params.Phone != "" {
		user.Phone = params.Phone
	}

	if params.Age != "" {
		user.Age = params.Age
	}

	if params.Gender != "" {
		user.Gender = params.Gender
	}

	if params.Nationality != "" {
		user.Nationality = params.Nationality
	}

	if params.Role != "" {
		user.Role = params.Role
	}

	if params.RetreatID != 0 {
		user.RetreatID = params.RetreatID
	}

	if params.CheckOutDate != nil {
		user.CheckOutDate = params.CheckOutDate
	}

	if params.LeaveDate != "" {
		user.LeaveDate = params.LeaveDate
	}

	if params.Diet != nil {
		user.Diet = params.Diet
	}

	if params.Place != "" {
		user.Place = params.Place
	}

	user, err = cfg.db.UpdateUser(userID, user)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't update the user", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseUserToUser(user))
}

func (cfg Config) handlerUsersDelete(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	userID := r.PathValue("userID")

	type msg struct {
		Msg string `json:"msg"`
	}

	if !validUser.Editor {
		respondWithError(w, http.StatusUnauthorized, "Wrong user or role",
			errors.New("wrong user or role"))
		return
	}

	successMsg, err := cfg.db.DeleteUser(userID)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't delete the user", err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: successMsg})
}
