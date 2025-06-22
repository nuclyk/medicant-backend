package database

import (
	"fmt"
)

type Role struct {
	Name string
}

const createRole = `
	INSERT INTO
	  roles(name)
	VALUES
	  (?);
	`

func (c Client) CreateRole(params Role) (*Role, error) {
	c.log.Println("Creating new role")
	_, err := c.db.Exec(createRole, params.Name)
	if err != nil {
		return nil, fmt.Errorf("couldn't create new role: %v", err)
	}

	role, err := c.GetRole(params.Name)
	if err != nil {
		return nil, fmt.Errorf("couldn't get the new role: %v", err)
	}

	return role, nil
}

const getRole = `
	SELECT
	  *
	FROM
	  ROLES
	WHERE
	  name = ?;
	`

func (c Client) GetRole(name string) (*Role, error) {
	c.log.Println("Getting the role")

	var role Role

	row := c.db.QueryRow(getRole, name)
	if err := row.Err(); err != nil {
		return nil, err
	}

	if err := row.Scan(&role.Name); err != nil {
		return nil, err
	}

	return &role, nil
}

const getRoles = `
	SELECT
	  *
	FROM
	  roles;
	`

func (c Client) GetRoles() ([]Role, error) {
	c.log.Println("Getting all roles")

	rows, err := c.db.Query(getRoles)
	if err != nil {
		return nil, fmt.Errorf("couldn't execute a query: %v", err)
	}
	defer rows.Close()

	var roles []Role

	for rows.Next() {
		var role Role

		err := rows.Scan(
			&role.Name,
		)

		if err != nil {
			return nil, fmt.Errorf("couldn't scan a row: %v", err)
		}

		roles = append(roles, role)
	}
	return roles, nil
}

const updateRole = `
	UPDATE
	  roles
	SET
	  name = ?
	WHERE
	  name = ? RETURNING name;
    `

func (c Client) UpdateRole(id string, params Role) (*Role, error) {
	c.log.Printf("Updating role: %s", id)

	row := c.db.QueryRow(updateRole, params.Name, id)
	if row.Err() != nil {
		return nil, fmt.Errorf("couldn't update the role: %v", row.Err())
	}

	var role Role
	err := row.Scan(&role.Name)
	if err != nil {
		return nil, err
	}

	return &role, nil
}

const deleteRole = `
	DELETE FROM
	  roles
	WHERE
	  name = ? RETURNING name;
    `

func (c Client) DeleteRole(name string) (string, error) {
	c.log.Printf("Deleting the role: `%s`\n", name)

	_, err := c.db.Exec(deleteRole, name)

	if err != nil {
		return "", fmt.Errorf("couldn't update the role: %v", err)
	}

	return fmt.Sprintf("Role with the id `%s` was deleted", name), nil
}
