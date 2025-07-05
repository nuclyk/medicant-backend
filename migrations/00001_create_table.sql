-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT (datetime ('now')),
  updated_at TIMESTAMP DEFAULT (datetime ('now')),
  first_name TEXT NOT NULL DEFAULT '',
  last_name TEXT NOT NULL DEFAULT '',
  password TEXT NOT NULL DEFAULT '',
  email TEXT UNIQUE NOT NULL,
  phone TEXT NOT NULL DEFAULT '',
  age TEXT NOT NULL DEFAULT '',
  gender TEXT NOT NULL DEFAULT '',
  nationality TEXT NOT NULL DEFAULT '',
  role TEXT NOT NULL DEFAULT 'participant',
  retreat_id INTEGER NOT NULL DEFAULT 0,
  check_in_date DATETIME DEFAULT (datetime ('now')),
  check_out_date DATETIME,
  leave_date DATETIME,
  diet TEXT DEFAULT 'None',
  place TEXT NOT NULL DEFAULT 0,
  donation INTEGER NOT NULL DEFAULT 0,
  is_checked_in BOOLEAN NOT NULL DEFAULT 1,
  FOREIGN KEY (role) REFERENCES roles (name) ON UPDATE CASCADE ON DELETE SET DEFAULT,
  FOREIGN KEY (retreat_id) REFERENCES retreats (id) ON UPDATE CASCADE ON DELETE SET DEFAULT,
  FOREIGN KEY (place) REFERENCES places (id) ON UPDATE CASCADE ON DELETE SET DEFAULT
);

CREATE TABLE IF NOT EXISTS retreats (
  id INTEGER PRIMARY KEY,
  retreat_code TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT (datetime ('now')),
  updated_at TIMESTAMP NOT NULL DEFAULT (datetime ('now')),
  type TEXT NOT NULL CHECK (type IN ('fixed', 'flexible')),
  start_date DATETIME,
  end_date DATETIME
);

CREATE TABLE IF NOT EXISTS roles (name TEXT PRIMARY KEY);

CREATE TABLE IF NOT EXISTS refresh_tokens (
  token TEXT PRIMARY KEY,
  created_at TEXT DEFAULT (datetime ('now')),
  updated_at TEXT DEFAULT (datetime ('now')),
  revoked_at TEXT,
  user_id TEXT NOT NULL,
  expires_at TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS places (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL DEFAULT "",
  room TEXT NOT NULL DEFAULT "",
  capacity INTEGER NOT NULL DEFAULT 0
);

PRAGMA foreign_keys = ON;

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
DROP TABLE users;

DROP TABLE retreats;

DROP TABLE roles;

DROP TABLE refresh_tokens;

DROP TABLE places;

-- +goose StatementEnd
