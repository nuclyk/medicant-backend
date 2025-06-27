package database

import "fmt"

type Place struct {
	Name     string
	Capacity string
}

const createPlace = `
	INSERT INTO
	  places (name, capacity)
	VALUES
	  (?, ?);
	`

func (c Client) CreatePlace(params Place) (*Place, error) {
	c.log.Println("Creating new place")

	_, err := c.db.Exec(createPlace, params.Name, params.Capacity)

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
	  name,
	  capacity
	FROM
	  places
	WHERE
	  name = ?;
	`

func (c Client) GetPlace(name string) (Place, error) {
	c.log.Printf("Getting the place: %s\n", name)

	var place Place

	err := c.db.QueryRow(getPlace, name).Scan(&place.Name, &place.Capacity)

	if err != nil {
		return Place{}, err
	}

	return place, nil
}

const getPlaces = `
	SELECT
	  name,
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
			&place.Name,
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
	  capacity = ?
	WHERE
	  name = ? RETURNING name,
	  capacity;
	`

func (c Client) UpdatePlace(name string, params Place) (*Place, error) {
	c.log.Printf("Updating place: %s", params.Name)

	row := c.db.QueryRow(updatePlace, params.Name, params.Capacity, name)

	if row.Err() != nil {
		return nil, row.Err()
	}

	var place Place

	if err := row.Scan(&place.Name, &place.Capacity); err != nil {
		return nil, err
	}

	return &place, nil
}

const deletePlace = `
	DELETE FROM places
	WHERE name = ?;
	`

func (c Client) DeletePlace(name string) (string, error) {
	c.log.Printf("Deleting a place: %s", name)

	_, err := c.db.Exec(deletePlace, name)

	if err != nil {
		return "", err
	}

	return fmt.Sprintf("Place `%s` was deleted", name), nil
}
