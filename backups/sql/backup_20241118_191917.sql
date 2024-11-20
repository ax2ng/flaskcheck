BEGIN TRANSACTION;
CREATE TABLE alembic_version (
	version_num VARCHAR(32) NOT NULL, 
	CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
INSERT INTO "alembic_version" VALUES('1ca9f9d6e17a');
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
INSERT INTO "chat_messages" VALUES(1,1,3,'Message 1 in project 1','2024-11-14 13:16:28.288133');
INSERT INTO "chat_messages" VALUES(2,1,3,'Message 2 in project 1','2024-11-14 13:16:28.288215');
INSERT INTO "chat_messages" VALUES(3,1,1,'Message 3 in project 1','2024-11-14 13:16:28.288272');
INSERT INTO "chat_messages" VALUES(4,1,2,'Message 4 in project 1','2024-11-14 13:16:28.288291');
INSERT INTO "chat_messages" VALUES(5,1,1,'Message 5 in project 1','2024-11-14 13:16:28.288305');
INSERT INTO "chat_messages" VALUES(6,2,1,'Message 1 in project 2','2024-11-14 13:16:28.289086');
INSERT INTO "chat_messages" VALUES(7,2,1,'Message 2 in project 2','2024-11-14 13:16:28.289119');
INSERT INTO "chat_messages" VALUES(8,2,3,'Message 3 in project 2','2024-11-14 13:16:28.289134');
INSERT INTO "chat_messages" VALUES(9,2,1,'Message 4 in project 2','2024-11-14 13:16:28.289148');
INSERT INTO "chat_messages" VALUES(10,2,1,'Message 5 in project 2','2024-11-14 13:16:28.289160');
INSERT INTO "chat_messages" VALUES(11,3,3,'Message 1 in project 3','2024-11-14 13:16:28.289552');
INSERT INTO "chat_messages" VALUES(12,3,1,'Message 2 in project 3','2024-11-14 13:16:28.289576');
INSERT INTO "chat_messages" VALUES(13,3,2,'Message 3 in project 3','2024-11-14 13:16:28.289590');
INSERT INTO "chat_messages" VALUES(14,3,1,'Message 4 in project 3','2024-11-14 13:16:28.289604');
INSERT INTO "chat_messages" VALUES(15,3,1,'Message 5 in project 3','2024-11-14 13:16:28.289617');
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
INSERT INTO "chat_rooms" VALUES(1,1,NULL,'2024-11-14 13:16:28.287921','project');
INSERT INTO "chat_rooms" VALUES(2,2,NULL,'2024-11-14 13:16:28.288517','project');
INSERT INTO "chat_rooms" VALUES(3,3,NULL,'2024-11-14 13:16:28.289324','project');
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
INSERT INTO "files" VALUES(1,3,2,NULL,NULL,'https://example.com/file1.txt','2024-11-14 13:16:28.290177');
INSERT INTO "files" VALUES(2,1,2,NULL,NULL,'https://example.com/file2.txt','2024-11-14 13:16:28.290206');
INSERT INTO "files" VALUES(3,3,2,NULL,NULL,'https://example.com/file3.txt','2024-11-14 13:16:28.290218');
INSERT INTO "files" VALUES(4,3,2,NULL,NULL,'https://example.com/file4.txt','2024-11-14 13:16:28.290227');
INSERT INTO "files" VALUES(5,2,3,NULL,NULL,'https://example.com/file5.txt','2024-11-14 13:16:28.290236');
INSERT INTO "files" VALUES(6,2,2,NULL,NULL,'https://example.com/file6.txt','2024-11-14 13:16:28.290245');
INSERT INTO "files" VALUES(7,2,1,NULL,NULL,'https://example.com/file7.txt','2024-11-14 13:16:28.290254');
INSERT INTO "files" VALUES(8,1,3,NULL,NULL,'https://example.com/file8.txt','2024-11-14 13:16:28.290262');
INSERT INTO "files" VALUES(9,3,1,NULL,NULL,'https://example.com/file9.txt','2024-11-14 13:16:28.290271');
INSERT INTO "files" VALUES(10,2,3,NULL,NULL,'https://example.com/file10.txt','2024-11-14 13:16:28.290279');
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
INSERT INTO "projects" VALUES(1,'Project 1','Description of Project 1','2024-11-14 13:16:28.285017','2024-12-14 13:16:28.285020',3,3,'2024-11-14 13:16:28.285660','2024-11-14 13:16:28.285662',1,2);
INSERT INTO "projects" VALUES(2,'Project 2','Description of Project 2','2024-11-14 13:16:28.285097','2024-12-14 13:16:28.285098',2,1,'2024-11-14 13:16:28.285663','2024-11-14 13:16:28.285663',1,2);
INSERT INTO "projects" VALUES(3,'Project 3','Description of Project 3','2024-11-14 13:16:28.285123','2024-12-14 13:16:28.285123',1,2,'2024-11-14 13:16:28.285664','2024-11-14 13:16:28.285664',1,2);
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
INSERT INTO "tasks" VALUES(1,'NS','sad','1323-12-31 00:00:00.000000',NULL,3,1,'2024-11-18 10:06:26.213223');
INSERT INTO "tasks" VALUES(2,'PG','asdsad','0013-02-13 00:00:00.000000',NULL,3,1,'2024-11-18 10:06:38.326197');
INSERT INTO "tasks" VALUES(3,'CP','asdasd','2312-12-31 00:00:00.000000',NULL,1,1,'2024-11-18 10:06:49.012902');
INSERT INTO "tasks" VALUES(4,'TEST','sadasd','2312-12-31 00:00:00.000000',NULL,1,2,'2024-11-18 10:12:51.142644');
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
	is_active BOOLEAN NOT NULL, 
	creation_time DATETIME NOT NULL, 
	about_me VARCHAR(140), 
	last_seen DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (phone_number)
);
INSERT INTO "users" VALUES(1,'admin','admin@example.com','scrypt:32768:8:1$EYbHcdkFKffeaAMT$5ba15700b730721178c2093174d3e5610b7eb5caaa50256f18b2a2d9ed6e1e422496c36da3514c5ab6df48cb67114d25fc29cbd548eee4336707c8e03d04dad9','Admin','User','A',NULL,NULL,1,'2024-11-14 13:16:28.152697',NULL,'2024-11-18 16:19:17.485500');
INSERT INTO "users" VALUES(2,'admin2','admin2@example.com','scrypt:32768:8:1$MgOj1QH2mtgiYn9q$e6deeadfa2ca549a5bb32ee3c48098631fb39eaf3d9ec74faac890f36187a08312975c72680053ee7ef947cb83fa150d73e2e61344b6517aae169dba03ad10e5','Admin','User','A',NULL,NULL,1,'2024-11-14 13:16:28.211777',NULL,'2024-11-18 10:12:52.252468');
INSERT INTO "users" VALUES(3,'executor1','executor1@example.com','scrypt:32768:8:1$yyOohhxWBHy3mWph$48de1bd18508fa8029a75ee1f85c1f80c5e6d373956ccd45ac6484a7f10f9e0c177a87d7c3ef6b31b17953a2d3132731c852f670dbc6a948745dd2526bfbfdc2','Executor','E',NULL,NULL,NULL,1,'2024-11-14 13:16:28.281706','Исполнитель','2024-11-18 16:19:01.085927');
CREATE UNIQUE INDEX ix_users_username ON users (username);
CREATE UNIQUE INDEX ix_users_email ON users (email);
CREATE INDEX ix_projects_title ON projects (title);
CREATE INDEX ix_posts_timestamp ON posts (timestamp);
CREATE INDEX ix_tasks_title ON tasks (title);
COMMIT;
