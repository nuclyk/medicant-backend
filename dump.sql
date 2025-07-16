PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS goose_db_version (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		version_id INTEGER NOT NULL,
		is_applied INTEGER NOT NULL,
		tstamp TIMESTAMP DEFAULT (datetime('now'))
	);
INSERT INTO goose_db_version VALUES(1,0,1,'2025-06-28 02:51:26');
INSERT INTO goose_db_version VALUES(61,1,1,'2025-07-08 06:52:28');
INSERT INTO goose_db_version VALUES(62,2,1,'2025-07-08 06:52:29');
INSERT INTO goose_db_version VALUES(64,3,1,'2025-07-08 07:04:14');
INSERT INTO goose_db_version VALUES(65,4,1,'2025-07-09 06:53:17');
INSERT INTO goose_db_version VALUES(66,5,1,'2025-07-16 09:46:06');
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
  room_id INTEGER DEFAULT NULL,
  donation INTEGER NOT NULL DEFAULT 0,
  is_checked_in BOOLEAN NOT NULL DEFAULT 1,
  FOREIGN KEY (role) REFERENCES roles (name) ON UPDATE CASCADE ON DELETE SET DEFAULT,
  FOREIGN KEY (retreat_id) REFERENCES retreats (id) ON UPDATE CASCADE ON DELETE SET DEFAULT,
  FOREIGN KEY (room_id) REFERENCES rooms (id) ON UPDATE CASCADE ON DELETE SET DEFAULT,
  FOREIGN KEY (place) REFERENCES places (id) ON UPDATE CASCADE ON DELETE SET DEFAULT
);
INSERT INTO users VALUES('00000000-0000-0000-0000-000000000000','2025-06-29 15:09:35','2025-06-29 15:09:35','','','$2a$12$atHJq3lyiTsgJzAP85ONuu4UFTCy8hOa5uM378g0MsYFpwQMV3Jqe','admin@medicant.cc','0','','','','admin',0,NULL,NULL,NULL,NULL,1,NULL,0,0);
INSERT INTO users VALUES('00000000-0000-0000-0000-000000000001','2025-07-02 21:18:52','2025-07-02 21:18:52','','','$2a$12$cd933.a3T.dk9WgSYncLouCOnFhtNpkaqq3Qqy/UiaO4b0OUHAjCq','volunteer@medicant.cc','0','','','','admin',0,NULL,NULL,NULL,NULL,1,NULL,0,0);
INSERT INTO users VALUES('00185d24-1fae-4b6d-8f0a-632f10093a24','2025-07-03 15:54:25','2025-07-09 08:40:54','Ali','Alhamoud','','ali_ah37@outlook.com','+966506881551','','Male','Saudi Arabia','participant',0,'2025-07-03 08:54:25+00:00','2025-07-09 08:40:54.226+00:00','2025-07-06 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('0147166b-1740-4314-a89f-698efa482859','2025-07-02 17:18:42','2025-07-09 08:41:25','Santiago','Santiago','','santiago@papae.com','0','','Male','Mexico','participant',0,'2025-07-02 00:00:00+00:00','2025-07-09 08:41:25.062+00:00','2025-07-03 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('103430a7-a815-46d3-b09e-8a00a884667c','2025-07-02 17:40:43','2025-07-09 08:43:11','Owen','Goulding','','goulding@papae.com','0','','Male','United Kingdom','participant',0,'2025-07-01 00:00:00+00:00','2025-07-09 08:43:11.505+00:00','2025-07-08 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('110a1d44-da76-4bcb-83b8-1d5f2d074a56','2025-07-02 17:19:48','2025-07-05 13:02:01','Su Su','Naing','','susu@papae.com','9','','Female','','participant',0,'2025-06-29','2025-07-05 13:02:01','2025-07-05','Vegetarian',1,NULL,0,0);
INSERT INTO users VALUES('14a53cbc-2b3a-4754-8dd1-5a1384ea82f0','2025-07-04 17:01:45','2025-07-09 08:40:42','Lukasz','Nowicki','','lukasz.nowicki26@gmail.com','+48662835347','','Male','Poland','participant',0,'2025-07-04 10:01:45+00:00','2025-07-09 08:40:42.606+00:00','2025-07-07 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('1776d1a4-4579-430b-9796-aefb7bdef08b','2025-07-05 14:22:28','2025-07-09 08:40:36','Léa','Bouteiller','','bouteiller.leam@gmail.com','+3395901212','','Female','France','participant',0,'2025-07-05 07:22:28+00:00','2025-07-09 08:40:36.377+00:00','2025-07-08 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('1bf41da7-f4b7-4d46-a8ac-f08435591632','2025-07-03 15:53:29','2025-07-09 08:41:05','Sofia','Paola','','sofiapaola5004@gmail.com','+34601292559','','Female','Spain','participant',0,'2025-07-03 08:53:29+00:00','2025-07-09 08:41:05.219+00:00','2025-07-06 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('2581a34d-17f8-4788-bb1d-91adc0acf4bd','2025-07-02 17:03:12','2025-07-03 14:53:45','Anand','Rajana','','anandrajana@papae.com','0','','Male','','participant',0,'2025-06-30','2025-07-03 14:53:45','2025-07-03','None',1,NULL,0,0);
INSERT INTO users VALUES('3081ffb7-39b4-46c7-86ec-088586ead2a9','2025-07-02 17:34:20','2025-07-05 15:53:11','Cole','Pillitu','','colepillitu@papae.com','0','','Female','United States','participant',0,'2025-07-01 00:00:00+00:00','2025-07-05 15:53:11.322+00:00','2025-07-05 00:00:00+00:00','Vegetarian',1,NULL,0,0);
INSERT INTO users VALUES('30c49bf1-2b32-489c-8112-0eea3562501d','2025-07-02 17:00:43','2025-07-03 14:53:11','Alexis','Vallejo','','alexis@papae.com','0','','Female','Mexico','participant',0,'2025-07-02','2025-07-03 14:53:10','2025-07-03','None',1,NULL,0,0);
INSERT INTO users VALUES('34b711a7-1574-49e3-8c13-194fe987f038','2025-07-02 20:45:50','2025-07-05 12:57:01','Pavic','Aurore','','aurore@papae.com','0','','Male','France','participant',0,'2025-06-27','2025-07-05 12:57:00','2025-07-05','None',1,NULL,0,0);
INSERT INTO users VALUES('354dbc16-1538-4f68-aef3-dd01959b9e42','2025-07-02 20:44:23','2025-07-05 12:57:06','Leonie','Böllertz','','bollertz@papae.com','0','','Female','Germany','participant',0,'2025-06-27','2025-07-05 12:57:05','2025-07-05','Vegetarian',1,NULL,0,0);
INSERT INTO users VALUES('404fa375-f11a-409d-81f5-dea50f49c8b7','2025-07-02 17:38:32','2025-07-16 09:36:47','Vitor','Lopes','','lopes@papae.com','21','','Male','Brazil','participant',0,'2025-07-16 09:36:10.107+00:00',NULL,'2025-07-17 17:00:00+00:00','Vegetarian',1,0,0,1);
INSERT INTO users VALUES('4b465b40-2cf2-4e73-a14d-34b1651e7a84','2025-07-02 17:16:56','2025-07-09 08:43:32','Ronja','Schalow','','ronjaschalow@papae.com','0','','Female','','participant',0,'2025-07-01 00:00:00+00:00','2025-07-09 08:43:32.396+00:00','2025-07-03 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('4c306ea3-5c0f-4f48-a225-d2fb10bb3f4d','2025-07-02 17:36:05','2025-07-09 08:43:39','Arrinpas','Peerachakanyakon','','peerachakanyakon@papae.com','0','','Female','Thailand','participant',0,'2025-07-01 00:00:00+00:00','2025-07-09 08:43:38.772+00:00','2025-07-06 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('54dc0cb2-bcff-4958-b066-dfd2ae4b2fab','2025-07-02 17:35:30','2025-07-05 15:53:36','Tess','Hollander','','tesshollander@papae.com','16','','Female','Germany','participant',0,'2025-07-02 00:00:00+00:00','2025-07-05 15:53:36.195+00:00','2025-07-05 00:00:00+00:00','Vegetarian',1,NULL,0,0);
INSERT INTO users VALUES('55d1f14c-f690-44e1-840a-4378220b5064','2025-07-02 17:31:47','2025-07-09 08:44:31','Melissa','Hauck','','melissahauck@papae.com','0','','Female','','participant',0,'2025-06-27 00:00:00+00:00','2025-07-09 08:44:31.451+00:00','2025-07-07 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('56466cb4-31af-4d59-83f2-17b39776e0e3','2025-07-02 17:41:15','2025-07-11 02:51:56','Violeta','Borrisser Vila','','borrisservila@papae.com','25','','Female','','volunteer',0,'2025-06-16 00:00:00+00:00',NULL,'2025-08-01 00:00:00+00:00','Vegetarian',8,24,3000,1);
INSERT INTO users VALUES('609f1c0e-1c59-4acc-b063-687aeda16e16','2025-07-02 17:14:21','2025-07-09 08:44:24','Hans','Alvim','','hansalvim@papae.com','0','','Male','','volunteer',0,'2025-06-30 00:00:00+00:00','2025-07-09 08:44:24.425+00:00','2025-07-12 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('652bbb9b-4875-4e26-9e24-4e11f2855b2a','2025-07-02 19:57:29','2025-07-05 12:57:09','Emma','Liu','','emmaliu@papae.com','0','','Female','','participant',0,'2025-06-27','2025-07-05 12:57:09','2025-07-05','Vegetarian',1,NULL,0,0);
INSERT INTO users VALUES('6857f7e5-7568-4327-ba5a-93ffd0a6269d','2025-07-03 15:21:48','2025-07-09 08:41:17','Lagutin','Noname','','lagutin@noemail.com','0','','Male','Russian Federation','participant',0,'2025-07-03 08:21:48+00:00','2025-07-09 08:41:17.155+00:00','2025-07-06 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('685b31a0-07bf-4370-885d-0a7d8de4bb71','2025-07-02 17:08:09','2025-07-09 08:43:47','Elsa','Menninghaus','','menninghaus@papae.com','0','','Female','','participant',0,'2025-07-01 00:00:00+00:00','2025-07-09 08:43:47.527+00:00','2025-07-03 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('70ecdd26-0432-41c8-b904-c55735838eeb','2025-07-02 17:45:49','2025-07-11 02:40:53','Robert','Choi','','robertchoi@papae.com','0','','Male','','participant',0,'2025-06-23 00:00:00+00:00','2025-07-11 02:40:52.472+00:00','2025-07-10 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('76e81368-654e-42ad-bf82-ea184ae5329d','2025-07-02 17:07:02','2025-07-05 12:16:58','Brad','Reed','','bradreed@papae.com','0','','Male','','volunteer',0,'2025-06-21','2025-07-05 12:16:56','2025-07-05','None',1,NULL,0,0);
INSERT INTO users VALUES('7770d5ee-3b81-4dc0-9bf2-4907d90d5fa8','2025-07-02 17:28:45','2025-07-09 08:41:47','Kathy','Clair','','kathy@papae.com','0','','Female','Philippines','participant',0,'2025-07-02 00:00:00+00:00','2025-07-09 08:41:47.732+00:00','2025-07-04 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('874c6253-ede3-4a5a-b8e9-03ee1742aac1','2025-07-02 19:59:41','2025-07-05 13:01:56','Joseph','Turner','','josephturner@papae.com','0','','Male','United Kingdom','participant',0,'2025-06-29','2025-07-05 13:01:55','2025-07-05','None',1,NULL,0,0);
INSERT INTO users VALUES('8e6190ea-dbb1-4264-830a-46cf0946c37a','2025-07-02 17:12:53','2025-07-09 08:43:54','Gabriele','Bruno','','gabrielebruno@papae.com','0','','Male','','participant',0,'2025-07-01 00:00:00+00:00','2025-07-09 08:43:54.141+00:00','2025-07-03 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('953437b2-c304-4276-856b-1112f6a52ce7','2025-07-02 17:38:05','2025-07-11 08:04:28','Lucas','McSweeney','','mcsweeney@papae.com','0','','Male','Australia','participant',0,'2025-07-02 00:00:00+00:00','2025-07-11 08:04:27.948+00:00','2025-07-10 00:00:00+00:00','None',1,0,5000,0);
INSERT INTO users VALUES('9a3d14fd-f422-43f0-95c6-873b927263ea','2025-07-02 20:47:47','2025-07-05 13:01:55','Romain','Connan','','connan@papae.com','0','','Male','France','participant',0,'2025-06-29','2025-07-05 13:01:54','2025-07-05','None',1,NULL,0,0);
INSERT INTO users VALUES('a65424c2-5510-443b-936e-904d31f32a8d','2025-07-05 15:09:53','2025-07-09 08:40:18','Domenico','Naswetter','','dnaswetter44@gmail.com','+420739562230','','Male','Czech Republic','participant',0,'2025-07-05 08:09:00+00:00','2025-07-09 08:40:18.174+00:00','2025-07-07 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('b1b85c31-22e9-4f3b-a667-67c2a917f51d','2025-07-05 15:18:33','2025-07-09 08:39:47','Vincent','Lu','','lugistics@gmail.com','0824153466','','Male','United States','participant',0,'2025-07-05 08:18:33+00:00','2025-07-09 08:39:47.02+00:00','2025-07-08 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('b3c6c116-431c-42e5-9155-165c6bd485c6','2025-07-02 20:43:09','2025-07-05 13:01:57','Lea','Fischbach','','fischbach@papae.com','0','','Female','Germany','participant',0,'2025-06-29','2025-07-05 13:01:57','2025-07-05','Vegetarian',1,NULL,0,0);
INSERT INTO users VALUES('b623e734-ba09-4ba7-bc94-54bfd2336fca','2025-07-02 17:23:17','2025-07-09 09:28:14','ปัญรัศม์','ชนม์ธนภัทรมน','','thai@papae.com','11','','Female','Thailand','participant',0,'2025-07-01 00:00:00+00:00','2025-07-09 09:28:14.192+00:00','2025-07-03 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('bccf1ac4-8967-437b-88f7-498795f87695','2025-07-05 15:25:43','2025-07-09 08:39:17','Steve','Pyo','','stepanopyo@gmail.com','6196487000','','Male','United States','participant',0,'2025-07-05 08:25:43+00:00','2025-07-09 08:39:17.499+00:00','2025-07-09 00:00:00+00:00','None',1,0,1,0);
INSERT INTO users VALUES('c3f08a6a-c5b0-4259-99bc-28c8dc21b08c','2025-07-02 17:37:02','2025-07-11 02:40:56','Celine','Schoemans','','celineschoemans@papae.com','0','','Female','Belgium','volunteer',0,'2025-06-27 00:00:00+00:00','2025-07-11 02:40:55.795+00:00','2025-07-11 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('d371f3da-f3fe-40ac-bff0-1fd439f5f782','2025-07-02 17:21:29','2025-07-09 08:44:16','Thanathon','Jansch','','jansch@papae.com','10','','Male','','participant',0,'2025-07-01 00:00:00+00:00','2025-07-09 08:44:15.996+00:00','2025-07-03 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('d4c2e638-26c2-440f-a73f-fa0dc90f2a2b','2025-07-02 17:34:56','2025-07-09 08:44:19','Kris','Huang','','krishuang@papae.com','0','','Female','Taiwan, Province of China','participant',0,'2025-07-01 00:00:00+00:00','2025-07-09 08:44:19.028+00:00','2025-07-08 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('d57f1fa0-fd8d-4d27-a5c2-6f4986b506c7','2025-07-02 16:40:06','2025-07-09 08:42:27','William','Davidson','','will19951@live.co.uk','07814112103','','Male','United Kingdom','participant',0,'2025-07-02 00:00:00+00:00','2025-07-09 08:42:26.896+00:00','2025-07-20 00:00:00+00:00','Vegetarian',1,0,0,0);
INSERT INTO users VALUES('dc3148b0-ae78-4d97-b40c-947e5d3f032c','2025-07-02 17:39:04','2025-07-11 02:41:53','Aziz','Mohammed','','mohammed@papae.com','0','','Male','Saudi Arabia','volunteer',0,'2025-06-16 00:00:00+00:00',NULL,'2025-08-10 00:00:00+00:00','None',18,78,1500,1);
INSERT INTO users VALUES('de02f1d6-ab52-4ffb-935b-1bf5491302d1','2025-07-02 17:37:34','2025-07-09 08:43:05','Kai','Tubinshlak','','tubinshlak@papae.com','0','','Male','Canada','participant',0,'2025-07-02 00:00:00+00:00','2025-07-09 08:43:05.727+00:00','2025-07-06 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('e5ad46e7-8e7b-408e-a70f-b21c7994139f','2025-07-05 16:45:29','2025-07-09 08:39:08','Hodaya','Zrihan','','hodayazrihan@gmail.com','+972526913586','','Female','Israel','participant',0,'2025-07-05 09:45:29+00:00','2025-07-09 08:39:08.503+00:00','2025-07-09 00:00:00+00:00','Vegetarian',1,0,1,0);
INSERT INTO users VALUES('e944bfdb-8627-4055-b60e-94927fe2e4a4','2025-07-03 15:23:08','2025-07-05 15:53:41','Arjan','Dwarshuis','','arjan@noemail.com','0','','Male','Netherlands','participant',0,'2025-07-03 08:23:08+00:00','2025-07-05 15:53:41.075+00:00','2025-07-05 00:00:00+00:00','Vegetarian',22,NULL,0,0);
INSERT INTO users VALUES('ed721751-c92a-4175-bc17-50fc6d1a1388','2025-07-03 15:58:16','2025-07-05 15:53:43','Leah','Morassut','','leah.morassut@gmail.com','2897957292','','Female','Canada','participant',0,'2025-07-03 08:58:16+00:00','2025-07-05 15:53:42.78+00:00','2025-07-05 00:00:00+00:00','None',1,NULL,0,0);
INSERT INTO users VALUES('f00927fc-e482-4e2d-a8fd-420612dc26b4','2025-07-02 17:43:47','2025-07-11 08:04:14','Enrique','Wintsch','','wintsch@papae.com','0','','Male','','participant',0,'2025-06-21 00:00:00+00:00','2025-07-11 08:04:14.358+00:00','2025-07-23 00:00:00+00:00','None',1,0,21000,0);
INSERT INTO users VALUES('f67a94eb-b1f9-4858-9e37-72b25df9b991','2025-07-02 17:15:24','2025-07-05 13:02:19','Linn','Win','','linnlinnwin@papae.com','0','','Female','','participant',0,'2025-06-29','2025-07-05 13:02:19','2025-07-05','Vegetarian',1,NULL,0,0);
INSERT INTO users VALUES('fc3b27f5-8ae8-499d-b69b-1bbf117195e2','2025-07-02 17:40:17','2025-07-16 06:30:19','Freddie','Lyon','','freddielyon@papae.com','0','','Male','United Kingdom','volunteer',0,'2025-06-16 00:00:00+00:00','2025-07-16 06:30:18.671+00:00','2025-08-01 00:00:00+00:00','None',1,0,3000,0);
INSERT INTO users VALUES('ff70e03f-d1d3-47ff-b85f-49125488756d','2025-07-02 17:46:16','2025-07-16 06:37:58','Anahi','Horeno','','horeno@papae.com','0','0','Female','Argentina','volunteer',0,'2025-02-14 00:00:00+00:00',NULL,'2025-07-31 00:00:00+00:00','Vegetarian',8,25,1500,1);
INSERT INTO users VALUES('a6e4a989-0e04-4557-9405-be9435659e17','2025-07-09 08:54:10','2025-07-11 08:01:42','Amelia','?','','amelia@amelia','0','','Female','Australia','participant',0,'2025-07-07 08:54:10+00:00','2025-07-11 08:01:41.89+00:00','2025-07-11 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('81dc4fd0-5d21-4357-8fe5-39d7d4c17585','2025-07-09 08:55:12','2025-07-11 08:23:28','Fiona','Guo','','fiona@guo','0','','Female','China','participant',0,'2025-07-09 08:58:45.134+00:00','2025-07-11 08:23:28.643+00:00','2025-07-11 00:00:00+00:00','Vegetarian',1,0,1000,0);
INSERT INTO users VALUES('c28e8023-5990-45df-8295-3e70715f8535','2025-07-09 08:56:22','2025-07-11 08:23:10','Likhita','Pasupula','','likhita@pasupula','0','','Female','United Kingdom','participant',0,'2025-07-08 08:56:22+00:00','2025-07-11 08:23:10.686+00:00','2025-07-11 00:00:00+00:00','Vegetarian',1,0,2000,0);
INSERT INTO users VALUES('221ee270-5c3d-4bfa-9c58-e8d8c7312c21','2025-07-09 08:57:07','2025-07-11 08:02:30','Orrapa','Sarochananjeen','','orrapa@sarochananjeen','0','','Female','Thailand','participant',0,'2025-07-08 08:57:07+00:00','2025-07-11 08:02:30.53+00:00','2025-07-11 00:00:00+00:00','None',1,0,1500,0);
INSERT INTO users VALUES('9caeb3ef-545f-4b3b-be71-1e4c7bfd959a','2025-07-09 08:57:38','2025-07-11 08:02:28','Natcha','Janwong','','natcha@Janwong','0','','Female','Thailand','participant',0,'2025-07-08 08:57:38+00:00','2025-07-11 08:02:28.357+00:00','2025-07-10 00:00:00+00:00','None',1,0,1000,0);
INSERT INTO users VALUES('c49dee4f-ac04-499b-9a6c-de798be71e17','2025-07-09 08:58:15','2025-07-11 08:23:23','Xiao','Yunlin','','xiao@yunlin','0','','Female','China','participant',0,'2025-07-09 08:58:15+00:00','2025-07-11 08:23:23.349+00:00','2025-07-11 00:00:00+00:00','Vegetarian',1,0,1000,0);
INSERT INTO users VALUES('8aaacb5a-b852-401d-a5e2-8df90d177a48','2025-07-09 08:59:44','2025-07-12 09:47:51','Wanwisa','Maneewatthana','','wanwisa@maneewatthana','0','','Female','Thailand','participant',0,'2025-07-09 08:59:44+00:00','2025-07-12 09:47:50.945+00:00','2025-07-12 00:00:00+00:00','None',1,0,1500,0);
INSERT INTO users VALUES('55fc377a-e847-4dcf-9c2c-55a89074bbed','2025-07-09 09:00:16','2025-07-14 03:14:22','Sun','Jia','','sun@jia','0','','Female','China','participant',0,'2025-07-09 09:00:16+00:00','2025-07-14 03:14:22.144+00:00','2025-07-12 00:00:00+00:00','None',1,0,1000,0);
INSERT INTO users VALUES('2df224b1-a92d-4957-9a86-e4a6c102f116','2025-07-09 09:00:47','2025-07-14 03:14:24','Caitlyn','Patton','','caitlyn@patton','0','','Female','United States','participant',0,'2025-07-09 09:00:47+00:00','2025-07-14 03:14:24.56+00:00','2025-07-14 00:00:00+00:00','None',1,0,1500,0);
INSERT INTO users VALUES('4fad55ca-4c15-4aa4-8b6a-d28660f7a2c6','2025-07-09 09:21:38','2025-07-11 08:22:53','Marcia','Estrada','','marcia@estrada','0','','Female','Peru','participant',0,'2025-07-06 09:21:38+00:00','2025-07-11 08:22:52.778+00:00','2025-07-11 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('cd03e9a1-1cf5-4819-8d5f-4c00677b2a25','2025-07-09 09:24:09','2025-07-11 08:24:23','Nadia','Abed','','nadia@abed','0','','Female','Netherlands','participant',0,'2025-07-09 09:24:09+00:00','2025-07-11 08:24:23.51+00:00','2025-07-11 00:00:00+00:00','None',1,0,1000,0);
INSERT INTO users VALUES('bb53465a-29d0-4e48-a136-bd84df1a342b','2025-07-09 09:25:54','2025-07-16 06:30:26','Patumkaeo','Stikham','','patumkaeo@stikham','0','','Female','Thailand','participant',0,'2025-07-09 09:25:54+00:00','2025-07-16 06:30:25.849+00:00','2025-07-15 00:00:00+00:00','Vegetarian',1,0,3500,0);
INSERT INTO users VALUES('468c0c44-baae-40d7-a596-4989050f3258','2025-07-09 11:26:53','2025-07-11 08:02:35','Saowalak','Hemsley','','saowalak@hemsley','0','','Male','Thailand','participant',0,'2025-07-08 11:26:53+00:00','2025-07-11 08:02:35.113+00:00','2025-07-16 00:00:00+00:00','None',1,0,4000,0);
INSERT INTO users VALUES('700f0b29-3e32-4b24-8e9b-6544834c4aa3','2025-07-09 11:36:26','2025-07-12 09:47:39','Crislaine','Medeiros','','crislaine@medeiros','0','','Female','Brazil','participant',0,'2025-07-09 11:36:26+00:00','2025-07-12 09:47:39.263+00:00','2025-07-12 00:00:00+00:00','None',1,0,500,0);
INSERT INTO users VALUES('2be7196f-e81a-4890-ab6a-6cda47c3e5c7','2025-07-11 08:03:30','2025-07-11 08:03:50','William','Davidson','','william1234@gmail.com','0987493381','','Male','United Kingdom','volunteer',0,'2025-07-11 08:03:30+00:00',NULL,'2025-08-01 00:00:00+00:00','None',20,82,3000,1);
INSERT INTO users VALUES('f221541c-a22d-45c8-abd8-39e4d33d6663','2025-07-11 08:11:08','2025-07-16 06:37:27','Dariane','Frizo','','darifrizo@gmail.com','35984175963','','Female','Brazil','volunteer',0,'2025-07-11 08:11:08+00:00',NULL,'2025-08-30 17:00:00+00:00','None',9,34,2500,1);
INSERT INTO users VALUES('b6d9554c-8f95-4382-af32-1f4b6c34a77a','2025-07-11 08:35:42','2025-07-16 06:40:20','Vitor ','Lopes','','krchxo10@gmail.com','0987493381','','Male','Brazil','participant',0,'2025-07-14 03:13:35.646+00:00','2025-07-16 06:40:19.083+00:00','2025-07-17 00:00:00+00:00','None',1,0,9000,0);
INSERT INTO users VALUES('0b8bbeb1-8339-4a2e-b3a5-4112a47b4734','2025-07-11 09:15:40','2025-07-14 03:14:38','Qingyun','Sun','','kikosun98@outlook.com','0949090730','','Female','China','participant',0,'2025-07-11 09:15:40+00:00','2025-07-14 03:14:37.802+00:00','2025-07-14 00:00:00+00:00','None',1,0,1500,0);
INSERT INTO users VALUES('15f1a0bf-e712-4422-9127-11ac5e389dba','2025-07-11 09:16:02','2025-07-14 03:14:33','Ethan ','Wong','','zhoushengsheng6688@gmail.com','+66619907453','','Male','China','participant',0,'2025-07-11 09:16:02+00:00','2025-07-14 03:14:33.478+00:00','2025-07-14 00:00:00+00:00','None',1,0,1500,0);
INSERT INTO users VALUES('e3e3af96-54a0-4c3c-ad62-9b17f59ffd44','2025-07-11 10:03:47','2025-07-16 06:36:12','Chen','Yanfang','','794520574@qq.com','+86 18679185251','','Female','China','participant',0,'2025-07-11 10:03:47+00:00','2025-07-16 06:36:12.222+00:00','2025-07-14 00:00:00+00:00','None',1,0,1500,0);
INSERT INTO users VALUES('ea39c74d-5e36-495a-b847-a74cb8fafa3e','2025-07-11 10:06:00','2025-07-16 06:36:00','sasha','.','','2297977653@QQ.COM','+86 13247911510','','Female','China','participant',0,'2025-07-11 10:06:00.824+00:00','2025-07-16 06:35:59.776+00:00','2025-07-14 00:00:00+00:00','None',1,0,1500,0);
INSERT INTO users VALUES('7fa2a457-30dd-4680-90e7-bab22b00d8f9','2025-07-11 10:18:54','2025-07-16 06:36:41','Joanna','Leusin','','joannaleusin@gmail.com','+66990736929','','Female','Brazil','participant',0,'2025-07-11 10:18:54+00:00','2025-07-16 06:36:39.598+00:00','2025-07-14 00:00:00+00:00','Vegetarian',1,0,1400,0);
INSERT INTO users VALUES('9165029d-82ca-4f54-b2f4-f599d4cae305','2025-07-12 08:03:08','2025-07-16 06:31:27','Arjuna','Welsh','','awels9@outlook.com.ai','+610432347644','','Male','Australia','participant',0,'2025-07-12 08:03:08+00:00','2025-07-16 06:31:26.385+00:00','2025-07-14 17:00:00+00:00','None',1,0,2000,0);
INSERT INTO users VALUES('a0dc1ba1-f1f1-4257-96ce-981a9e70bc75','2025-07-13 10:31:03','2025-07-14 03:08:35','Lauren','Tyerman','','Lauren.tyerman1@gmail.com','+63423968690 (whattsapp)','','Female','United Kingdom','participant',0,'2025-07-13 10:31:04.028+00:00',NULL,'2025-07-16 00:00:00+00:00','None',9,31,1500,1);
INSERT INTO users VALUES('c077c172-c248-445f-9c92-8183018f01c1','2025-07-13 10:57:03','2025-07-16 06:30:08','Nataphob','Hokthong','','ggg@ghh','0610209192','','Male','Thailand','participant',0,'2025-07-13 10:57:03+00:00','2025-07-16 06:30:08.097+00:00','2025-07-15 00:00:00+00:00','None',1,0,0,0);
INSERT INTO users VALUES('7d989d85-20c9-4d96-944a-eb736566f129','2025-07-14 07:29:31','2025-07-16 06:35:33','Danylo ','Yatsula','','daniel.andreev1408@gmail.com','0842573022','','Male','Ukraine','participant',0,'2025-07-14 07:29:32.397+00:00',NULL,'2025-07-17 17:00:00+00:00','None',15,68,1500,1);
INSERT INTO users VALUES('a2b28050-8ded-4be2-a89f-80741d9f2ce0','2025-07-14 10:25:58','2025-07-16 06:35:36','Oren','Agmon','','oren.agmon98@gmail.com','+972535231707','','Male','Israel','participant',0,'2025-07-14 10:25:59.018+00:00',NULL,'2025-07-17 17:00:00+00:00','None',15,67,1500,1);
INSERT INTO users VALUES('8a6104e7-5113-4c68-b7fb-c276fed9bc16','2025-07-15 06:57:12','2025-07-16 06:33:50','Parul','Gupta','','parulguptad08@gmail.com','9886102849','','Female','India','participant',0,'2025-07-15 06:57:12+00:00',NULL,'2025-07-20 00:00:00+00:00','Vegetarian',11,46,2500,1);
INSERT INTO users VALUES('ecc7c24d-f88d-4acb-96e1-197c5afc1eb0','2025-07-15 10:41:00','2025-07-16 06:33:48','Yaniv','Rozenblat ','','spike77707@gmail.com','0631162016','','Male','Israel','participant',0,'2025-07-15 10:41:00+00:00',NULL,'2025-07-22 00:00:00+00:00','Vegetarian',15,73,3500,1);
INSERT INTO users VALUES('0c75169e-b24b-45f9-b6c0-2218a57095fd','2025-07-16 05:53:09','2025-07-16 06:33:32','Qifan','Xiong','','1106107234@qq.com','+86 189 2699 5823','','Male','China','participant',1,'2025-07-16 05:53:09+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',20,81,2000,1);
INSERT INTO users VALUES('fe6aa008-281c-49eb-94ce-b3cb14ee02d3','2025-07-16 06:52:47','2025-07-16 07:20:21','michael','huber','','huber054@hotmail.com','6174589315','','Male','United States','participant',1,'2025-07-16 06:52:47+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',17,76,1500,1);
INSERT INTO users VALUES('0a2c2a80-e37a-4e6b-92f0-3b166b1f66c8','2025-07-16 06:53:07','2025-07-16 07:20:27','Georgia','Fendick','','georgiafendick@gmail.com','+447856544877','','Female','United Kingdom','participant',1,'2025-07-16 06:53:07+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',9,27,1500,1);
INSERT INTO users VALUES('f41144fb-c637-41e6-8e7f-c7666f51eaec','2025-07-16 06:54:57','2025-07-16 07:20:29','Maeva','Burbaud','','maeva.burbaudd@gmail.com','+33765281358','','Female','France','participant',1,'2025-07-16 06:54:57+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,29,1500,1);
INSERT INTO users VALUES('35f4c972-437d-4035-9143-10e7cac38960','2025-07-16 06:55:28','2025-07-16 07:20:32','Nicholas','Askew','','nickaskew15@gmail.com','61411025370','','Male','Australia','participant',1,'2025-07-16 06:55:28+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',17,77,1500,1);
INSERT INTO users VALUES('e34dce18-f6ba-42d4-83d1-641023d02584','2025-07-16 06:56:09','2025-07-16 07:20:35','Tess ','Duivenvoorden ','','Tess186@hotmail.com','+31 6 40239190','','Female','Netherlands','participant',1,'2025-07-16 06:56:11.412+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,28,1500,1);
INSERT INTO users VALUES('cb66a28b-e49e-48b3-98d5-76221d2fbccf','2025-07-16 06:56:23','2025-07-16 07:20:38','NAIR','CHARLES ','','charleson6@yahoo.com','+6591255143','','Male','Singapore','participant',1,'2025-07-16 06:56:25.899+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',17,77,1500,1);
INSERT INTO users VALUES('971199d9-97e6-4373-ba09-72ebfdb46725','2025-07-16 06:57:19','2025-07-16 07:20:41','Sheila','Lim','','sheila_lim13@yahoo.com.sg','+6596155419','','Female','Singapore','participant',1,'2025-07-16 06:57:19+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,30,1500,1);
INSERT INTO users VALUES('3cbd9933-f11a-4dd2-bb3b-664706fedb86','2025-07-16 06:59:38','2025-07-16 07:20:45','Hendrik','Staack','','hendrikstaack97@gmail.com','+4915788100322','','Male','Germany','participant',1,'2025-07-16 06:59:38+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',17,76,1500,1);
INSERT INTO users VALUES('b55e9c40-8963-45d3-869a-f4b492750f50','2025-07-16 07:06:26','2025-07-16 07:40:04','Indji','Tan','','indji.tan@gmail.com','+31625366230','','Male','Netherlands','participant',1,'2025-07-16 07:06:26+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',20,82,5001,1);
INSERT INTO users VALUES('7128edb7-8a04-46e0-851b-40cb55c3aeb6','2025-07-16 07:06:55','2025-07-16 07:40:01','Quinte','Martens','','quintemartens@gmail.com','0031634541366','','Female','Netherlands','participant',1,'2025-07-16 07:06:55+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,32,1500,1);
INSERT INTO users VALUES('6563d18e-7add-4fb9-b10c-45913293216f','2025-07-16 07:17:35','2025-07-16 07:39:40','Jose','Asián ','','asian.jose@gmail.com','+34627473016','','Male','Spain','participant',1,'2025-07-16 07:17:35+00:00',NULL,'2025-07-22 00:00:00+00:00','Meat',20,83,3000,1);
INSERT INTO users VALUES('be32eae2-580d-4228-9303-66417372b358','2025-07-16 07:19:19','2025-07-16 07:39:59','Techeng','Hou','','eric1314@gmail.com','+886932977335','','Male','Taiwan, Province of China','participant',0,'2025-07-16 07:19:19+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',24,97,1500,1);
INSERT INTO users VALUES('866bebe2-9860-4f7a-9fe6-1b4bdc44e30a','2025-07-16 07:20:38','2025-07-16 07:39:55','yingying','peng','','961116878@qq.com','8618664540859','','Female','China','participant',1,'2025-07-16 07:20:39.457+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,33,1500,1);
INSERT INTO users VALUES('5783a064-24ad-480e-8041-f2235fb037a5','2025-07-16 07:21:49','2025-07-16 07:39:36','satheesan ','Pacha','','sathesan@hotmail.com','+61402111971','','Male','Australia','participant',0,'2025-07-16 07:21:49+00:00',NULL,'2025-07-21 00:00:00+00:00','Vegetarian',20,84,2500,1);
INSERT INTO users VALUES('6d87aa56-1874-4243-9258-8b0cc4aecbcb','2025-07-16 07:31:06','2025-07-16 07:41:59','Maya','Assor','','maya7367@gmail.com','+972506992172','','Female','Israel','participant',1,'2025-07-16 07:31:06.881+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,35,1500,1);
INSERT INTO users VALUES('7694c328-b490-4949-9cda-84ffe9a5c095','2025-07-16 07:41:54','2025-07-16 07:50:38','Maayan ','Nestel','','maayan.nestel.bs@gmail.com','+972526096005','','Female','Israel','participant',1,'2025-07-16 07:41:54+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',9,36,1500,1);
INSERT INTO users VALUES('1821a716-617b-47c9-94eb-214b760305aa','2025-07-16 07:47:58','2025-07-16 08:34:03','Naphatsorn','Phumiphamon','','bamvy0909@gmail.com','0836961541','','Female','Thailand','participant',1,'2025-07-16 07:48:38.064+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,37,1500,1);
INSERT INTO users VALUES('7349241a-0639-4ccf-8de2-39792c62d082','2025-07-16 07:50:55','2025-07-16 08:33:56','Stella','Kowalsky','','kowalsky.stella@gmail.com','15252722706','','Female','Germany','participant',1,'2025-07-16 07:50:55+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',9,34,1500,1);
INSERT INTO users VALUES('ed2878c0-ab0b-4188-ad86-58a67533b7df','2025-07-16 08:00:50','2025-07-16 08:33:54','Boonyaporn ','Sompornpailin','','bypspl46@gmail.com','0885299099','','Female','Thailand','participant',0,'2025-07-16 08:00:50+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,40,1500,1);
INSERT INTO users VALUES('1e6162c0-dc58-468d-b5c9-b916a8179598','2025-07-16 08:03:01','2025-07-16 08:33:51','Kewalin','Teichatrairat','','kewalin.teichatrairat@gmail.com','0962428966','','Female','Thailand','participant',1,'2025-07-16 08:03:01+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,40,1500,1);
INSERT INTO users VALUES('ec6dc587-1fb1-4985-aa36-2563d8ddf34b','2025-07-16 08:07:59','2025-07-16 08:33:48','Maryane','Francisco Marques','','maryane742010@gmail.com','07 59 68 94 12','','Female','France','participant',1,'2025-07-16 08:07:59+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',10,44,1500,1);
INSERT INTO users VALUES('59c5be30-da61-4319-bdaa-f52fd4e9c617','2025-07-16 08:08:00','2025-07-16 08:33:46','Aisling','Casserly','','aislingcass@gmail.com','+353 873313243','','Female','Ireland','participant',1,'2025-07-16 08:08:00+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,41,1500,1);
INSERT INTO users VALUES('edd1f5b7-6029-40fd-9e6f-a1e3852e8544','2025-07-16 08:08:48','2025-07-16 08:31:50','Sarah','Fleming','','sarahfleming2017@gmail.com','0963384577','','Female','Ireland','participant',1,'2025-07-16 08:08:48+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,41,1500,1);
INSERT INTO users VALUES('d293ff54-abe3-4c0c-b2cd-63e23bf9b7a0','2025-07-16 08:09:43','2025-07-16 08:31:46','Hadidja','Said Bacar','','hadidja6@icloud.com','+1 514 607 5012','','Female','France','participant',1,'2025-07-16 08:09:43+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',10,43,1500,1);
INSERT INTO users VALUES('2aac4cc4-23bc-4639-bf2c-97fbc473ac1e','2025-07-16 08:09:49','2025-07-16 08:31:41','Laura','Haddad','','haddad.laura28@gmail.com','+15147462807','','Female','France','participant',1,'2025-07-16 08:09:49+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',10,42,1500,1);
INSERT INTO users VALUES('c51e5a27-b7bb-45af-86a0-8c8273307fd7','2025-07-16 08:09:51','2025-07-16 08:31:36','Tomas','Ferraton','','tomferraton@gmail.com','+18193511281','','Male','Canada','participant',1,'2025-07-16 08:09:51+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',24,97,1500,1);
INSERT INTO users VALUES('90df7edb-6190-487a-b2af-c2d29859a026','2025-07-16 08:21:53','2025-07-16 09:31:06','TZUYU','CHEN','','boris90422@gmail.com','0975672810','','Female','Taiwan, Province of China','participant',1,'2025-07-16 08:21:53+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',7,21,1500,1);
INSERT INTO users VALUES('69664496-ea14-4348-88b7-ace901c92272','2025-07-16 08:23:01','2025-07-16 09:31:02','Julia','Barclay','','julia.barclay12@gmail.com','+660611213143','','Female','United States','participant',1,'2025-07-16 08:23:01+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',7,21,1500,1);
INSERT INTO users VALUES('c30897a7-e0c0-4dae-9194-6971d6b63941','2025-07-16 08:35:19','2025-07-16 09:30:56','Flor','Batista','','florbatista28@gmail.com','+17274608889','','Female','United States','participant',1,'2025-07-16 08:35:19+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',7,20,1500,1);
INSERT INTO users VALUES('6326c84e-1ebd-4b8b-935c-34539f099bae','2025-07-16 08:35:26','2025-07-16 09:31:00','Carolina','Valdez','','macielbatista2011@hotmail.com','8293317364','','Female','Dominican Republic','participant',1,'2025-07-16 08:35:26+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',7,20,1500,1);
INSERT INTO users VALUES('aff4da7d-da6f-4aee-a720-4919e709e36b','2025-07-16 09:11:03','2025-07-16 09:34:19','Reuben','Thornden','','rgthornden@gmail.com','07491651264','','Male','United Kingdom','participant',1,'2025-07-16 09:11:04.287+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',15,67,1500,1);
INSERT INTO users VALUES('7289cb9a-4f75-4d17-8a79-2ec221602804','2025-07-16 09:22:20','2025-07-16 09:34:21','Sophia','Rizzuti','','sophiarizzuti@berkeley.edu','+14152997265','','Female','United States','participant',1,'2025-07-16 09:22:20.907+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,39,1500,1);
INSERT INTO users VALUES('7ab1d312-9461-4e12-b7e8-8181e276289f','2025-07-16 09:23:47','2025-07-16 09:35:45','Rachel','Casey','','rachelcaseyxox@gmail.com','+66824920036','','Female','Ireland','participant',1,'2025-07-16 09:23:47.897+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',9,39,1500,1);
INSERT INTO users VALUES('34e9aa0d-a7dc-42fd-8812-a606c3bd2bf4','2025-07-16 09:37:47','2025-07-16 10:14:09','Vinod','Kumar','','vinodkatarya@gmail.com','+971522101056','','Male','Pakistan','participant',0,'2025-07-16 09:37:47+00:00',NULL,'2025-07-17 00:00:00+00:00','Vegetarian',15,69,500,1);
INSERT INTO users VALUES('55f1ce76-9fbf-4a43-a041-8a51dc347b38','2025-07-16 09:39:47','2025-07-16 10:14:07','Reena','Reena','','reenakarrera@gmail.com','+923367888998','','Female','Pakistan','participant',0,'2025-07-16 09:39:47+00:00',NULL,'2025-07-17 00:00:00+00:00','Vegetarian',11,47,500,1);
INSERT INTO users VALUES('b88688e0-2fb8-45e9-a558-6328e7b107e0','2025-07-16 09:49:41','2025-07-16 10:14:05','Portia','Baratta','','portia.baratta@gmail.com','13033744774','','Female','United States','participant',1,'2025-07-16 09:49:41+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',7,22,1500,1);
INSERT INTO users VALUES('a88cdd5e-5f39-4b90-9654-0227df2f8cce','2025-07-16 09:50:55','2025-07-16 10:14:03','Rhiannan','Francis','','rhiannanfrancis1@gmail.com','+447376099469','','Female','United Kingdom','participant',1,'2025-07-16 09:50:55.968+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',11,47,1500,1);
INSERT INTO users VALUES('3b235a63-2a4d-44ba-90d7-8b6db760bad8','2025-07-16 09:51:11','2025-07-16 10:13:58','Jolente ','De Meyst','','jolentedemeyst1@gmail.com','0498117296','','Female','Belgium','participant',1,'2025-07-16 09:51:11+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',7,22,1500,1);
INSERT INTO users VALUES('cc376db3-9dac-416e-95ad-f062d27ee579','2025-07-16 09:51:45','2025-07-16 10:13:54','Jade ','Eijckmans','','jade.eijckmans@hotmail.com','0493047975','','Female','Belgium','participant',1,'2025-07-16 09:51:45+00:00',NULL,'2025-07-19 00:00:00+00:00','Vegetarian',7,22,1500,1);
INSERT INTO users VALUES('37bc17c4-506b-4867-9372-f79299ea8ea4','2025-07-16 10:12:55','2025-07-16 10:14:35','Riccardo','Rosato','','ricros94@gmail.com','392 858 3905','','Male','Italy','participant',1,'2025-07-16 10:12:55+00:00',NULL,'2025-07-19 00:00:00+00:00','Meat',15,70,0,1);
INSERT INTO users VALUES('46c93969-fd7e-4505-a60e-b52c1d245dff','2025-07-16 10:13:17','2025-07-16 10:14:29','Andrew','Duff','','andrew.duff88@yahoo.co.uk','+647922556771','','Male','United Kingdom','participant',1,'2025-07-16 10:13:17+00:00',NULL,'2025-07-21 00:00:00+00:00','Meat',15,69,0,1);
CREATE TABLE IF NOT EXISTS retreats (
  id INTEGER PRIMARY KEY,
  retreat_code TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT (datetime ('now')),
  updated_at TIMESTAMP NOT NULL DEFAULT (datetime ('now')),
  type TEXT NOT NULL CHECK (type IN ('fixed', 'flexible')),
  start_date DATETIME,
  end_date DATETIME
);
INSERT INTO retreats VALUES(0,'flexible','2025-07-08 06:52:28','2025-07-08 06:52:28','flexible',NULL,NULL);
INSERT INTO retreats VALUES(1,'fix-16-July','2025-07-08 11:01:14','2025-07-08 11:01:14','fixed','2025-07-16 00:00:00+00:00','2025-07-19 00:00:00+00:00');
INSERT INTO retreats VALUES(2,'fix-26-July','2025-07-09 12:22:46','2025-07-09 12:22:46','fixed','2025-07-26 00:00:00+00:00','2025-07-29 00:00:00+00:00');
INSERT INTO retreats VALUES(3,'fix-5-August','2025-07-11 03:14:33','2025-07-11 03:14:33','fixed','2025-08-05 00:00:00+00:00','2025-08-08 00:00:00+00:00');
INSERT INTO retreats VALUES(4,'fix-15-August','2025-07-11 03:14:46','2025-07-11 03:14:46','fixed','2025-08-15 00:00:00+00:00','2025-08-18 00:00:00+00:00');
INSERT INTO retreats VALUES(5,'fix-25-August','2025-07-11 03:14:52','2025-07-11 03:14:52','fixed','2025-08-25 00:00:00+00:00','2025-08-28 00:00:00+00:00');
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
INSERT INTO refresh_tokens VALUES('642bd4e542df071a8a41dc0e7b8cce01f2cb87a1abd9583933f18747bfd84c14','2025-07-08 09:27:59','2025-07-08 09:27:59',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 16:27:59.635055 +0700 +07 m=+2592016.038866918');
INSERT INTO refresh_tokens VALUES('a6ad785c149f42604e24e6c6b5a0740cd2a5a899a3780a22301cbb4d00f54729','2025-07-08 11:00:00','2025-07-08 11:00:00',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 11:00:00.224457349 +0000 UTC m=+2592024.697219026');
INSERT INTO refresh_tokens VALUES('387aa3a0fc8b973f05e720099b7e210a04b8ca43d57c1419116b248a1dbc03c6','2025-07-08 11:03:02','2025-07-08 11:03:02',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 11:03:01.975732794 +0000 UTC m=+2592206.448494471');
INSERT INTO refresh_tokens VALUES('639dc55495e59224e8f30494c964e30405e80542407e79ecd9aa68be16a0c566','2025-07-08 11:04:42','2025-07-08 11:04:42',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 11:04:42.221208153 +0000 UTC m=+2592306.693969830');
INSERT INTO refresh_tokens VALUES('f38ee1f0046e79d18327128db3f41f5998ffd9e2f3b28add8ba025e8b5149cf2','2025-07-08 11:05:36','2025-07-08 11:05:36',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 11:05:36.941569431 +0000 UTC m=+2592361.414331108');
INSERT INTO refresh_tokens VALUES('ad896961e1e517f1c7c423defa573254bab3c34dad5734591e169d5da1907dfc','2025-07-08 11:07:34','2025-07-08 11:07:34',NULL,'00000000-0000-0000-0000-000000000001','2025-08-07 11:07:34.582071246 +0000 UTC m=+2592479.054832923');
INSERT INTO refresh_tokens VALUES('6a54f0141a590638c9616eac5167acd473850c3e25f3f59f94e1f2033b759b33','2025-07-08 11:29:24','2025-07-08 11:29:24',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 11:29:24.335842743 +0000 UTC m=+2593788.808604420');
INSERT INTO refresh_tokens VALUES('5e97fc0dcb26380a117c16002e21a0384c7da916c4765ec9b3fcebb82779e767','2025-07-08 11:29:50','2025-07-08 11:29:50',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 11:29:50.891437127 +0000 UTC m=+2593815.364198804');
INSERT INTO refresh_tokens VALUES('c8641a199a32ba43970b6670c33d16df98d04f22a12590b4c4c8503eea9efaaf','2025-07-08 11:30:10','2025-07-08 11:30:10',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 11:30:10.371832036 +0000 UTC m=+2593834.844593713');
INSERT INTO refresh_tokens VALUES('3f0d9eadf7255bac50782d1747476ae0d0fca0d210bf480d5941adeac278c059','2025-07-08 11:30:46','2025-07-08 11:30:46',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 11:30:46.728473193 +0000 UTC m=+2593871.201234870');
INSERT INTO refresh_tokens VALUES('e4626095564fcd391bade10a065dccb2d287d35537bc3fbf41738491b4441ed0','2025-07-08 13:14:29','2025-07-08 13:14:29',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 13:14:29.475308203 +0000 UTC m=+2596451.528633978');
INSERT INTO refresh_tokens VALUES('764985085e912d30f3a082d2e8a202a0890de960bfa95fb307813759fd0463f8','2025-07-08 14:17:20','2025-07-08 14:17:20',NULL,'00000000-0000-0000-0000-000000000000','2025-08-07 14:17:20.832438571 +0000 UTC m=+2600222.885764346');
INSERT INTO refresh_tokens VALUES('3d07632211794139de8af5a476d4b1237e8d75d908bfc73beecba9cb0635935d','2025-07-09 02:03:22','2025-07-09 02:03:22',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 02:03:21.988316422 +0000 UTC m=+2642584.041642197');
INSERT INTO refresh_tokens VALUES('6bc6e648121faa3690768ec82b25d6e02f77dd974be70fde9a2f4a2028aa4569','2025-07-09 07:04:06','2025-07-09 07:04:06',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 07:04:06.965991106 +0000 UTC m=+2592251.703502000');
INSERT INTO refresh_tokens VALUES('5fd4e111d1d1aee483aa037133eb8e8d28fe38f7655548061cea048027b4e33d','2025-07-09 07:24:50','2025-07-09 07:24:50',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 07:24:50.153216434 +0000 UTC m=+2593494.890727318');
INSERT INTO refresh_tokens VALUES('643bdf6e858c61e912db0359d96efc03175c31d2ff709ec43e13b1a7fa8ed2cc','2025-07-09 09:13:17','2025-07-09 09:13:17',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 09:13:17.319580917 +0000 UTC m=+2600002.057091811');
INSERT INTO refresh_tokens VALUES('e0547765238bae220fcd3d9f3fd6023c318e00d00b01fa4e2b68f0b81187d54f','2025-07-09 09:51:39','2025-07-09 09:51:39',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 09:51:39.049613535 +0000 UTC m=+2602303.787124419');
INSERT INTO refresh_tokens VALUES('9cbf26523aaa85f6238c56272281411c8e76ecaa3396632060a56d07349fa463','2025-07-09 11:10:18','2025-07-09 11:10:18',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 11:10:18.856186841 +0000 UTC m=+2595871.176529137');
INSERT INTO refresh_tokens VALUES('da908dca4e42e9ac9223fb421cfe68d559893307122802fb63dee44dc1eacc20','2025-07-09 11:22:46','2025-07-09 11:22:46',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 11:22:46.048515019 +0000 UTC m=+2596618.368857314');
INSERT INTO refresh_tokens VALUES('433f573e2eabb92d25abfe5026d52e73377cf6e3c35e647a9a166273c49e8646','2025-07-09 11:48:47','2025-07-09 11:48:47',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 11:48:47.206309159 +0000 UTC m=+2598179.526651454');
INSERT INTO refresh_tokens VALUES('e3499e43c355c3f7bfde61e187acb68ffdbbc7356d0eef7a8ce7621e2fb71371','2025-07-09 11:55:32','2025-07-09 11:55:32',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 11:55:32.874910443 +0000 UTC m=+2598585.195252748');
INSERT INTO refresh_tokens VALUES('1fcd24a259ea8979a0d55f2191f637a8f56920b05eb9a48c61ed6dd932109622','2025-07-09 12:37:35','2025-07-09 12:37:35',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 12:37:35.032201372 +0000 UTC m=+2601107.352543668');
INSERT INTO refresh_tokens VALUES('8bcf852d987307126b890db7ee979a20ed7d62bea590b7191fa74429dd3083db','2025-07-09 13:40:06','2025-07-09 13:40:06',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 13:40:05.989844465 +0000 UTC m=+2604858.310186770');
INSERT INTO refresh_tokens VALUES('b79a58b3d5f7ad1dd5952c1029e19ae960b2c8928bb840e076fd449575d2427b','2025-07-09 14:42:18','2025-07-09 14:42:18',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 14:42:18.245966973 +0000 UTC m=+2608590.566309268');
INSERT INTO refresh_tokens VALUES('1114e6db7ee5a0df843f681b52cb30a80a3c61bd5bec48a81a55848dfafadfdf','2025-07-09 17:43:07','2025-07-09 17:43:07',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 17:43:07.717339922 +0000 UTC m=+2619440.037682218');
INSERT INTO refresh_tokens VALUES('f652ca44533d4d97f24971f47bf076c708363f2c8444c5a7c0e2e61512d3dfad','2025-07-09 17:44:23','2025-07-09 17:44:23',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 17:44:23.660127134 +0000 UTC m=+2619515.980469429');
INSERT INTO refresh_tokens VALUES('270372be810ef645f153c4d53aef1ebed485e4f792f466167901f6469daaf843','2025-07-09 17:59:30','2025-07-09 17:59:30',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 17:59:30.430135578 +0000 UTC m=+2620422.750477873');
INSERT INTO refresh_tokens VALUES('29df9ef9ecbc24002ab0814ced0d1dc77fb6cd09eafd181aa2e3823f80196011','2025-07-09 17:59:33','2025-07-09 17:59:33',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 17:59:33.719814715 +0000 UTC m=+2620426.040157010');
INSERT INTO refresh_tokens VALUES('7d95f338465b17d498e8de009acecda7648934640b83076e631f96c3fa803413','2025-07-09 18:03:49','2025-07-09 18:03:49',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 18:03:49.90365745 +0000 UTC m=+2592047.308602468');
INSERT INTO refresh_tokens VALUES('6f2bfb9ea66d04433bcd8bce7f2cf61ec4c3122c7f0a01c782c4cf5583655501','2025-07-09 18:06:36','2025-07-09 18:06:36',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 18:06:36.200502544 +0000 UTC m=+2592213.605447562');
INSERT INTO refresh_tokens VALUES('d51a4692740fc66099926a952660ad8f42684353ea692eff89c2372a71088444','2025-07-09 23:22:08','2025-07-09 23:22:08',NULL,'00000000-0000-0000-0000-000000000000','2025-08-08 23:22:08.382297859 +0000 UTC m=+2610713.096253206');
INSERT INTO refresh_tokens VALUES('43673e032e10c96b00b267a1542c71e3e854d86f62ef05fec8112b6872ce9ee3','2025-07-10 01:12:59','2025-07-10 01:12:59',NULL,'00000000-0000-0000-0000-000000000000','2025-08-09 01:12:59.52311588 +0000 UTC m=+2617364.237071227');
INSERT INTO refresh_tokens VALUES('e1eb6ce705bb1d0ada2dcfa667791de8849a0415dce12c357dc59b6aa052a6dd','2025-07-10 07:20:17','2025-07-10 07:20:17',NULL,'00000000-0000-0000-0000-000000000001','2025-08-09 07:20:17.963294668 +0000 UTC m=+2639402.677250015');
INSERT INTO refresh_tokens VALUES('0c6f181975794dea51c19185e481660dbc27913f3d53ba50913bdc1a2008858c','2025-07-10 07:20:21','2025-07-10 07:20:21',NULL,'00000000-0000-0000-0000-000000000001','2025-08-09 07:20:21.42859551 +0000 UTC m=+2639406.142550857');
INSERT INTO refresh_tokens VALUES('df1d938886148ab0d5fd3ff5ed63bbb5d66e883e89129ba0e9337d87565ff731','2025-07-10 13:38:42','2025-07-10 13:38:42',NULL,'00000000-0000-0000-0000-000000000000','2025-08-09 13:38:42.75093414 +0000 UTC m=+2601137.937579518');
INSERT INTO refresh_tokens VALUES('345d90291b5c02d305bbe22ed3d977817b69c22f6398eaae63aa9dc0f1fd564a','2025-07-11 01:46:21','2025-07-11 01:46:21',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 01:46:21.291998038 +0000 UTC m=+2624434.684152181');
INSERT INTO refresh_tokens VALUES('6f64389bfb1900299a47fcd8b9903465ed6e72a1123d16de8a1399c840e4683a','2025-07-11 02:24:29','2025-07-11 02:24:29',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 02:24:29.714469948 +0000 UTC m=+2626723.106624091');
INSERT INTO refresh_tokens VALUES('5faee28011e56059387d3549c7a7438d78f9edeb398e3cc05a2c7a758285510d','2025-07-11 02:24:30','2025-07-11 02:24:30',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 02:24:30.91937729 +0000 UTC m=+2626724.311531443');
INSERT INTO refresh_tokens VALUES('9414cae2a21748b7fd09c9947ddbc5871cb31883980020d5ca7855787daad69a','2025-07-11 02:24:57','2025-07-11 02:24:57',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 02:24:57.721307001 +0000 UTC m=+2626751.113461144');
INSERT INTO refresh_tokens VALUES('4039cc169aea4df3b7a10da5ae4db847e81392fdb90c5db037007de013ac1fbb','2025-07-11 02:25:20','2025-07-11 02:25:20',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 02:25:20.296499758 +0000 UTC m=+2626773.688653901');
INSERT INTO refresh_tokens VALUES('14ce4b97637ca6cad38c51b9c1a167b514dfc64af41eb0367a474c0233c40294','2025-07-11 02:38:51','2025-07-11 02:38:51',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 02:38:51.585069059 +0000 UTC m=+2627584.977223202');
INSERT INTO refresh_tokens VALUES('bb58e4782add0cb52a200082b83cfde4bc64d08b241c731196fe4b9843120fc6','2025-07-11 02:38:54','2025-07-11 02:38:54',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 02:38:54.115082612 +0000 UTC m=+2627587.507236755');
INSERT INTO refresh_tokens VALUES('a1804b3d5a32f11d434d86b1d335c11cca89e2fda43b54d6b7f8055b3a391c99','2025-07-11 03:15:31','2025-07-11 03:15:31',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 03:15:31.05612681 +0000 UTC m=+2629784.448280953');
INSERT INTO refresh_tokens VALUES('026f136145f6f01a85f29cba449f90b2d0938ca6e01fae312ab3f06546281d98','2025-07-11 05:17:13','2025-07-11 05:17:13',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 05:17:13.524801292 +0000 UTC m=+2637086.916955435');
INSERT INTO refresh_tokens VALUES('c7b0c6795a81c1d987285d74bd88b1fe716aa93b7d78142daf3ac61c4bf845e7','2025-07-11 07:59:43','2025-07-11 07:59:43',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 07:59:43.190039745 +0000 UTC m=+2646836.582193888');
INSERT INTO refresh_tokens VALUES('630a984e90965d81ccc832672f20923c180feeb32f76e34382e90827947c883f','2025-07-11 07:59:45','2025-07-11 07:59:45',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 07:59:45.501385163 +0000 UTC m=+2646838.893539306');
INSERT INTO refresh_tokens VALUES('e87484a869066d2733f347e148cf1739857dc3b642e02ae2024bacf9f9b3de65','2025-07-11 08:02:18','2025-07-11 08:02:18',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 08:02:18.573785036 +0000 UTC m=+2646991.965939179');
INSERT INTO refresh_tokens VALUES('741878ca380b8a923cfc20b1256893a9808c4f93c4fab9ee68d817bd6929f266','2025-07-11 08:52:24','2025-07-11 08:52:24',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 08:52:24.956273942 +0000 UTC m=+2649998.348428086');
INSERT INTO refresh_tokens VALUES('92ae8bc4164b63789e8975b1be0c3dece73ee74edf61c765f51209927bc3f822','2025-07-11 09:13:29','2025-07-11 09:13:29',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 09:13:29.682796381 +0000 UTC m=+2651263.074950524');
INSERT INTO refresh_tokens VALUES('ae8c0637e28a024931972d6e0294d471d776f9804c1a3b25f0c461ab468ecab9','2025-07-11 09:13:32','2025-07-11 09:13:32',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 09:13:32.640176748 +0000 UTC m=+2651266.032330891');
INSERT INTO refresh_tokens VALUES('3e257e7da90babdd09e8baa32bb1f9b2316604d28138cda1fa33f327b2d1c865','2025-07-11 10:13:17','2025-07-11 10:13:17',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 10:13:17.705018929 +0000 UTC m=+2654851.097173072');
INSERT INTO refresh_tokens VALUES('388f79ffec851d819b1112a64fa4145fe475b8705d603d0b2bfb2bce690f9dd9','2025-07-11 11:10:31','2025-07-11 11:10:31',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 11:10:31.473878062 +0000 UTC m=+2658284.866032205');
INSERT INTO refresh_tokens VALUES('d1600c484024e1358cbe0ca90e27540a3abbe3d3459d38df4b9a142876e77b55','2025-07-11 13:06:34','2025-07-11 13:06:34',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 13:06:34.671536432 +0000 UTC m=+2592220.693600020');
INSERT INTO refresh_tokens VALUES('6fc4e524dfd58c333c29bab24f0dd514d05ec918135f09df701fccb5d9bc3d29','2025-07-11 13:11:07','2025-07-11 13:11:07',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 13:11:07.886939463 +0000 UTC m=+2592493.909003041');
INSERT INTO refresh_tokens VALUES('681753faf9c19b6ff5ec9f0e0b9be23ff0663f40d392cc9c430d825b7a3e336a','2025-07-11 13:21:22','2025-07-11 13:21:22',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 13:21:22.497402248 +0000 UTC m=+2593108.519465826');
INSERT INTO refresh_tokens VALUES('a47dc69005c3a39d5da2cf2c63695895ba81f9582f0f7f222ff1700a275730b4','2025-07-11 14:13:48','2025-07-11 14:13:48',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 14:13:48.412209649 +0000 UTC m=+2596254.434273227');
INSERT INTO refresh_tokens VALUES('65e54b536a9fab3a791a8171318899cc9ed65ad28bbc206e76327c60e51a1de5','2025-07-11 14:14:28','2025-07-11 14:14:28',NULL,'7fa2a457-30dd-4680-90e7-bab22b00d8f9','2025-08-10 14:14:28.795778773 +0000 UTC m=+2596294.817842350');
INSERT INTO refresh_tokens VALUES('d521a9144d1b5df6e1c908ac7e8a9e09f8bdad3845b9e6ec29c0d43b9d09e047','2025-07-11 14:14:58','2025-07-11 14:14:58',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 14:14:58.325297906 +0000 UTC m=+2596324.347361484');
INSERT INTO refresh_tokens VALUES('16b5dc76c7be462653d16eee05b78f2262847627109eb73b63ec64d0c575f7dd','2025-07-11 15:19:18','2025-07-11 15:19:18',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 15:19:18.363477432 +0000 UTC m=+2600184.385541010');
INSERT INTO refresh_tokens VALUES('5ad462f2194477377cf5626adda64bcc032e5041d21f2c6be5fba2bc665832a1','2025-07-11 17:20:16','2025-07-11 17:20:16',NULL,'00000000-0000-0000-0000-000000000000','2025-08-10 17:20:16.323308404 +0000 UTC m=+2607442.345371982');
INSERT INTO refresh_tokens VALUES('b9a52ed4c31750389bb42c30ac9826ebf5094910e1c8609a80523de90413e324','2025-07-12 01:28:13','2025-07-12 01:28:13',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 01:28:13.142701593 +0000 UTC m=+2636719.164765171');
INSERT INTO refresh_tokens VALUES('e2bacaadd7605a8de135d47ecf4c9080b42a8fe6e71543bdde3c76a9116ceba2','2025-07-12 02:35:01','2025-07-12 02:35:01',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 02:35:00.996620767 +0000 UTC m=+2640727.018684345');
INSERT INTO refresh_tokens VALUES('687245735615505dce4ea8c812d0a5390faf463d1b770250584ddd5b305d52d2','2025-07-12 02:41:55','2025-07-12 02:41:55',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 02:41:55.886790628 +0000 UTC m=+2641141.908854206');
INSERT INTO refresh_tokens VALUES('c64b143f50207dff80c470e193a618d92f3a2bde1a2a481036797ac6c60ff630','2025-07-12 02:41:57','2025-07-12 02:41:57',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 02:41:57.018525632 +0000 UTC m=+2641143.040589210');
INSERT INTO refresh_tokens VALUES('27ffaeaf0e30c1c6cc9dee29bb2821c070b280f38cc54a34191a847bfa7f7e7c','2025-07-12 02:41:58','2025-07-12 02:41:58',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 02:41:58.949903366 +0000 UTC m=+2641144.971966945');
INSERT INTO refresh_tokens VALUES('2eeb3fe50fc3566b6ae33b78f1689c211fece647114184eb45dc833249627d65','2025-07-12 02:42:01','2025-07-12 02:42:01',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 02:42:01.187222069 +0000 UTC m=+2641147.209285657');
INSERT INTO refresh_tokens VALUES('c9d7457b4996d42772ac9948c58d7ba2620c900a8c425148d5487a9a6812cac9','2025-07-12 02:42:03','2025-07-12 02:42:03',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 02:42:03.350500041 +0000 UTC m=+2641149.372563629');
INSERT INTO refresh_tokens VALUES('959d2cb863bd53740cc4a4420466641aa63a1d2a95e33835b57b3ff863aa6f19','2025-07-12 05:09:30','2025-07-12 05:09:30',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 05:09:30.831387837 +0000 UTC m=+2595077.092351393');
INSERT INTO refresh_tokens VALUES('0722f3a70619227d2c9ca403fa963d5a8b6ab72c68203db5cd4b892a52add9cb','2025-07-12 05:18:33','2025-07-12 05:18:33',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 05:18:33.885352638 +0000 UTC m=+2595620.146316194');
INSERT INTO refresh_tokens VALUES('6b2c0ddf62402d450e4371456bce57a257afd2518c853730f7ef5c062482565e','2025-07-12 07:03:56','2025-07-12 07:03:56',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 07:03:56.12095324 +0000 UTC m=+2601942.381916806');
INSERT INTO refresh_tokens VALUES('3fd5f35f5caaa6bedb9426a4953e12e682fe4d6a8fb6a120847a4c78ffc0c3bb','2025-07-12 08:13:44','2025-07-12 08:13:44',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 08:13:44.537152044 +0000 UTC m=+2606130.798115599');
INSERT INTO refresh_tokens VALUES('948f68e73366e358e7348a441ea14479c43e5fe444da10283592d9081edc4407','2025-07-12 08:13:47','2025-07-12 08:13:47',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 08:13:47.750541054 +0000 UTC m=+2606134.011504610');
INSERT INTO refresh_tokens VALUES('e3bc61b9f272564341dc703c8cf4d8bdc3881e9fa2cb2874bd636b86a82b632e','2025-07-12 08:58:59','2025-07-12 08:58:59',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 08:58:58.968520138 +0000 UTC m=+2592081.454517315');
INSERT INTO refresh_tokens VALUES('a14204bca46b6073c230f5a32d4794416499a29e675de15461ae384ea2233500','2025-07-12 09:06:53','2025-07-12 09:06:53',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 09:06:53.034614682 +0000 UTC m=+2592555.520611860');
INSERT INTO refresh_tokens VALUES('7b98e1b5119e8a9a122bfa783d07db792e730b979ebd3e744bdd943e40acfd5a','2025-07-12 13:04:08','2025-07-12 13:04:08',NULL,'00000000-0000-0000-0000-000000000000','2025-08-11 13:04:08.839376859 +0000 UTC m=+2606791.325374037');
INSERT INTO refresh_tokens VALUES('8cd85e22a7d72f72c1a6de464cf59774280c66698d0c2dc7f42cf70679aa4e03','2025-07-13 00:07:26','2025-07-13 00:07:26',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 00:07:26.659718574 +0000 UTC m=+2646589.145717301');
INSERT INTO refresh_tokens VALUES('e37acf890af914c5e61ba2333397dd271985bafad05b78a4350db4dd6bdbe360','2025-07-13 04:26:01','2025-07-13 04:26:01',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 04:26:01.953104924 +0000 UTC m=+2662104.439103753');
INSERT INTO refresh_tokens VALUES('d6b4483a85cba54a6aa67e2d1a45845cccb933aeb6cc91cd23cd404a4774adbd','2025-07-13 05:55:22','2025-07-13 05:55:22',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 05:55:22.388909701 +0000 UTC m=+2667464.874908312');
INSERT INTO refresh_tokens VALUES('7ad319b9f97c65d3f745c479c193ec74db82f75eeae001db7923d036a667bb5e','2025-07-13 08:47:47','2025-07-13 08:47:47',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 08:47:47.474093106 +0000 UTC m=+2677809.960091633');
INSERT INTO refresh_tokens VALUES('d81743082e1a4a6ba10fdd059be2bd2c1a576f1e0c481ee30dfc8635a4ce849c','2025-07-13 09:03:12','2025-07-13 09:03:12',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 09:03:12.57138373 +0000 UTC m=+2678735.057382552');
INSERT INTO refresh_tokens VALUES('41dc78ce2fbe9231ff632360a30971566e1d60da98361ba776ba033e423266f5','2025-07-13 09:07:12','2025-07-13 09:07:12',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 09:07:12.711585622 +0000 UTC m=+2678975.197584496');
INSERT INTO refresh_tokens VALUES('063f76760ccfa901dd1f1136f9ff0ea7cd662b32a01ef5f4f80228417dcb2080','2025-07-13 09:12:31','2025-07-13 09:12:31',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 09:12:31.239297 +0000 UTC m=+2679293.725295562');
INSERT INTO refresh_tokens VALUES('2f25231d42fd40edafc9754e6dab90fda4630f92db769f8d7913a6ff309eb888','2025-07-13 10:51:33','2025-07-13 10:51:33',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 10:51:33.490121579 +0000 UTC m=+2685235.976120420');
INSERT INTO refresh_tokens VALUES('cb1496f8cbdd43b52235cfb2bfbe6f4812caf723db92a2fd4b1cb881635ba85c','2025-07-13 13:18:05','2025-07-13 13:18:05',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 13:18:05.963428859 +0000 UTC m=+2694028.449427464');
INSERT INTO refresh_tokens VALUES('04fcce6e6c9ac17fd0130051fa2fb5caf16da42866588ebbf0123ea462855ea9','2025-07-13 22:50:11','2025-07-13 22:50:11',NULL,'00000000-0000-0000-0000-000000000000','2025-08-12 22:50:11.508018873 +0000 UTC m=+2728353.994017314');
INSERT INTO refresh_tokens VALUES('c6b34c6ad5b42d27aaa24d0fe59d96b7de3dcc5b953a5321598246d679021650','2025-07-14 03:07:21','2025-07-14 03:07:21',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 03:07:21.054828862 +0000 UTC m=+2743783.540828204');
INSERT INTO refresh_tokens VALUES('900b7dc857b86e5c9c322e4ce43e0aa79d8db66a1431a62a180c41aad9b524e3','2025-07-14 03:07:22','2025-07-14 03:07:22',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 03:07:22.449737492 +0000 UTC m=+2743784.935736245');
INSERT INTO refresh_tokens VALUES('36e6f95de04d2e7c9b806613e29b20dcbe495fa365c46809bbe072c299a50f60','2025-07-14 04:19:04','2025-07-14 04:19:04',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 04:19:04.03082729 +0000 UTC m=+2748086.516825629');
INSERT INTO refresh_tokens VALUES('c93890f648cd1d1b18d06db9bc57e99cf931d13bb9c80b6c0d229ab1d91058c5','2025-07-14 05:33:30','2025-07-14 05:33:30',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 05:33:30.36099017 +0000 UTC m=+2752552.846988630');
INSERT INTO refresh_tokens VALUES('36dc3a08f1c93a8d66f97800a6c77d72c2a273cc7618c35c73680565a5e74068','2025-07-14 06:35:47','2025-07-14 06:35:47',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 06:35:46.969985032 +0000 UTC m=+2756289.455983202');
INSERT INTO refresh_tokens VALUES('8c4a68186cc58ca7e176d3bf3faa68377ffc4dd63a9eb0a2838f3e73c0cb51ed','2025-07-14 08:44:13','2025-07-14 08:44:13',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 08:44:13.919304535 +0000 UTC m=+2763996.405303072');
INSERT INTO refresh_tokens VALUES('5d3e503a0a2032bb5b7e4632482b73a6ebeb38e80222ea1d6404c2303a863f28','2025-07-14 09:38:36','2025-07-14 09:38:36',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 09:38:36.667059853 +0000 UTC m=+2592000.587098334');
INSERT INTO refresh_tokens VALUES('39a966187b7756fe28ebfea42d60dac2f9c285a211ad8de490beaadc20b37e7d','2025-07-14 09:45:24','2025-07-14 09:45:24',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 09:45:24.727510787 +0000 UTC m=+2592278.903894470');
INSERT INTO refresh_tokens VALUES('bdab83f553abf687de6d62901ab64e0594570d7a688d3e6dbac870a2eab89714','2025-07-14 10:48:55','2025-07-14 10:48:55',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 10:48:55.808880462 +0000 UTC m=+2592000.510690859');
INSERT INTO refresh_tokens VALUES('6c1c33c8fec6e9bd691aa376e6d300285986238627315f1d3a2c68186550d3ef','2025-07-14 10:57:47','2025-07-14 10:57:47',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 10:57:47.087820312 +0000 UTC m=+2592531.789630709');
INSERT INTO refresh_tokens VALUES('83817e1cc257482a14e52c661e5bb26eea6076bdc92b67f7cf086deef44ba58c','2025-07-14 13:36:10','2025-07-14 13:36:10',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 13:36:10.028326584 +0000 UTC m=+2592036.433897341');
INSERT INTO refresh_tokens VALUES('c18fa5df62c1e4b4be872a48bc511abd3812b0da0bdf4dad6a5c8a60ea1b6d55','2025-07-14 13:40:53','2025-07-14 13:40:53',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 13:40:53.874859485 +0000 UTC m=+2592320.280430242');
INSERT INTO refresh_tokens VALUES('623b7c064ae92796c0a573dc83e563dd660e5f18ee0fc5b1208eb2c3aa433b9b','2025-07-14 14:03:52','2025-07-14 14:03:52',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 14:03:52.910736132 +0000 UTC m=+2592012.877660955');
INSERT INTO refresh_tokens VALUES('ac4e2011973ef99a3d8d684c38b6581e109540ab6cfeefb1cf9c2cb2b4f34625','2025-07-14 15:22:31','2025-07-14 15:22:31',NULL,'00000000-0000-0000-0000-000000000000','2025-08-13 15:22:31.049086661 +0000 UTC m=+2592000.442842209');
INSERT INTO refresh_tokens VALUES('4b03253e1eb5ef84711e8d90b8398673bf87e8fc2385d7776b8340b741cde6ad','2025-07-15 00:56:46','2025-07-15 00:56:46',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 00:56:46.551702927 +0000 UTC m=+2592000.430709512');
INSERT INTO refresh_tokens VALUES('d9af1c3f4d2da48df9b0f0ae22bbe33427cf23330985925c0835ed1b70d9c2bf','2025-07-15 03:13:59','2025-07-15 03:13:59',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 03:13:59.622902172 +0000 UTC m=+2592000.523596624');
INSERT INTO refresh_tokens VALUES('8ae423dc6f9eca82f4c7074fae304dba173c126b4db04ded4180df0f1c0cd48e','2025-07-15 05:52:16','2025-07-15 05:52:16',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 05:52:16.402955183 +0000 UTC m=+2592000.473629413');
INSERT INTO refresh_tokens VALUES('de1e11083ff230a6157d5f6c0477aee4f7d6a13ca447e9149acc5bb0eb82aa7c','2025-07-15 07:13:39','2025-07-15 07:13:39',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 07:13:39.559140308 +0000 UTC m=+2592000.464345418');
INSERT INTO refresh_tokens VALUES('089c48b09d0f59c9db5736c058afdd50dad642274107b3e4e66deabf7bd5daeb','2025-07-15 08:19:44','2025-07-15 08:19:44',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 08:19:44.698928305 +0000 UTC m=+2592000.437262344');
INSERT INTO refresh_tokens VALUES('f2bb455648573cb2d7528279a1560c30a8c990b9859cb16f21614cda60d5bc58','2025-07-15 08:27:05','2025-07-15 08:27:05',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 08:27:05.631892207 +0000 UTC m=+2592441.370226246');
INSERT INTO refresh_tokens VALUES('f31f0e3ca7bf325851d68a048a548bf9c1280aae9de8fe2be427a79cd743b00a','2025-07-15 08:28:33','2025-07-15 08:28:33',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 08:28:33.929356971 +0000 UTC m=+2592529.667691010');
INSERT INTO refresh_tokens VALUES('59215127f6623acea8c9287f5f335b82fc379e4fbea385997d1db93a6cd31ca1','2025-07-15 10:22:41','2025-07-15 10:22:41',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 10:22:41.783466295 +0000 UTC m=+2592009.251563697');
INSERT INTO refresh_tokens VALUES('4f03261470f9188b4e776f164ba47e33d91373c40e8d4c72a542383b6217278e','2025-07-15 13:48:02','2025-07-15 13:48:02',NULL,'00000000-0000-0000-0000-000000000000','2025-08-14 13:48:01.993542207 +0000 UTC m=+2592000.419558153');
INSERT INTO refresh_tokens VALUES('df96d7da840cf3a3c98eeac48f3b0804910ba40d5855165ea8c9cb33c4629dc4','2025-07-16 00:50:57','2025-07-16 00:50:57',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 00:50:57.688305532 +0000 UTC m=+2592000.460003124');
INSERT INTO refresh_tokens VALUES('e60942558c0de9c5ad2eb0e867a5543482080c9cd5dd7ae161828af19e189507','2025-07-16 03:29:46','2025-07-16 03:29:46',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 03:29:46.652694452 +0000 UTC m=+2592000.442246607');
INSERT INTO refresh_tokens VALUES('5fece7a9cad6ce139ef49737c8bc47f515afa17d66adb1d702dcd8a1a64f81ca','2025-07-16 05:55:53','2025-07-16 05:55:53',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 05:55:53.73148809 +0000 UTC m=+2592311.500764216');
INSERT INTO refresh_tokens VALUES('56b5cfca79a8e820b6a6005cfb0636c704127c71fa356c7a469b07d47bef5529','2025-07-16 06:29:43','2025-07-16 06:29:43',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 06:29:43.387683939 +0000 UTC m=+2594341.156960075');
INSERT INTO refresh_tokens VALUES('d16e2f23f8bf8bbe45053a578e30f70b824dff2268b32fd8dbecaeb34baa70e8','2025-07-16 06:32:55','2025-07-16 06:32:55',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 06:32:54.970494978 +0000 UTC m=+2594532.739771104');
INSERT INTO refresh_tokens VALUES('04d3c6e8100ba69a2ea6eb9e526c7da9821068675024e42363dd2c5b0b80c671','2025-07-16 07:56:02','2025-07-16 07:56:02',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 07:56:02.122943801 +0000 UTC m=+2599519.892219917');
INSERT INTO refresh_tokens VALUES('15d932f50950c53619bbb701a37bb41e4db6eee80ffafd903a3f4a881125d89b','2025-07-16 08:30:30','2025-07-16 08:30:30',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 08:30:30.759788341 +0000 UTC m=+2601588.529064467');
INSERT INTO refresh_tokens VALUES('cbe187406fb4fc72646a239c81462d0cb206f6039788645e695e15c3b494237e','2025-07-16 08:30:31','2025-07-16 08:30:31',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 08:30:31.965585213 +0000 UTC m=+2601589.734861339');
INSERT INTO refresh_tokens VALUES('87e77a53c183a67b348994449e97f7cf09f5afb6eac719dbdca8deba2a82e03a','2025-07-16 08:53:15','2025-07-16 08:53:15',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 08:53:15.603011599 +0000 UTC m=+2602953.372287725');
INSERT INTO refresh_tokens VALUES('1fd70913474b125af51eb5f9093770e0fc46167eb1fc9c2b1290cd5043fa8f7a','2025-07-16 09:57:39','2025-07-16 09:57:39',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 09:57:39.116492586 +0000 UTC m=+2606816.885768712');
INSERT INTO refresh_tokens VALUES('ca3c8f7cf56a42e86e940483cdf006a7254acb8494577b6590bd381b1c3fdec8','2025-07-16 10:46:14','2025-07-16 10:46:14',NULL,'00000000-0000-0000-0000-000000000000','2025-08-15 10:46:14.517333238 +0000 UTC m=+2592027.680688740');
CREATE TABLE IF NOT EXISTS places (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL DEFAULT ""
, is_clean BOOLEAN NOT NULL DEFAULT 1);
INSERT INTO places VALUES(1,'None',1);
INSERT INTO places VALUES(3,'George House',1);
INSERT INTO places VALUES(4,'Metta House',1);
INSERT INTO places VALUES(5,'Staff House',1);
INSERT INTO places VALUES(6,'Sie House',1);
INSERT INTO places VALUES(7,'Meeting Point',1);
INSERT INTO places VALUES(8,'Lake House',1);
INSERT INTO places VALUES(9,'WellNess One',1);
INSERT INTO places VALUES(10,'WellNess Two',1);
INSERT INTO places VALUES(11,'Merit House',1);
INSERT INTO places VALUES(12,'Hut',1);
INSERT INTO places VALUES(13,'Rattanyu House',1);
INSERT INTO places VALUES(15,'Bungalow',1);
INSERT INTO places VALUES(16,'Tree House',1);
INSERT INTO places VALUES(17,'Kangaroo House',1);
INSERT INTO places VALUES(18,'Center Hall',1);
INSERT INTO places VALUES(19,'Storage Room',1);
INSERT INTO places VALUES(20,'WaterFall One',1);
INSERT INTO places VALUES(21,'WaterFall Two',1);
INSERT INTO places VALUES(22,'Pool View Kuti',1);
INSERT INTO places VALUES(23,'Forest Hall',1);
INSERT INTO places VALUES(24,'SLP. Kuti',1);
INSERT INTO places VALUES(25,'Monk Kuti',1);
CREATE TABLE IF NOT EXISTS rooms (
  id INTEGER PRIMARY KEY,
  number INTEGER NOT NULL,
  capacity INTEGER NOT NULL DEFAULT 1,
  checked_in INTEGER NOT NULL DEFAULT 0,
  place_id INTEGER NOT NULL,
  is_clean BOOLEAN NOT NULL DEFAULT 1,
  FOREIGN KEY (place_id) REFERENCES places (id) ON UPDATE CASCADE ON DELETE CASCADE CHECK (checked_in <= capacity)
);
INSERT INTO rooms VALUES(0,1,100000000000,0,1,1);
INSERT INTO rooms VALUES(3,1,2,0,3,1);
INSERT INTO rooms VALUES(4,2,2,0,3,1);
INSERT INTO rooms VALUES(5,3,3,0,3,1);
INSERT INTO rooms VALUES(6,1,2,0,4,1);
INSERT INTO rooms VALUES(12,1,2,0,6,1);
INSERT INTO rooms VALUES(13,2,1,0,6,1);
INSERT INTO rooms VALUES(14,3,2,0,6,1);
INSERT INTO rooms VALUES(15,4,1,0,6,1);
INSERT INTO rooms VALUES(16,5,2,0,6,1);
INSERT INTO rooms VALUES(17,6,1,0,6,1);
INSERT INTO rooms VALUES(18,7,2,0,6,1);
INSERT INTO rooms VALUES(19,8,2,0,6,1);
INSERT INTO rooms VALUES(20,1,2,0,7,1);
INSERT INTO rooms VALUES(21,2,2,0,7,1);
INSERT INTO rooms VALUES(22,3,3,0,7,1);
INSERT INTO rooms VALUES(23,1,2,0,8,1);
INSERT INTO rooms VALUES(24,2,1,0,8,1);
INSERT INTO rooms VALUES(25,3,2,0,8,1);
INSERT INTO rooms VALUES(26,4,2,0,8,1);
INSERT INTO rooms VALUES(27,1,1,0,9,1);
INSERT INTO rooms VALUES(28,2,1,0,9,1);
INSERT INTO rooms VALUES(29,3,1,0,9,1);
INSERT INTO rooms VALUES(30,4,1,0,9,1);
INSERT INTO rooms VALUES(31,5,1,0,9,1);
INSERT INTO rooms VALUES(32,6,1,0,9,1);
INSERT INTO rooms VALUES(33,7,1,0,9,1);
INSERT INTO rooms VALUES(34,8,1,0,9,1);
INSERT INTO rooms VALUES(35,9,1,0,9,1);
INSERT INTO rooms VALUES(36,10,1,0,9,1);
INSERT INTO rooms VALUES(37,11,1,0,9,1);
INSERT INTO rooms VALUES(38,12,1,0,9,1);
INSERT INTO rooms VALUES(39,13,2,0,9,1);
INSERT INTO rooms VALUES(40,14,2,0,9,1);
INSERT INTO rooms VALUES(41,15,2,0,9,1);
INSERT INTO rooms VALUES(42,1,2,0,10,1);
INSERT INTO rooms VALUES(43,2,2,0,10,1);
INSERT INTO rooms VALUES(44,3,2,0,10,1);
INSERT INTO rooms VALUES(45,4,1,0,10,1);
INSERT INTO rooms VALUES(46,1,1,0,11,1);
INSERT INTO rooms VALUES(47,2,2,0,11,1);
INSERT INTO rooms VALUES(48,3,2,0,11,1);
INSERT INTO rooms VALUES(49,4,1,0,11,1);
INSERT INTO rooms VALUES(50,1,1,0,12,1);
INSERT INTO rooms VALUES(51,2,1,0,12,1);
INSERT INTO rooms VALUES(52,1,2,0,13,1);
INSERT INTO rooms VALUES(53,2,2,0,13,1);
INSERT INTO rooms VALUES(54,3,1,0,13,1);
INSERT INTO rooms VALUES(55,4,4,0,13,1);
INSERT INTO rooms VALUES(56,5,2,0,13,1);
INSERT INTO rooms VALUES(57,6,2,0,13,1);
INSERT INTO rooms VALUES(58,7,2,0,13,1);
INSERT INTO rooms VALUES(59,8,2,0,13,1);
INSERT INTO rooms VALUES(60,9,2,0,13,1);
INSERT INTO rooms VALUES(61,10,2,0,13,1);
INSERT INTO rooms VALUES(62,2,2,0,4,1);
INSERT INTO rooms VALUES(63,3,1,0,4,1);
INSERT INTO rooms VALUES(64,4,1,0,4,1);
INSERT INTO rooms VALUES(65,5,2,0,4,1);
INSERT INTO rooms VALUES(66,6,2,0,4,1);
INSERT INTO rooms VALUES(67,1,2,0,15,1);
INSERT INTO rooms VALUES(68,2,1,0,15,1);
INSERT INTO rooms VALUES(69,3,2,0,15,1);
INSERT INTO rooms VALUES(70,4,2,0,15,1);
INSERT INTO rooms VALUES(71,5,2,0,15,1);
INSERT INTO rooms VALUES(72,6,1,0,15,1);
INSERT INTO rooms VALUES(73,7,1,0,15,1);
INSERT INTO rooms VALUES(74,1,2,0,16,1);
INSERT INTO rooms VALUES(75,2,2,0,16,1);
INSERT INTO rooms VALUES(76,1,2,0,17,1);
INSERT INTO rooms VALUES(77,2,2,0,17,1);
INSERT INTO rooms VALUES(78,1,2,0,18,1);
INSERT INTO rooms VALUES(79,1,2,0,19,1);
INSERT INTO rooms VALUES(80,1,1,0,20,1);
INSERT INTO rooms VALUES(81,2,1,0,20,1);
INSERT INTO rooms VALUES(82,3,1,0,20,1);
INSERT INTO rooms VALUES(83,4,1,0,20,1);
INSERT INTO rooms VALUES(84,5,1,0,20,1);
INSERT INTO rooms VALUES(85,1,1,0,21,1);
INSERT INTO rooms VALUES(86,2,1,0,21,1);
INSERT INTO rooms VALUES(87,3,1,0,21,1);
INSERT INTO rooms VALUES(88,4,1,0,21,1);
INSERT INTO rooms VALUES(89,5,1,0,21,1);
INSERT INTO rooms VALUES(90,6,1,0,21,1);
INSERT INTO rooms VALUES(91,7,1,0,21,1);
INSERT INTO rooms VALUES(92,8,1,0,21,1);
INSERT INTO rooms VALUES(93,1,1,0,22,1);
INSERT INTO rooms VALUES(94,11,1,0,23,1);
INSERT INTO rooms VALUES(95,12,1,0,23,1);
INSERT INTO rooms VALUES(96,13,1,0,23,1);
INSERT INTO rooms VALUES(97,1,2,0,24,1);
INSERT INTO rooms VALUES(98,2,2,0,24,1);
INSERT INTO rooms VALUES(99,3,2,0,24,1);
INSERT INTO rooms VALUES(102,3,1,0,5,1);
INSERT INTO rooms VALUES(104,5,1,0,5,1);
INSERT INTO rooms VALUES(105,6,4,0,5,1);
INSERT INTO rooms VALUES(109,10,4,0,5,1);
INSERT INTO rooms VALUES(110,6,8,0,20,1);
INSERT INTO rooms VALUES(111,2,1,0,25,1);
INSERT INTO rooms VALUES(113,4,1,0,25,1);
INSERT INTO rooms VALUES(114,5,1,0,25,1);
CREATE TABLE IF NOT EXISTS users_logs (
  user_id integer not null,
  log_id integer not null,
  primary key (user_id, log_id),
  foreign key (user_id) references users (id),
  foreign key (log_id) references logs (id)
);
CREATE TABLE IF NOT EXISTS logs (
  id integer primary key,
  check_in_date datetime,
  check_out_date datetime,
  donated integer,
  place_id integer,
  room_id integer
);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('goose_db_version',66);
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
COMMIT;
