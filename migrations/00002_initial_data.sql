-- +goose Up
-- +goose StatementBegin
INSERT INTO
  places (id, name, capacity, room)
VALUES
  (0, 'None', 0, "");

INSERT INTO
  roles (name)
VALUES
  ("admin"),
  ("volunteer"),
  ("participant");

INSERT INTO
  retreats (id, retreat_code, type)
VALUES
  (0, "flexible", "flexible");

INSERT INTO
  users (id, password, email, role)
VALUES
  (
    "00000000-0000-0000-0000-000000000000",
    "$2a$12$arFsFZuNvcoRmtisfuJ9re0ByNVDjA6twSEvGC71C7ji8eOtNaccy",
    "admin@medicant.cc",
    "admin"
  );

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
DELETE from refresh_tokens;

DELETE from users;

DELETE from roles;

DELETE from places;

DELETE from retreats;

-- +goose StatementEnd
