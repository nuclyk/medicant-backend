-- +goose Up
-- +goose StatementBegin
CREATE VIEW "checked_in" AS
select
  COUNT(*) as checked_in
FROM
  users
WHERE
  is_checked_in = 1;

CREATE VIEW "arrived_today" AS
select
  count(*) "arrived_today"
from
  "users"
where
  is_checked_in = 1
  and date(check_in_date) = date("now");

CREATE VIEW "male" AS
select
  COUNT(*) males
from
  "users"
where
  gender = "Male"
  and is_checked_in = 1;

CREATE VIEW "female" AS
select
  COUNT(*) females
from
  "users"
where
  gender = "Female"
  and is_checked_in = 1;

CREATE VIEW "leaving_today" AS
select
  count(*) leaving_today
from
  "users"
where
  is_checked_in = 1
  and date(leave_date) = date("now");

CREATE VIEW "vegetarian" AS
select
  count(*) veg
from
  "users"
where
  is_checked_in = 1
  and diet = "Vegetarian";

CREATE VIEW "volunteers" AS
select
  count(*) volunteers
from
  "users"
where
  is_checked_in = 1
  and role = "volunteer";

CREATE VIEW "stats" AS
select
  *
from
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
DROP checked_in;

DROP female;

DROP male;

DROP arrived_today;

DROP leaving_today;

DROP volunteers;

DROP vegetarian;

-- +goose StatementEnd
