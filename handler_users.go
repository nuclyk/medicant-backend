package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"

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
	IsCheckedIn  *bool   `json:"is_checked_in,omitempty"`
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
		}
		params.Password = string(hashedPassword)
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
		IsCheckedIn:  params.IsCheckedIn,
		Diet:         params.Diet,
		Place:        params.Place,
	})

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't create a new user", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseUserToUser(user))
}

func (cfg Config) handlerUsersGet(w http.ResponseWriter, r *http.Request) {
	searchValue := r.PathValue("searchValue")

	token, err := auth.GetBearerToken(r.Header)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, err.Error(), err)
		return
	}

	_, err = auth.Validate(token, cfg.tokenSecret)
	if err != nil {
		respondWithError(w, http.StatusUnauthorized, "unauthorized", err)
		return
	}

	if searchValue != "" {
		user, err := cfg.db.GetUser(searchValue)

		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "couldn't get user", err)
			return
		}

		respondWithJson(w, http.StatusOK, cfg.databaseUserToUser(user))

	} else {
		users, err := cfg.db.GetUsers()

		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "couldn't get users", err)
			return
		}

		respondWithJson(w, http.StatusOK, cfg.databaseUsersToUsers(users))
	}
}

func (cfg Config) handlerUsersChangePassword(w http.ResponseWriter, r *http.Request) {
	var params database.UpdatePasswordParams
	searchValue := r.PathValue("searchValue")

	type msg struct {
		Msg string `json:"msg"`
	}

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&params)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "couldn't decode the request body", err)
		return
	}

	if searchValue == "" {
		respondWithError(w, http.StatusBadRequest, "provide valid search value", fmt.Errorf("invalid user id"))
		return
	}

	if len(params.Password) < 4 {
		err := errors.New("password needs to be minimum 4 characters long")
		respondWithError(w, http.StatusBadRequest, err.Error(), err)
		return
	}

	result, err := cfg.db.UpdatePassword(searchValue, params)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, result, err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: result})
}

func (cfg Config) handlerUsersUpdate(w http.ResponseWriter, r *http.Request) {
	var params CreateUserParams
	searchValue := r.PathValue("searchValue")

	if searchValue == "" {
		respondWithError(w, http.StatusBadRequest, "provide valid id or email", fmt.Errorf("invalid id or email"))
		return
	}

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "error while decoding", err)
		return
	}

	user, err := cfg.db.GetUser(searchValue)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't fetch a user", err)
		return
	}

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

	if params.IsCheckedIn != nil {
		user.IsCheckedIn = params.IsCheckedIn
	}

	if params.Diet != nil {
		user.Diet = params.Diet
	}

	if params.Place != "" {
		user.Place = params.Place
	}

	user, err = cfg.db.UpdateUser(searchValue, user)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't update the user", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseUserToUser(user))
}

func (cfg Config) handlerUsersDelete(w http.ResponseWriter, r *http.Request) {
	userID := r.PathValue("userID")

	type msg struct {
		Msg string `json:"msg"`
	}

	successMsg, err := cfg.db.DeleteUser(userID)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't delete the user", err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: successMsg})
}
