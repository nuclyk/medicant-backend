-- +goose Up
-- +goose StatementBegin
CREATE VIEW if not exists "participants_count" AS
select
  COUNT(*) as participants_count
FROM
  users;

CREATE VIEW if not exists "checked_in" AS
select
  COUNT(*) as checked_in
FROM
  users
WHERE
  is_checked_in = 1;

CREATE VIEW if not exists "arrived_today" AS
select
  count(*) "arrived_today"
from
  "users"
where
  is_checked_in = 1
  and date(check_in_date) = date("now");

CREATE VIEW if not exists "male" AS
select
  COUNT(*) males
from
  "users"
where
  gender = "Male"
  and is_checked_in = 1;

CREATE VIEW if not exists "female" AS
select
  COUNT(*) females
from
  "users"
where
  gender = "Female"
  and is_checked_in = 1;

CREATE VIEW if not exists "leaving_today" AS
select
  count(*) leaving_today
from
  "users"
where
  is_checked_in = 1
  and date(leave_date) = date("now");

CREATE VIEW if not exists "vegetarian" AS
select
  count(*) veg
from
  "users"
where
  is_checked_in = 1
  and diet = "Vegetarian";

CREATE VIEW if not exists "volunteers" AS
select
  count(*) volunteers
from
  "users"
where
  is_checked_in = 1
  and role = "volunteer";

CREATE VIEW if not exists "stats" AS
select
  *
from
  participants_count,
  checked_in,
  arrived_today,
  leaving_today,
  male,
  female,
  vegetarian,
  volunteers;

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
DROP view if exists participants_count;

DROP view if exists checked_in;

DROP view if exists female;

DROP view if exists male;

DROP view if exists arrived_today;

DROP view if exists leaving_today;

DROP view if exists volunteers;

DROP view if exists vegetarian;

DROP view if exists stats;

-- +goose StatementEnd
