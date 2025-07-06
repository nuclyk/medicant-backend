-- +goose Up
-- +goose StatementBegin
ALTER TABLE places
ADD COLUMN is_clean BOOLEAN NOT NULL DEFAULT 1;

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
ALTER TABLE places
DROP COLUMN is_clean;

-- +goose StatementEnd
