-- +goose Up
-- +goose StatementBegin
CREATE TABLE rooms (
  id INTEGER PRIMARY KEY,
  number INTEGER NOT NULL,
  checked_in INTEGER NOT NULL DEFAULT 0,
  capacity INTEGER NOT NULL DEFAULT 1,
  place_id INTEGER NOT NULL,
  is_clean BOOLEAN NOT NULL DEFAULT 1,
  FOREIGN KEY (place_id) REFERENCES places (id) ON UPDATE CASCADE ON DELETE CASCADE CHECK (checked_in <= capacity)
);

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
DROP TABLE rooms;

-- +goose StatementEnd
