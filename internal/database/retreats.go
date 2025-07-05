package database

import (
	"database/sql"
	"fmt"
	"strconv"
	"time"
)

type Retreat struct {
	ID          int
	RetreatCode string
	Created_at  time.Time
	Updated_at  time.Time
	CreateRetreatParams
}

type CreateRetreatParams struct {
	Type       string
	Start_date sql.NullTime
	End_date   sql.NullTime
}

const createRetreat = `
	INSERT INTO
	  retreats (
		retreat_code,
		type,
		start_date,
		end_date
	  )
	VALUES
	  (?,?,?,?);
    `

func (c Client) CreateRetreat(params CreateRetreatParams) (*Retreat, error) {
	c.log.Println("Creating new retreat")

	day := params.Start_date.Time.Day()
	month := params.Start_date.Time.Month()

	retreat_code := fmt.Sprintf("%s-%v-%v", params.Type[:3], day, month)

	result, err := c.db.Exec(createRetreat,
		retreat_code,
		params.Type,
		params.Start_date,
		params.End_date,
	)

	if err != nil {
		return nil, err
	}

	id, _ := result.LastInsertId()

	retreat, err := c.GetRetreat(strconv.FormatInt(id, 10))
	if err != nil {
		return nil, err
	}

	return retreat, nil
}

const getRetreats = ` 
	SELECT
	  *
	FROM
	  retreats;
	`

func (c Client) GetRetreats() (*[]Retreat, error) {
	c.log.Println("Getting all retreats")

	rows, err := c.db.Query(getRetreats)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var retreats []Retreat

	for rows.Next() {
		var retreat Retreat
		if err := rows.Scan(
			&retreat.ID,
			&retreat.RetreatCode,
			&retreat.Created_at,
			&retreat.Updated_at,
			&retreat.Type,
			&retreat.Start_date,
			&retreat.End_date,
		); err != nil {
			return nil, err
		}
		retreats = append(retreats, retreat)
	}

	if err := rows.Close(); err != nil {
		return nil, err
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	if rows.Err() != nil {
		return nil, err
	}

	return &retreats, nil
}

const getRetreat = `
	SELECT
	  *
	FROM
	  retreats
	WHERE
	  id = ?;
    `

func (c Client) GetRetreat(id string) (*Retreat, error) {
	c.log.Printf("Getting a retreat with id: %v", id)

	row := c.db.QueryRow(getRetreat, id)

	var retreat Retreat

	if err := row.Scan(
		&retreat.ID,
		&retreat.RetreatCode,
		&retreat.Created_at,
		&retreat.Updated_at,
		&retreat.Type,
		&retreat.Start_date,
		&retreat.End_date,
	); err != nil {
		return nil, err
	}

	if err := row.Err(); err != nil {
		return nil, err
	}

	return &retreat, nil
}

const updateRetreat = `
	UPDATE
	  retreats
	SET
	  updated_at = datetime('now'),
	  type = ?,
	  retreat_code = ?,
	  start_date = ?,
	  end_date = ?
	WHERE
	  id = ?
	RETURNING id,
	  created_at,
	  updated_at,
	  retreat_code,
	  type,
	  start_date,
	  end_date;
	`

func (c Client) UpdateRetreat(id string, params Retreat) (Retreat, error) {
	c.log.Println("Updating retreat")

	row := c.db.QueryRow(updateRetreat,
		params.Type,
		params.RetreatCode,
		params.Start_date,
		params.End_date,
		id,
	)

	if row.Err() != nil {
		return Retreat{}, row.Err()
	}

	var retreat Retreat

	if err := row.Scan(
		&retreat.ID,
		&retreat.Created_at,
		&retreat.Updated_at,
		&retreat.RetreatCode,
		&retreat.Type,
		&retreat.Start_date,
		&retreat.End_date,
	); err != nil {
		return Retreat{}, err
	}

	return retreat, nil
}

const deleteRetreat = `
	DELETE FROM
	  retreats
	WHERE
	  id = ?;
    `

func (c Client) DeleteRetreat(id string) (string, error) {
	c.log.Printf("Deleting a retreat with id: %s", id)

	_, err := c.db.Exec(deleteRetreat, id)
	if err != nil {
		return "", err
	}

	return fmt.Sprintf("Retreat with id %s was deleted", id), nil
}
