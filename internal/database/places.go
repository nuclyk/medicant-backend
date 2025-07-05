package database

import "fmt"

type Place struct {
	Id       int
	Name     string
	Room     string
	Capacity string
}

const createPlace = `
	INSERT INTO
	  places (name, room, capacity)
	VALUES
	  (?, ?, ?);
	`

func (c Client) CreatePlace(params Place) (*Place, error) {
	c.log.Println("Creating new place")

	_, err := c.db.Exec(createPlace, params.Name, params.Room, params.Capacity)

	if err != nil {
		return nil, err
	}

	place, err := c.GetPlace(params.Name)

	if err != nil {
		return &Place{}, err
	}

	return &place, nil
}

const getPlace = `
	SELECT
	  id,
	  name,
	  room,
	  capacity
	FROM
	  places
	WHERE
	  id = ?;
	`

func (c Client) GetPlace(id string) (Place, error) {
	c.log.Printf("Getting the place: %s\n", id)

	var place Place

	err := c.db.QueryRow(getPlace, id).Scan(&place.Id, &place.Name, &place.Room, &place.Capacity)

	if err != nil {
		return Place{}, err
	}

	return place, nil
}

const getPlaces = `
	SELECT
	  id,
	  name,
	  room,
	  capacity
	FROM
	  places;
	`

func (c Client) GetPlaces() ([]Place, error) {
	c.log.Printf("Getting all places")

	var places []Place

	rows, err := c.db.Query(getPlaces)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var place Place

		if err := rows.Scan(
			&place.Id,
			&place.Name,
			&place.Room,
			&place.Capacity,
		); err != nil {
			return nil, err
		}

		places = append(places, place)
	}

	if err := rows.Close(); err != nil {
		return nil, err
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return places, nil
}

const updatePlace = `
	UPDATE places
	SET
	  name = ?,
	  room = ?,
	  capacity = ?
	WHERE
	  id = ? 
	RETURNING 
	  name,
	  room,
	  capacity;
	`

func (c Client) UpdatePlace(id string, params Place) (*Place, error) {
	c.log.Printf("Updating place: %s", params.Name)

	row := c.db.QueryRow(updatePlace, params.Name, params.Room, params.Capacity, id)

	if row.Err() != nil {
		return nil, row.Err()
	}

	var place Place

	if err := row.Scan(&place.Name, &place.Room, &place.Capacity); err != nil {
		return nil, err
	}

	return &place, nil
}

const deletePlace = `
	DELETE FROM places
	WHERE id = ?;
	`

func (c Client) DeletePlace(id string) (string, error) {
	c.log.Printf("Deleting a place: %s", id)

	_, err := c.db.Exec(deletePlace, id)

	if err != nil {
		return "", err
	}

	return fmt.Sprintf("Place `%s` was deleted", id), nil
}
