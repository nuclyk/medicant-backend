package database

import (
	"database/sql"

	"github.com/google/uuid"
)

type RefreshToken struct {
	CreatedAt string
	UpdatedAt string
	RevokedAt *string
	CreateRefreshTokenParams
}

type CreateRefreshTokenParams struct {
	Token     string
	UserID    uuid.UUID
	ExpiresAt string
}

type rtNullable struct {
	revokedAt sql.NullString
}

const createRefreshToken = `
	INSERT INTO
	  refresh_tokens (token, user_id, expires_at)
	VALUES
	  (?, ?, ?);
    ` // #nosec G101

func (c Client) CreateRefreshToken(params CreateRefreshTokenParams) (RefreshToken, error) {
	c.log.Println("Creating new refresh token")

	_, err := c.db.Exec(createRefreshToken,
		params.Token,
		params.UserID,
		params.ExpiresAt,
	)

	if err != nil {
		return RefreshToken{}, err
	}

	return c.GetRefreshToken(params.Token)
}

const getRefreshToken = `
	SELECT
	  token,
	  created_at,
	  updated_at,
	  revoked_at,
	  user_id,
	  expires_at
	FROM
	  refresh_tokens
	WHERE
	  token = ?;
    ` // #nosec G101

func (c Client) GetRefreshToken(token string) (RefreshToken, error) {
	var rt RefreshToken
	var nullRows rtNullable

	row := c.db.QueryRow(getRefreshToken, token)

	if err := row.Scan(
		&rt.Token,
		&rt.CreatedAt,
		&rt.UpdatedAt,
		&nullRows.revokedAt,
		&rt.UserID,
		&rt.ExpiresAt,
	); err != nil {
		return RefreshToken{}, err
	}

	return rt, nil
}

const revokeToken = `
	UPDATE refresh_tokens
	SET
	  revoked_at = datetime ('now', 'localtime')
	WHERE
	  token = ?;
    ` // #nosec G101

func (c Client) RevokeRefreshToken(token string) error {
	_, err := c.db.Exec(revokeToken, token)

	if err != nil {
		return err
	}

	return err
}

const deleteToken = `
    DELETE FROM
      refresh_tokens
    WHERE
      token = ?
    `

func (c Client) DeleteRefreshToken(token string) error {
	_, err := c.db.Exec(deleteToken, token)

	if err != nil {
		return err
	}

	return err
}
