PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS goose_db_version (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		version_id INTEGER NOT NULL,
		is_applied INTEGER NOT NULL,
		tstamp TIMESTAMP DEFAULT (datetime('now'))
	);
INSERT INTO goose_db_version VALUES(1,0,1,'2025-06-28 02:51:26');
INSERT INTO goose_db_version VALUES(47,1,1,'2025-07-05 08:33:35');
INSERT INTO goose_db_version VALUES(48,2,1,'2025-07-05 08:33:36');
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT (datetime ('now')),
  updated_at TIMESTAMP DEFAULT (datetime ('now')),
  first_name TEXT NOT NULL DEFAULT '',
  last_name TEXT NOT NULL DEFAULT '',
  password TEXT NOT NULL DEFAULT '',
  email TEXT UNIQUE NOT NULL,
  phone TEXT NOT NULL DEFAULT '',
  age TEXT NOT NULL DEFAULT '',
  gender TEXT NOT NULL DEFAULT '',
  nationality TEXT NOT NULL DEFAULT '',
  role TEXT NOT NULL DEFAULT 'participant',
  retreat_id INTEGER NOT NULL DEFAULT 1,
  check_in_date DATETIME DEFAULT (datetime ('now')),
  check_out_date DATETIME,
  leave_date DATETIME,
  diet TEXT DEFAULT 'None',
  place INTEGER NOT NULL DEFAULT 1,
  donation INTEGER NOT NULL DEFAULT 0,
  is_checked_in BOOLEAN NOT NULL DEFAULT 1,
  FOREIGN KEY (role) REFERENCES roles (name) ON UPDATE CASCADE ON DELETE SET DEFAULT,
  FOREIGN KEY (retreat_id) REFERENCES retreats (id) ON UPDATE CASCADE ON DELETE SET DEFAULT,
  FOREIGN KEY (place) REFERENCES places (id) ON UPDATE CASCADE ON DELETE SET DEFAULT
);
INSERT INTO users VALUES('00000000-0000-0000-0000-000000000000','2025-07-05 08:33:35','2025-07-05 08:33:35','','','$2a$12$arFsFZuNvcoRmtisfuJ9re0ByNVDjA6twSEvGC71C7ji8eOtNaccy','admin@medicant.cc','','','','','admin',1,'2025-07-05 08:33:35',NULL,NULL,'None',1,0,1);
INSERT INTO users VALUES('a76dcb7d-2c31-4532-98f6-594f19289077','2025-07-05 08:35:05','2025-07-05 10:43:34','test','test','','zoe@gmail.com','123','11','Female','Åland Islands','participant',1,'2025-07-05 10:43:33.978+00:00',NULL,'2025-07-12 00:00:00+00:00','Vegetarian',1,0,1);
INSERT INTO users VALUES('87acccb7-664b-4a7b-8674-83ad82d24fe7','2025-07-05 10:37:30','2025-07-05 10:37:30','Jack','Noone','','jack@gmail.com','07123123','','Male','Afghanistan','participant',1,'2025-07-05 10:37:30',NULL,'2025-07-11 00:00:00+00:00','Vegetarian',1,0,1);
CREATE TABLE IF NOT EXISTS retreats (
  id INTEGER PRIMARY KEY,
  retreat_code TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT (datetime ('now')),
  updated_at TIMESTAMP NOT NULL DEFAULT (datetime ('now')),
  type TEXT NOT NULL CHECK (type IN ('fixed', 'flexible')),
  start_date DATETIME,
  end_date DATETIME
);
INSERT INTO retreats VALUES(1,'flexible','2025-07-05 08:33:35','2025-07-05 08:33:35','flexible',NULL,NULL);
INSERT INTO retreats VALUES(2,'fix-5-July','2025-07-05 10:27:05','2025-07-05 10:27:05','fixed','2025-07-05 00:00:00+00:00','2025-07-07 00:00:00+00:00');
CREATE TABLE IF NOT EXISTS roles (name TEXT PRIMARY KEY);
INSERT INTO roles VALUES('admin');
INSERT INTO roles VALUES('volunteer');
INSERT INTO roles VALUES('participant');
CREATE TABLE IF NOT EXISTS refresh_tokens (
  token TEXT PRIMARY KEY,
  created_at TEXT DEFAULT (datetime ('now')),
  updated_at TEXT DEFAULT (datetime ('now')),
  revoked_at TEXT,
  user_id TEXT NOT NULL,
  expires_at TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id)
);
INSERT INTO refresh_tokens VALUES('53fb674622ab92d5c13f4a0961958c29c2440dc961f1968513e2aaa418913578','2025-07-05 08:54:50','2025-07-05 08:54:50',NULL,'00000000-0000-0000-0000-000000000000','2025-08-04 15:54:50.176569 +0700 +07 m=+2592072.559390293');
INSERT INTO refresh_tokens VALUES('b94a1c1c66d4899d41024f710729aaf9ee669929e817d7d91b2ae9028dad5a33','2025-07-05 09:05:50','2025-07-05 09:05:50',NULL,'00000000-0000-0000-0000-000000000000','2025-08-04 16:05:50.755527 +0700 +07 m=+2592251.827540751');
CREATE TABLE IF NOT EXISTS places (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL DEFAULT "",
  room TEXT NOT NULL DEFAULT "",
  capacity INTEGER NOT NULL DEFAULT 0
);
INSERT INTO places VALUES(1,'None','0',0);
INSERT INTO places VALUES(2,'Yellow Housea','123',6);
INSERT INTO places VALUES(3,'aaa','0',0);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('goose_db_version',48);
COMMIT;
