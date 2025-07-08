package database

import "fmt"

type Room struct {
	Id int
	CreateRoomParams
}

type CreateRoomParams struct {
	Number    int
	Capacity  int
	CheckedIn int
	PlaceId   int
	IsClean   bool
}

const createRoom = `
	INSERT INTO
	  rooms (number, capacity, place_id)
	VALUES
	  (?, ?, ?)
	`

func (c Client) CreateRoom(params CreateRoomParams) (*Room, error) {
	c.log.Println("Creating new room")

	result, err := c.db.Exec(createRoom, params.Number, params.Capacity, params.PlaceId)
	if err != nil {
		return nil, err
	}

	id, _ := result.LastInsertId()

	room, err := c.GetRoom(int(id))
	if err != nil {
		return nil, err
	}

	return room, err
}

const getRoom = `
	SELECT * FROM
	  rooms
	WHERE
	  id = ?;
	`

func (c Client) GetRoom(id int) (*Room, error) {
	c.log.Printf("Getting room: %v\n", id)

	var room Room

	if err := c.db.QueryRow(getRoom, id).Scan(
		&room.Id,
		&room.Number,
		&room.Capacity,
		&room.CheckedIn,
		&room.PlaceId,
		&room.IsClean,
	); err != nil {
		return &Room{}, nil
	}

	return &room, nil
}

const getRooms = `SELECT * FROM rooms;`

func (c Client) GetRooms() (*[]Room, error) {
	c.log.Printf("Getting all rooms")

	var rooms []Room

	rows, err := c.db.Query(getRooms)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var room Room
		if err := rows.Scan(
			&room.Id,
			&room.Number,
			&room.Capacity,
			&room.CheckedIn,
			&room.PlaceId,
			&room.IsClean,
		); err != nil {
			return nil, err
		}

		rooms = append(rooms, room)
	}

	if err := rows.Close(); err != nil {
		return nil, err
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return &rooms, nil
}

const updateRoom = `
	UPDATE rooms
	SET
		number = ?,
		capacity = ?,
		checked_in = ?,
		place_id = ?,
		is_clean = ?
	WHERE
		id = ?
	RETURNING
		id,
		number,
		capacity,
		checked_in,
		place_id,
		is_clean
	`

func (c Client) UpdateRoom(id string, params Room) (*Room, error) {
	c.log.Printf("Updating room number: %v", params.Number)

	row := c.db.QueryRow(
		updateRoom,
		params.Number,
		params.Capacity,
		params.CheckedIn,
		params.PlaceId,
		params.IsClean,
		id,
	)

	if row.Err() != nil {
		return nil, row.Err()
	}

	var room Room

	if err := row.Scan(
		&room.Id,
		&room.Number,
		&room.Capacity,
		&room.CheckedIn,
		&room.PlaceId,
		&room.IsClean,
	); err != nil {
		return nil, err
	}

	return &room, nil
}

const deleteRoom = `
	DELETE FROM rooms
	WHERE id = ?;
	`

func (c Client) DeleteRoom(id string) (string, error) {
	c.log.Printf("Deleting room number: %s", id)

	_, err := c.db.Exec(deleteRoom, id)

	if err != nil {
		return "", err
	}

	return fmt.Sprintf("Place `%s` was deleted", id), nil
}
