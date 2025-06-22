-- +goose Up
-- +goose StatementBegin
INSERT INTO
  places (name, capacity)
VALUES
  ('None', 0);

INSERT INTO
  roles (name)
VALUES
  ("participant"),
  ("admin"),
  ("volunteer");

INSERT INTO
  retreats (id, retreat_code, type)
VALUES
  (0, "flex", "flexible");

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
DELETE from places;

DELETE from roles;

DELETE from retreats;

-- +goose StatementEnd
