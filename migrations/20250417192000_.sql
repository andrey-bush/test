-- +goose Up
-- +goose StatementBegin
CREATE TABLE tg_users
(
    id         integer NOT NULL PRIMARY KEY,
    username   text,
    first_name text,
    last_name  text,
    lang       text
);

CREATE TABLE orders
(
    id                           serial                  NOT NULL,
    created_at                   timestamp DEFAULT NOW() NOT NULL,
    tg_user_id                   integer                 NOT NULL,
    subscription_expiration_date timestamp               NOT NULL,
    subscribe_id                 text,
    try                          boolean   DEFAULT FALSE NOT NULL,
    CONSTRAINT tg_users_id_fk
        FOREIGN KEY (tg_user_id) REFERENCES tg_users (id)
            ON UPDATE CASCADE ON DELETE RESTRICT
);

COMMENT ON COLUMN orders.tg_user_id IS 'ID of Telegram user';
COMMENT ON COLUMN orders.try IS 'Subscription File ID';
COMMENT ON COLUMN orders.try IS 'Test connection';

CREATE INDEX orders_tg_id_idx
    ON orders (tg_user_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE orders CASCADE;
DROP TABLE tg_users CASCADE;
-- +goose StatementEnd