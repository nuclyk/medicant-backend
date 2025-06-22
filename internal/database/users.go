package database

import (
	"database/sql"
	"fmt"

	"github.com/google/uuid"

	"github.com/nuclyk/medicant/internal/auth"
)

type User struct {
	ID         uuid.UUID
	Created_at string
	Updated_at string
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
	CheckInDate  string
	CheckOutDate *string
	LeaveDate    string
	IsCheckedIn  *bool
	Diet         *string
	Place        string
}

type UpdatePasswordParams struct {
	Password string
}

const createUser = `
	INSERT
		INTO
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
		check_out_date,
		leave_date,
		is_checked_in,
		diet,
		place
	)
	VALUES
	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
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
		params.CheckOutDate,
		params.LeaveDate,
		params.IsCheckedIn,
		params.Diet,
		params.Place,
	)

	if err != nil {
		return nil, fmt.Errorf("couldn't create the new user: %v", err)
	}

	user, err := c.GetUser(params.Email)
	if err != nil {
		return nil, fmt.Errorf("couldn't get the new created user: %v", err)
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
      is_checked_in,
	  diet,
	  place
    FROM
      users
    WHERE
      id = :search_value
      OR email = :search_value;
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
		&user.IsCheckedIn,
		&user.Diet,
		&user.Place,
	); err != nil {
		return nil, fmt.Errorf("couldn't scan a row: %v", err)
	}

	if err := row.Err(); err != nil {
		return nil, fmt.Errorf("couldn't get the user: %v", err)
	}

	return &user, nil
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
      is_checked_in,
	  diet,
	  place
    FROM
      users;
    `

func (c Client) GetUsers() ([]User, error) {
	c.log.Println("Getting all users")

	rows, err := c.db.Query(getUsers)
	if err != nil {
		return nil, fmt.Errorf("couldn't execute a query: %v", err)
	}
	defer rows.Close()

	var users []User

	for rows.Next() {
		var user User

		rows.Scan(
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
			&user.IsCheckedIn,
			&user.Diet,
			&user.Place,
		)

		users = append(users, user)
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
      id = :search_value
      OR email = :search_value;
    `

func (c Client) UpdatePassword(searchValue string, password UpdatePasswordParams) (string, error) {
	hashedPassword, err := auth.HashPassword(password.Password)
	if err != nil {
		return fmt.Sprintf("failed to hash the password"), err
	}

	_, err = c.db.Exec(updatePassword, hashedPassword, sql.Named("searchValue", searchValue))

	if err != nil {
		return fmt.Sprintf("password change failed"), err
	}

	return fmt.Sprintf("password change successful"), nil
}

const updateUser = `
    UPDATE
      users
    SET
      updated_at = datetime('now', 'localtime'),
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
      is_checked_in = ?,
      diet = ?,
      place = ?
    WHERE
	email = :search_value
	OR id = :search_value
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
      is_checked_in,
	  diet,
	  place;
    `

func (c Client) UpdateUser(searchValue string, params *User) (*User, error) {
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
		params.IsCheckedIn,
		params.Diet,
		params.Place,
		sql.Named("search_value", searchValue),
	)

	if row.Err() != nil {
		return nil, fmt.Errorf("couldn't update the user: %v", row.Err())
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
		&user.IsCheckedIn,
		&user.Diet,
		&user.Place,
	); err != nil {
		return nil, fmt.Errorf("couldn't return the updated user: %v", err)
	}

	return &user, nil
}

const deleteUser = `DELETE FROM users WHERE id = $1;`

func (c Client) DeleteUser(id string) (string, error) {
	c.log.Printf("Deleting the user with id: %s", id)

	_, err := c.db.Exec(deleteUser, id)
	if err != nil {
		return "", fmt.Errorf("couldn't delete the user: %v", err)
	}

	return fmt.Sprintf("User with the id `%s` was deleted", id), nil
}
