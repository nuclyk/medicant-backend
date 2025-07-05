package database

import (
	"database/sql"
	"fmt"
	"time"

	"github.com/google/uuid"

	"github.com/nuclyk/medicant/internal/auth"
)

type User struct {
	ID         uuid.UUID
	Created_at time.Time
	Updated_at time.Time
	CreateUserParams
}

type CreateUserParams struct {
	FirstName    string
	LastName     string
	Password     string
	Email        string
	Phone        string
	Age          string
	Gender       string
	Nationality  string
	Role         string
	RetreatID    int
	CheckInDate  sql.NullTime
	CheckOutDate sql.NullTime
	LeaveDate    sql.NullTime
	Diet         sql.NullString
	Place        int
}

type UpdatePasswordParams struct {
	Password string
}

const createUser = `
	INSERT INTO
	  users (
		id,
		first_name,
		last_name,
		password,
		email,
		phone,
		age,
		gender,
		nationality,
		role,
		retreat_id,
		leave_date,
		diet,
		place
	  )
	VALUES
	  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    `

func (c Client) CreateUser(params CreateUserParams) (*User, error) {
	c.log.Println("Creating new user")

	id := uuid.New()

	_, err := c.db.Exec(createUser,
		id.String(),
		params.FirstName,
		params.LastName,
		params.Password,
		params.Email,
		params.Phone,
		params.Age,
		params.Gender,
		params.Nationality,
		params.Role,
		params.RetreatID,
		params.LeaveDate,
		params.Diet,
		params.Place,
	)

	if err != nil {
		return nil, err
	}

	user, err := c.GetUser(params.Email)

	if err != nil {
		return nil, err
	}

	return user, nil
}

const getUser = `
    SELECT
      id,
      created_at,
      updated_at,
      first_name,
      last_name,
      password,
      email,
      phone,
      age,
      gender,
      nationality,
      role,
      retreat_id,
      check_in_date,
      check_out_date,
      leave_date,
	  diet,
	  place
    FROM
      users
    WHERE
	id = :search_value
	OR email = :search_value
    `

func (c Client) GetUser(searchValue string) (*User, error) {
	c.log.Printf("Getting the user: %s\n", searchValue)

	row := c.db.QueryRow(getUser, sql.Named("search_value", searchValue))

	var user User

	if err := row.Scan(
		&user.ID,
		&user.Created_at,
		&user.Updated_at,
		&user.FirstName,
		&user.LastName,
		&user.Password,
		&user.Email,
		&user.Phone,
		&user.Age,
		&user.Gender,
		&user.Nationality,
		&user.Role,
		&user.RetreatID,
		&user.CheckInDate,
		&user.CheckOutDate,
		&user.LeaveDate,
		&user.Diet,
		&user.Place,
	); err != nil {
		return nil, err
	}

	if err := row.Err(); err != nil {
		return nil, err
	}

	return &user, nil
}

const userExists = `SELECT id FROM users WHERE email = ?;`

func (c Client) CheckForUser(email string) (string, error) {
	c.log.Printf("Checking if the user with email: %s exists", email)

	row := c.db.QueryRow(userExists, email)

	var id string

	if err := row.Scan(&id); err != nil {
		return "", err
	}

	if err := row.Err(); err != nil {
		return "", err
	}

	return id, nil
}

const getUsers = ` 
    SELECT
      id,
      created_at,
      updated_at,
      first_name,
      last_name,
      email,
      phone,
      age,
      gender,
      nationality,
      role,
      retreat_id,
      check_in_date,
	  check_out_date,
	  leave_date,
	  diet,
	  place
    FROM
      users;
    `

