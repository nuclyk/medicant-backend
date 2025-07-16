-- +goose Up
-- +goose StatementBegin
create table if not exists users_logs (
  user_id integer not null,
  log_id integer not null,
  primary key (user_id, log_id),
  foreign key (user_id) references users (id),
  foreign key (log_id) references logs (id)
);

create table if not exists logs (
  id integer primary key,
  check_in_date datetime,
  check_out_date datetime,
  donated integer,
  place_id integer,
  room_id integer
);

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
drop table users_logs;

drop table logs;

-- +goose StatementEnd
