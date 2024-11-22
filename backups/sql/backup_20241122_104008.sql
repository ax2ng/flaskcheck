BEGIN TRANSACTION;
CREATE TABLE alembic_version (
	version_num VARCHAR(32) NOT NULL, 
	CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
INSERT INTO "alembic_version" VALUES('6fa96a6659be');
CREATE TABLE chat_messages (
	id INTEGER NOT NULL, 
	chat_room_id INTEGER NOT NULL, 
	user_id INTEGER NOT NULL, 
	content TEXT, 
	timestamp DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(chat_room_id) REFERENCES chat_rooms (id), 
	FOREIGN KEY(user_id) REFERENCES users (id)
);
INSERT INTO "chat_messages" VALUES(1,1,2,'Message 1 in project 1','2024-11-20 19:33:08.176887');
INSERT INTO "chat_messages" VALUES(2,1,3,'Message 2 in project 1','2024-11-20 19:33:08.176918');
INSERT INTO "chat_messages" VALUES(3,1,3,'Message 3 in project 1','2024-11-20 19:33:08.176934');
INSERT INTO "chat_messages" VALUES(4,1,1,'Message 4 in project 1','2024-11-20 19:33:08.176947');
INSERT INTO "chat_messages" VALUES(5,1,1,'Message 5 in project 1','2024-11-20 19:33:08.176959');
INSERT INTO "chat_messages" VALUES(6,2,1,'Message 1 in project 2','2024-11-20 19:33:08.177595');
INSERT INTO "chat_messages" VALUES(7,2,3,'Message 2 in project 2','2024-11-20 19:33:08.177619');
INSERT INTO "chat_messages" VALUES(8,2,1,'Message 3 in project 2','2024-11-20 19:33:08.177633');
INSERT INTO "chat_messages" VALUES(9,2,3,'Message 4 in project 2','2024-11-20 19:33:08.177645');
INSERT INTO "chat_messages" VALUES(10,2,2,'Message 5 in project 2','2024-11-20 19:33:08.177657');
INSERT INTO "chat_messages" VALUES(11,3,1,'Message 1 in project 3','2024-11-20 19:33:08.177997');
INSERT INTO "chat_messages" VALUES(12,3,1,'Message 2 in project 3','2024-11-20 19:33:08.178017');
INSERT INTO "chat_messages" VALUES(13,3,3,'Message 3 in project 3','2024-11-20 19:33:08.178030');
INSERT INTO "chat_messages" VALUES(14,3,1,'Message 4 in project 3','2024-11-20 19:33:08.178042');
INSERT INTO "chat_messages" VALUES(15,3,3,'Message 5 in project 3','2024-11-20 19:33:08.178054');
CREATE TABLE chat_rooms (
	id INTEGER NOT NULL, 
	project_id INTEGER, 
	task_id INTEGER, 
	created_at DATETIME NOT NULL, 
	type VARCHAR(50) NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(project_id) REFERENCES projects (id), 
	FOREIGN KEY(task_id) REFERENCES tasks (id)
);
INSERT INTO "chat_rooms" VALUES(1,1,NULL,'2024-11-20 19:33:08.176724','project');
INSERT INTO "chat_rooms" VALUES(2,2,NULL,'2024-11-20 19:33:08.177182','project');
INSERT INTO "chat_rooms" VALUES(3,3,NULL,'2024-11-20 19:33:08.177799','project');
CREATE TABLE files (
	id INTEGER NOT NULL, 
	user_id INTEGER NOT NULL, 
	project_id INTEGER, 
	task_id INTEGER, 
	chat_message_id INTEGER, 
	file_url VARCHAR(255) NOT NULL, 
	upload_time DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES users (id), 
	FOREIGN KEY(project_id) REFERENCES projects (id), 
	FOREIGN KEY(task_id) REFERENCES tasks (id), 
	FOREIGN KEY(chat_message_id) REFERENCES chat_messages (id)
);
INSERT INTO "files" VALUES(1,1,3,NULL,NULL,'https://example.com/file1.txt','2024-11-20 19:33:08.178547');
INSERT INTO "files" VALUES(2,1,2,NULL,NULL,'https://example.com/file2.txt','2024-11-20 19:33:08.178574');
INSERT INTO "files" VALUES(3,1,1,NULL,NULL,'https://example.com/file3.txt','2024-11-20 19:33:08.178585');
INSERT INTO "files" VALUES(4,3,3,NULL,NULL,'https://example.com/file4.txt','2024-11-20 19:33:08.178594');
INSERT INTO "files" VALUES(5,1,1,NULL,NULL,'https://example.com/file5.txt','2024-11-20 19:33:08.178602');
INSERT INTO "files" VALUES(6,1,3,NULL,NULL,'https://example.com/file6.txt','2024-11-20 19:33:08.178611');
INSERT INTO "files" VALUES(7,3,3,NULL,NULL,'https://example.com/file7.txt','2024-11-20 19:33:08.178619');
INSERT INTO "files" VALUES(8,1,2,NULL,NULL,'https://example.com/file8.txt','2024-11-20 19:33:08.178627');
INSERT INTO "files" VALUES(9,2,1,NULL,NULL,'https://example.com/file9.txt','2024-11-20 19:33:08.178635');
INSERT INTO "files" VALUES(10,2,2,NULL,NULL,'https://example.com/file10.txt','2024-11-20 19:33:08.178643');
CREATE TABLE posts (
	id INTEGER NOT NULL, 
	body VARCHAR(140), 
	timestamp DATETIME NOT NULL, 
	user_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES users (id)
);
CREATE TABLE priorities (
	id INTEGER NOT NULL, 
	level VARCHAR(20) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (level)
);
INSERT INTO "priorities" VALUES(1,'Low');
INSERT INTO "priorities" VALUES(2,'Medium');
INSERT INTO "priorities" VALUES(3,'High');
CREATE TABLE project_executors (
	user_id INTEGER NOT NULL, 
	project_id INTEGER NOT NULL, 
	PRIMARY KEY (user_id, project_id), 
	FOREIGN KEY(user_id) REFERENCES users (id), 
	FOREIGN KEY(project_id) REFERENCES projects (id)
);
CREATE TABLE project_statistics (
	id INTEGER NOT NULL, 
	project_id INTEGER NOT NULL, 
	tasks_total INTEGER NOT NULL, 
	tasks_completed INTEGER NOT NULL, 
	average_completion_time FLOAT, 
	created_at DATETIME NOT NULL, 
	updated_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(project_id) REFERENCES projects (id)
);
CREATE TABLE projects (
	id INTEGER NOT NULL, 
	title VARCHAR(128) NOT NULL, 
	description VARCHAR(500) NOT NULL, 
	start_date DATETIME NOT NULL, 
	end_date DATETIME, 
	status_id INTEGER NOT NULL, 
	priority_id INTEGER NOT NULL, 
	created_at DATETIME NOT NULL, 
	updated_at DATETIME NOT NULL, 
	manager_id INTEGER NOT NULL, 
	responsible_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(status_id) REFERENCES statuses (id), 
	FOREIGN KEY(priority_id) REFERENCES priorities (id), 
	FOREIGN KEY(manager_id) REFERENCES users (id), 
	FOREIGN KEY(responsible_id) REFERENCES users (id)
);
INSERT INTO "projects" VALUES(1,'Project 1','Description of Project 1','2024-11-20 19:33:08.174275','2024-12-20 19:33:08.174277',1,2,'2024-11-20 19:33:08.174761','2024-11-20 19:33:08.174762',1,2);
INSERT INTO "projects" VALUES(2,'Project 2','Description of Project 2','2024-11-20 19:33:08.174330','2024-12-20 19:33:08.174331',2,2,'2024-11-20 19:33:08.174763','2024-11-20 19:33:08.174764',1,2);
INSERT INTO "projects" VALUES(3,'Project 3','Description of Project 3','2024-11-20 19:33:08.174351','2024-12-20 19:33:08.174351',3,3,'2024-11-20 19:33:08.174764','2024-11-20 19:33:08.174764',1,2);
CREATE TABLE roles (
	id INTEGER NOT NULL, 
	name VARCHAR(64) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
INSERT INTO "roles" VALUES(1,'admin');
INSERT INTO "roles" VALUES(2,'manager');
INSERT INTO "roles" VALUES(3,'responsible');
INSERT INTO "roles" VALUES(4,'executor');
CREATE TABLE statuses (
	id INTEGER NOT NULL, 
	name VARCHAR(50) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
INSERT INTO "statuses" VALUES(1,'Not Started');
INSERT INTO "statuses" VALUES(2,'In Progress');
INSERT INTO "statuses" VALUES(3,'Completed');
CREATE TABLE task_executors (
	user_id INTEGER NOT NULL, 
	task_id INTEGER NOT NULL, 
	PRIMARY KEY (user_id, task_id), 
	FOREIGN KEY(user_id) REFERENCES users (id), 
	FOREIGN KEY(task_id) REFERENCES tasks (id)
);
CREATE TABLE tasks (
	id INTEGER NOT NULL, 
	title VARCHAR(128) NOT NULL, 
	description VARCHAR(500), 
	deadline DATETIME, 
	project_id INTEGER, 
	status_id INTEGER, 
	priority_id INTEGER, 
	created_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(project_id) REFERENCES projects (id), 
	FOREIGN KEY(status_id) REFERENCES statuses (id), 
	FOREIGN KEY(priority_id) REFERENCES priorities (id)
);
INSERT INTO "tasks" VALUES(1,'Task 1','Description of Task 1','2024-11-28 19:33:08.175305',1,3,2,'2024-11-20 19:33:08.175888');
INSERT INTO "tasks" VALUES(2,'Task 2','Description of Task 2','2024-12-03 19:33:08.175352',3,3,2,'2024-11-20 19:33:08.175889');
INSERT INTO "tasks" VALUES(3,'Task 3','Description of Task 3','2024-12-04 19:33:08.175371',3,2,3,'2024-11-20 19:33:08.175890');
INSERT INTO "tasks" VALUES(4,'Task 4','Description of Task 4','2024-11-27 19:33:08.175385',2,2,1,'2024-11-20 19:33:08.175890');
INSERT INTO "tasks" VALUES(5,'Task 5','Description of Task 5','2024-12-02 19:33:08.175398',2,3,2,'2024-11-20 19:33:08.175891');
CREATE TABLE user_roles (
	user_id INTEGER NOT NULL, 
	role_id INTEGER NOT NULL, 
	PRIMARY KEY (user_id, role_id), 
	FOREIGN KEY(user_id) REFERENCES users (id), 
	FOREIGN KEY(role_id) REFERENCES roles (id)
);
INSERT INTO "user_roles" VALUES(1,1);
INSERT INTO "user_roles" VALUES(2,1);
INSERT INTO "user_roles" VALUES(3,4);
CREATE TABLE users (
	id INTEGER NOT NULL, 
	username VARCHAR(64) NOT NULL, 
	email VARCHAR(120) NOT NULL, 
	password_hash VARCHAR(256) NOT NULL, 
	first_name VARCHAR(55), 
	last_name VARCHAR(55), 
	middle_name VARCHAR(55), 
	phone_number VARCHAR(55), 
	date_birth DATE, 
	avatar_url VARCHAR(255), 
	is_active BOOLEAN NOT NULL, 
	creation_time DATETIME NOT NULL, 
	about_me VARCHAR(140), 
	last_seen DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (phone_number)
);
INSERT INTO "users" VALUES(1,'admin','admin@example.com','scrypt:32768:8:1$D8hkF2tZEpfFmeWP$04654c00faa1c9d034319e1a45fcf9f1ed08cd540880169746543ac81459aa2e052cf399e7541e04afda4928013eceddb2cfc2259f52c7c0559cadb2c7ab8040','Admin','User','A',NULL,NULL,NULL,1,'2024-11-20 19:33:08.050783',NULL,'2024-11-22 07:40:08.969546');
INSERT INTO "users" VALUES(2,'admin2','admin2@example.com','scrypt:32768:8:1$eKZPq2Ci2s0GADtg$83ffac5d2fbf9fe023073501c8f5a777e1a9f8582047b6fdabd44f1fa443db99ce0b0a8223af36466f5a118fd903aba0c41d9bcf69b959b7a73d50dc021e93b8','Admin','User','A',NULL,NULL,NULL,1,'2024-11-20 19:33:08.112732',NULL,'2024-11-20 19:33:36.494747');
INSERT INTO "users" VALUES(3,'executor1','executor1@example.com','scrypt:32768:8:1$ZpNzKCcDouwUGXgp$7f88515617a0670415d56c7e618b865e03218b434254b8685a59b59b4e9b7f4f9a828c75f6dd367216d2f9327f4576ffaab326edc26376f751c153eedc92c5fb','Executor','E',NULL,NULL,NULL,'static/uploads/avatars/3_57.png',1,'2024-11-20 19:33:08.171388','','2024-11-22 07:33:53.565460');
CREATE UNIQUE INDEX ix_users_username ON users (username);
CREATE UNIQUE INDEX ix_users_email ON users (email);
CREATE INDEX ix_projects_title ON projects (title);
CREATE INDEX ix_posts_timestamp ON posts (timestamp);
CREATE INDEX ix_tasks_title ON tasks (title);
COMMIT;
