package main

import (
	"github.com/google/uuid"

	"github.com/nuclyk/medicant/internal/database"
)

// Place model --------------------------------
type Place struct {
	Name     string `json:"name,omitempty"`
	Capacity string `json:"capacity,omitempty"`
}

func (cfg Config) databasePlaceToPlace(place *database.Place) Place {
	return Place{
		Name:     place.Name,
		Capacity: place.Capacity,
	}
}

func (cfg Config) databasePlacesToPlaces(dbPlaces []database.Place) []Place {
	var places []Place

	for _, place := range dbPlaces {
		places = append(places, Place{
			Name:     place.Name,
			Capacity: place.Capacity,
		})
	}

	return places
}

// Role model --------------------------------
type Role struct {
	Name string `json:"name"`
}

func (cfg Config) databaseRoleToRole(role *database.Role) Role {
	return Role{
		Name: role.Name,
	}
}

func (cfg Config) databaseRolesToRoles(dbRoles []database.Role) []Role {
	var roles []Role

	for _, role := range dbRoles {
		roles = append(roles, Role{
			Name: role.Name,
		})
	}

	return roles
}

// User model --------------------------------

type User struct {
	ID           uuid.UUID `json:"id"`
	Created_at   *string   `json:"created_at"`
	Updated_at   *string   `json:"updated_at"`
	FirstName    string    `json:"first_name"`
	LastName     string    `json:"last_name"`
	Email        string    `json:"email"`
	Phone        string    `json:"phone"`
	Age          string    `json:"age"`
	Gender       string    `json:"gender"`
	Nationality  string    `json:"nationality"`
	Role         string    `json:"role"`
	RetreatID    int       `json:"retreat_id"`
	CheckInDate  string    `json:"check_in_date"`
	CheckOutDate string    `json:"check_out_date"`
	LeaveDate    string    `json:"leave_date"`
	IsCheckedIn  *bool     `json:"is_checked_in"`
	Diet         string    `json:"diet"`
	Place        string    `json:"place"`
}

func (cfg Config) databaseUserToUser(user *database.User) User {
	var date string
	var diet string

	if user.CheckOutDate != nil {
		date = *user.CheckOutDate
	}

	if user.Diet != nil {
		diet = *user.Diet
	}

	return User{
		ID:           user.ID,
		Created_at:   &user.Created_at,
		Updated_at:   &user.Updated_at,
		FirstName:    user.FirstName,
		LastName:     user.LastName,
		Email:        user.Email,
		Phone:        user.Phone,
		Age:          user.Age,
		Gender:       user.Gender,
		Nationality:  user.Nationality,
		Role:         user.Role,
		RetreatID:    user.RetreatID,
		CheckInDate:  user.CheckInDate,
		CheckOutDate: date,
		LeaveDate:    user.LeaveDate,
		IsCheckedIn:  user.IsCheckedIn,
		Diet:         diet,
		Place:        user.Place,
	}
}

func (cfg Config) databaseUsersToUsers(dbUsers []database.User) []User {
	var users []User

	for _, user := range dbUsers {
		var date string
		var diet string

		if user.CheckOutDate != nil {
			date = *user.CheckOutDate
		}

		if user.Diet != nil {
			diet = *user.Diet
		}

		users = append(users, User{
			ID:           user.ID,
			Created_at:   &user.Created_at,
			Updated_at:   &user.Updated_at,
			FirstName:    user.FirstName,
			LastName:     user.LastName,
			Email:        user.Email,
			Phone:        user.Phone,
			Age:          user.Age,
			Gender:       user.Gender,
			Nationality:  user.Nationality,
			Role:         user.Role,
			RetreatID:    user.RetreatID,
			CheckInDate:  user.CheckInDate,
			CheckOutDate: date,
			LeaveDate:    user.LeaveDate,
			IsCheckedIn:  user.IsCheckedIn,
			Diet:         diet,
			Place:        user.Place,
		})
	}

	return users
}

type Retreat struct {
	ID          int    `json:"id"`
	RetreatCode string `json:"retreat_code"`
	Created_at  string `json:"created_at"`
	Updated_at  string `json:"updated_at"`
	Type        string `json:"type"`
	Start_date  string `json:"start_date"`
	End_date    string `json:"end_date"`
}

func (cfg Config) databaseRetreatToRetreat(retreat *database.Retreat) Retreat {
	var startDate string
	var endDate string

	if retreat.Start_date != nil {
		startDate = *retreat.Start_date
	}

	if retreat.End_date != nil {
		endDate = *retreat.End_date
	}

	return Retreat{
		ID:          retreat.ID,
		RetreatCode: retreat.RetreatCode,
		Created_at:  retreat.Created_at,
		Updated_at:  retreat.Updated_at,
		Type:        retreat.Type,
		Start_date:  startDate,
		End_date:    endDate,
	}
}

func (cfg Config) databaseRetreatsToRetreats(dbRetreats []database.Retreat) []Retreat {
	var retreats []Retreat

	for _, retreat := range dbRetreats {
		var startDate string
		var endDate string

		if retreat.Start_date != nil {
			startDate = *retreat.Start_date
		}

		if retreat.End_date != nil {
			endDate = *retreat.End_date
		}

		retreats = append(retreats, Retreat{
			ID:          retreat.ID,
			RetreatCode: retreat.RetreatCode,
			Created_at:  retreat.Created_at,
			Updated_at:  retreat.Updated_at,
			Type:        retreat.Type,
			Start_date:  startDate,
			End_date:    endDate,
		})
	}

	return retreats
}
