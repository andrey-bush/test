-- +goose Up
-- +goose StatementBegin
ALTER TABLE tg_users
    ALTER COLUMN id TYPE bigint USING id::bigint;

ALTER TABLE orders
    ALTER COLUMN tg_user_id TYPE bigint USING tg_user_id::bigint;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin


-- +goose StatementEnd