package main

import (
	"encoding/json"
	"errors"
	"net/http"

	"github.com/nuclyk/medicant/internal/auth"
	"github.com/nuclyk/medicant/internal/database"
)

func (cfg Config) handlerRolesCreate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	var params database.Role

	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&params); err != nil {

		respondWithError(w, http.StatusInternalServerError, "error when decoding", err)
		return
	}

	if validUser.Role != "admin" {
		respondWithError(w, http.StatusUnauthorized, "You have to be an admin",
			errors.New("not an admin"))
		return
	}

	role, err := cfg.db.CreateRole(params)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't create a new role", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRoleToRole(role))
}

func (cfg Config) handlerRolesGet(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	roleID := r.PathValue("name")

	if !validUser.Editor {
		respondWithError(w, http.StatusUnauthorized, "Wrong user or role",
			errors.New("wrong user or role"))
		return
	}

	if roleID != "" {
		role, err := cfg.db.GetRole(roleID)

		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "couldn't get role", err)
			return
		}

		respondWithJson(w, http.StatusOK, cfg.databaseRoleToRole(role))
	} else {
		roles, err := cfg.db.GetRoles()

		if err != nil {
			respondWithError(w, http.StatusInternalServerError, "couldn't get roles", err)
			return
		}

		respondWithJson(w, http.StatusOK, cfg.databaseRolesToRoles(roles))
	}
}

func (cfg Config) handlerRolesUpdate(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	var params database.Role
	roleID := r.PathValue("name")

	decoder := json.NewDecoder(r.Body)

	if err := decoder.Decode(&params); err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't decode the role params", err)
		return
	}

	if validUser.Role != "admin" {
		respondWithError(w, http.StatusUnauthorized, "You have to be an admin",
			errors.New("not an admin"))
		return
	}

	role, err := cfg.db.UpdateRole(roleID, params)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't update the role", err)
		return
	}

	respondWithJson(w, http.StatusOK, cfg.databaseRoleToRole(role))
}

func (cfg Config) handlerRolesDelete(w http.ResponseWriter, r *http.Request, validUser auth.ValidUser) {
	roleID := r.PathValue("name")

	type msg struct {
		Msg string `json:"msg"`
	}

	if validUser.Role != "admin" {
		respondWithError(w, http.StatusUnauthorized, "You have to be an admin",
			errors.New("not an admin"))
		return
	}

	successMsg, err := cfg.db.DeleteRole(roleID)

	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "couldn't delete the role", err)
		return
	}

	respondWithJson(w, http.StatusOK, msg{Msg: successMsg})
}
