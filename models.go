// These functions convert the database model to JSON model.

package main

import (
	"time"

	"github.com/google/uuid"

	"github.com/nuclyk/medicant/internal/database"
)

type Stats struct {
	CheckedIn    int `json:"checked_in"`
	ArrivedToday int `json:"arrived_today"`
	LeavingToday int `json:"leaving_today"`
	Males        int `json:"males"`
	Females      int `json:"females"`
	Vegetarian   int `json:"vegetarian"`
	Volunteers   int `json:"volunteers"`
}

func (cfg Config) dbStatsToStats(stats *database.Stats) Stats {
	return Stats{
		CheckedIn:    stats.CheckedIn,
		ArrivedToday: stats.ArrivedToday,
		LeavingToday: stats.LeavingToday,
		Males:        stats.Males,
		Females:      stats.Females,
		Vegetarian:   stats.Vegetarian,
		Volunteers:   stats.Volunteers,
	}
}

// Room model --------------------------------
type Room struct {
	Id        int   `json:"id"`
	Number    int   `json:"number"`
	Capacity  int   `json:"capacity"`
	CheckedIn int   `json:"checked_in"`
	PlaceId   int   `json:"place_id"`
	IsClean   *bool `json:"is_clean"`
}

func (cfg Config) databaseRoomToRoom(room *database.Room) Room {
	return Room{
		Id:        room.Id,
		Number:    room.Number,
		Capacity:  room.Capacity,
		CheckedIn: room.CheckedIn,
		PlaceId:   room.PlaceId,
		IsClean:   &room.IsClean,
	}
}

func (cfg Config) databaseRoomsToRooms(dbRooms []database.Room) []Room {
	var rooms []Room

	for _, room := range dbRooms {
		rooms = append(rooms, Room{
			Id:        room.Id,
			Number:    room.Number,
			Capacity:  room.Capacity,
			CheckedIn: room.CheckedIn,
			PlaceId:   room.PlaceId,
			IsClean:   &room.IsClean,
		})
	}

	return rooms
}

// Place model --------------------------------
type Place struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

func (cfg Config) databasePlaceToPlace(place *database.Place) Place {
	return Place{
		Id:   place.Id,
		Name: place.Name,
	}
}

func (cfg Config) databasePlacesToPlaces(dbPlaces []database.Place) []Place {
	var places []Place

	for _, place := range dbPlaces {
		places = append(places, Place{
			Id:   place.Id,
			Name: place.Name,
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
	Created_at   time.Time `json:"created_at"`
	Updated_at   time.Time `json:"updated_at"`
	FirstName    string    `json:"first_name"`
	LastName     string    `json:"last_name"`
	Email        string    `json:"email"`
	Phone        string    `json:"phone"`
	Age          string    `json:"age"`
	Gender       string    `json:"gender"`
	Nationality  string    `json:"nationality"`
	Role         string    `json:"role"`
	RetreatID    int       `json:"retreat_id"`
	CheckInDate  time.Time `json:"check_in_date"`
	CheckOutDate time.Time `json:"check_out_date"`
	LeaveDate    time.Time `json:"leave_date"`
	Diet         string    `json:"diet"`
	Place        int       `json:"place"`
	RoomId       *int      `json:"room_id"`
	IsCheckedIn  bool      `json:"is_checked_in"`
	Donation     int       `json:"donation"`
}

func (cfg Config) databaseUserToUser(user *database.User) User {
	return User{
		ID:           user.ID,
		Created_at:   user.Created_at,
		Updated_at:   user.Updated_at,
		FirstName:    user.FirstName,
		LastName:     user.LastName,
		Email:        user.Email,
		Phone:        user.Phone,
		Age:          user.Age,
		Gender:       user.Gender,
		Nationality:  user.Nationality,
		Role:         user.Role,
		RetreatID:    user.RetreatID,
		CheckInDate:  user.CheckInDate.Time,
		CheckOutDate: user.CheckOutDate.Time,
		LeaveDate:    user.LeaveDate.Time,
		Diet:         user.Diet.String,
		Place:        user.Place,
		RoomId:       user.RoomId,
		IsCheckedIn:  user.IsCheckedIn,
		Donation:     user.Donation,
	}
}

func (cfg Config) databaseUsersToUsers(dbUsers []database.User) []User {
	var users []User

	for _, user := range dbUsers {
		users = append(users, User{
			ID:           user.ID,
			Created_at:   user.Created_at,
			Updated_at:   user.Updated_at,
			FirstName:    user.FirstName,
			LastName:     user.LastName,
			Email:        user.Email,
			Phone:        user.Phone,
			Age:          user.Age,
			Gender:       user.Gender,
			Nationality:  user.Nationality,
			Role:         user.Role,
			RetreatID:    user.RetreatID,
			CheckInDate:  user.CheckInDate.Time,
			CheckOutDate: user.CheckOutDate.Time,
			LeaveDate:    user.LeaveDate.Time,
			Diet:         user.Diet.String,
			Place:        user.Place,
			RoomId:       user.RoomId,
			IsCheckedIn:  user.IsCheckedIn,
			Donation:     user.Donation,
		})
	}

	return users
}

type Retreat struct {
	ID          int       `json:"id"`
	RetreatCode string    `json:"retreat_code"`
	Created_at  string    `json:"created_at"`
	Updated_at  string    `json:"updated_at"`
	Type        string    `json:"type"`
	Start_date  time.Time `json:"start_date"`
	End_date    time.Time `json:"end_date"`
}

func (cfg Config) databaseRetreatToRetreat(retreat *database.Retreat) Retreat {
	return Retreat{
		ID:          retreat.ID,
		RetreatCode: retreat.RetreatCode,
		Created_at:  retreat.Created_at.String(),
		Updated_at:  retreat.Updated_at.String(),
		Type:        retreat.Type,
		Start_date:  retreat.Start_date.Time,
		End_date:    retreat.End_date.Time,
	}
}

func (cfg Config) databaseRetreatsToRetreats(dbRetreats []database.Retreat) []Retreat {
	var retreats []Retreat

	for _, retreat := range dbRetreats {
		retreats = append(retreats, Retreat{
			ID:          retreat.ID,
			RetreatCode: retreat.RetreatCode,
			Created_at:  retreat.Created_at.String(),
			Updated_at:  retreat.Updated_at.String(),
			Type:        retreat.Type,
			Start_date:  retreat.Start_date.Time,
			End_date:    retreat.End_date.Time,
		})
	}

	return retreats
}