func (c Client) GetUsers() ([]User, error) {
	c.log.Println("Getting all users")

	rows, err := c.db.Query(getUsers)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var users []User

	for rows.Next() {
		var user User

		if err := rows.Scan(
			&user.ID,
			&user.Created_at,
			&user.Updated_at,
			&user.FirstName,
			&user.LastName,
			&user.Email,
			&user.Phone,
			&user.Age,
			&user.Gender,
			&user.Nationality,
			&user.Role,
			&user.RetreatID,
			&user.CheckInDate,
			&user.CheckOutDate,
			&user.LeaveDate,
			&user.Diet,
			&user.Place,
		); err != nil {
			return nil, err
		}

		users = append(users, user)
	}

	if err := rows.Close(); err != nil {
		return nil, err
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	if rows.Err() != nil {
		return nil, fmt.Errorf("couldn't get users: %v", err)
	}

	return users, nil
}

const getUserByRefreshToken = `
    SELECT
      u.id, 
      u.created_at,
      u.updated_at,
      u.email
    FROM
      users u
      JOIN refresh_tokens rt ON u.id = rt.user_id
    WHERE
      rt.token = ?;
    `

func (c Client) GetUserByRefreshToken(token string) (User, error) {
	c.log.Printf("Getting the user by refresh token: %s\n", token)

	var user User

	row := c.db.QueryRow(getUserByRefreshToken, token)

	if err := row.Scan(
		&user.ID,
		&user.Created_at,
		&user.Updated_at,
		&user.Email,
	); err != nil {
		return User{}, fmt.Errorf("couldn't scan a row: %v", err)
	}

	if err := row.Err(); err != nil {
		return User{}, fmt.Errorf("couldn't get the user: %v", err)
	}

	return user, nil
}

const updatePassword = `
    UPDATE
      users
    SET
      password = ?
    WHERE
      id = ?
    `

func (c Client) UpdatePassword(id string, password UpdatePasswordParams) (string, error) {
	hashedPassword, err := auth.HashPassword(password.Password)

	if err != nil {
		return "failed to hash the password", err
	}

	_, err = c.db.Exec(updatePassword, hashedPassword, id)

	if err != nil {
		return "password change failed", err
	}

	return "password change successful", nil
}

const checkoutUser = `UPDATE users SET check_out_date = datetime('now', '+7 hours') WHERE email = ?;`

func (c Client) CheckoutUser(email string) error {
	_, err := c.db.Exec(checkoutUser, email)
	return err
}

const updateUser = `
    UPDATE
      users
    SET
      updated_at = datetime('now'),
      first_name = ?,
      last_name = ?,
      email = ?,
      phone = ?,
      age = ?,
      gender = ?,
      nationality = ?,
      role = ?,
      retreat_id = ?,
      check_in_date = ?,
      check_out_date = ?,
      leave_date = ?,
      diet = ?,
      place = ?
    WHERE
	id = ?
    RETURNING 
      id,
      created_at,
      updated_at,
      first_name,
      last_name,
      email,
      phone,
      age,
      gender,
      nationality,
      role,
      retreat_id,
      check_in_date,
      check_out_date,
      leave_date,
	  diet,
	  place;
    `

func (c Client) UpdateUser(id string, params *User) (*User, error) {
	c.log.Println("Updating user")

	row := c.db.QueryRow(
		updateUser,
		params.FirstName,
		params.LastName,
		params.Email,
		params.Phone,
		params.Age,
		params.Gender,
		params.Nationality,
		params.Role,
		params.RetreatID,
		params.CheckInDate,
		params.CheckOutDate,
		params.LeaveDate,
		params.Diet,
		params.Place,
		id,
	)

	if row.Err() != nil {
		return nil, row.Err()
	}

	var user User

	if err := row.Scan(
		&user.ID,
		&user.Created_at,
		&user.Updated_at,
		&user.FirstName,
		&user.LastName,
		&user.Email,
		&user.Phone,
		&user.Age,
		&user.Gender,
		&user.Nationality,
		&user.Role,
		&user.RetreatID,
		&user.CheckInDate,
		&user.CheckOutDate,
		&user.LeaveDate,
		&user.Diet,
		&user.Place,
	); err != nil {
		return nil, err
	}

	return &user, nil
}

const deleteUser = `DELETE FROM users WHERE id = $1;`

func (c Client) DeleteUser(id string) (string, error) {
	c.log.Printf("Deleting the user with id: %s", id)

	_, err := c.db.Exec(deleteUser, id)

	if err != nil {
		return "", err
	}

	return fmt.Sprintf("User with the id `%s` was deleted", id), nil
}
