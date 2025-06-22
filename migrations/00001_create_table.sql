-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  created_at TEXT DEFAULT (datetime ('now', 'localtime')),
  updated_at TEXT DEFAULT (datetime ('now', 'localtime')),
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  password TEXT NOT NULL DEFAULT '',
  email TEXT UNIQUE NOT NULL,
  phone TEXT UNIQUE NOT NULL,
  age TEXT NOT NULL DEFAULT "",
  gender TEXT NOT NULL,
  nationality TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'participant',
  retreat_id INTEGER NOT NULL DEFAULT 0,
  check_in_date TEXT DEFAULT (datetime ('now', 'localtime')),
  check_out_date TEXT,
  leave_date TEXT NOT NULL,
  is_checked_in BOOL NOT NULL DEFAULT 1,
  diet TEXT,
  place TEXT NOT NULL DEFAULT 'None',
  FOREIGN KEY (role) REFERENCES roles (name) ON UPDATE CASCADE,
  FOREIGN KEY (retreat_id) REFERENCES retreats (id) ON UPDATE CASCADE ON DELETE SET DEFAULT,
  FOREIGN KEY (place) REFERENCES places (name) ON UPDATE CASCADE ON DELETE SET DEFAULT
);

CREATE TABLE IF NOT EXISTS retreats (
  id INTEGER PRIMARY KEY,
  retreat_code TEXT NOT NULL,
  created_at TEXT DEFAULT (datetime ('now', 'localtime')),
  updated_at TEXT DEFAULT (datetime ('now', 'localtime')),
  type TEXT NOT NULL CHECK (type IN ('fixed', 'flexible')),
  start_date TEXT,
  end_date TEXT
);

CREATE TABLE IF NOT EXISTS roles (name TEXT PRIMARY KEY);

CREATE TABLE IF NOT EXISTS refresh_tokens (
  token TEXT PRIMARY KEY,
  created_at TEXT DEFAULT (datetime ('now', 'localtime')),
  updated_at TEXT DEFAULT (datetime ('now', 'localtime')),
  revoked_at TEXT,
  user_id TEXT NOT NULL,
  expires_at TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS places (name TEXT PRIMARY KEY, capacity INTEGER NOT NULL);

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
