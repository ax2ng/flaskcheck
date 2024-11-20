BEGIN TRANSACTION;
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
INSERT INTO "chat_messages" VALUES(1,1,2,'Message 1 in project 1','2024-11-13 11:13:49.270738');
INSERT INTO "chat_messages" VALUES(2,1,1,'Message 2 in project 1','2024-11-13 11:13:49.270770');
INSERT INTO "chat_messages" VALUES(3,1,2,'Message 3 in project 1','2024-11-13 11:13:49.270787');
INSERT INTO "chat_messages" VALUES(4,1,1,'Message 4 in project 1','2024-11-13 11:13:49.270801');
INSERT INTO "chat_messages" VALUES(5,1,3,'Message 5 in project 1','2024-11-13 11:13:49.270812');
INSERT INTO "chat_messages" VALUES(6,2,3,'Message 1 in project 2','2024-11-13 11:13:49.271408');
INSERT INTO "chat_messages" VALUES(7,2,3,'Message 2 in project 2','2024-11-13 11:13:49.271432');
INSERT INTO "chat_messages" VALUES(8,2,3,'Message 3 in project 2','2024-11-13 11:13:49.271445');
INSERT INTO "chat_messages" VALUES(9,2,1,'Message 4 in project 2','2024-11-13 11:13:49.271457');
INSERT INTO "chat_messages" VALUES(10,2,2,'Message 5 in project 2','2024-11-13 11:13:49.271469');
INSERT INTO "chat_messages" VALUES(11,3,2,'Message 1 in project 3','2024-11-13 11:13:49.271814');
INSERT INTO "chat_messages" VALUES(12,3,2,'Message 2 in project 3','2024-11-13 11:13:49.271834');
INSERT INTO "chat_messages" VALUES(13,3,2,'Message 3 in project 3','2024-11-13 11:13:49.271847');
INSERT INTO "chat_messages" VALUES(14,3,2,'Message 4 in project 3','2024-11-13 11:13:49.271859');
INSERT INTO "chat_messages" VALUES(15,3,3,'Message 5 in project 3','2024-11-13 11:13:49.271871');
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
INSERT INTO "chat_rooms" VALUES(1,1,NULL,'2024-11-13 11:13:49.270548','project');
INSERT INTO "chat_rooms" VALUES(2,2,NULL,'2024-11-13 11:13:49.270980','project');
INSERT INTO "chat_rooms" VALUES(3,3,NULL,'2024-11-13 11:13:49.271614','project');
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
INSERT INTO "files" VALUES(1,1,2,NULL,NULL,'https://example.com/file1.txt','2024-11-13 11:13:49.272348');
INSERT INTO "files" VALUES(2,1,3,NULL,NULL,'https://example.com/file2.txt','2024-11-13 11:13:49.272374');
INSERT INTO "files" VALUES(3,2,3,NULL,NULL,'https://example.com/file3.txt','2024-11-13 11:13:49.272386');
INSERT INTO "files" VALUES(4,2,2,NULL,NULL,'https://example.com/file4.txt','2024-11-13 11:13:49.272395');
INSERT INTO "files" VALUES(5,2,2,NULL,NULL,'https://example.com/file5.txt','2024-11-13 11:13:49.272404');
INSERT INTO "files" VALUES(6,2,3,NULL,NULL,'https://example.com/file6.txt','2024-11-13 11:13:49.272412');
INSERT INTO "files" VALUES(7,2,3,NULL,NULL,'https://example.com/file7.txt','2024-11-13 11:13:49.272421');
INSERT INTO "files" VALUES(8,3,1,NULL,NULL,'https://example.com/file8.txt','2024-11-13 11:13:49.272429');
INSERT INTO "files" VALUES(9,1,3,NULL,NULL,'https://example.com/file9.txt','2024-11-13 11:13:49.272437');
INSERT INTO "files" VALUES(10,1,3,NULL,NULL,'https://example.com/file10.txt','2024-11-13 11:13:49.272445');
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
	responsible_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(status_id) REFERENCES statuses (id), 
	FOREIGN KEY(priority_id) REFERENCES priorities (id), 
	FOREIGN KEY(manager_id) REFERENCES users (id), 
	FOREIGN KEY(responsible_id) REFERENCES users (id)
);
INSERT INTO "projects" VALUES(1,'Project 1','Description of Project 1','2024-11-13 11:13:49.268002','2024-12-13 11:13:49.268004',1,3,'2024-11-13 11:13:49.268472','2024-11-13 11:13:49.268473',1,2);
INSERT INTO "projects" VALUES(2,'Project 2','Description of Project 2','2024-11-13 11:13:49.268056','2024-12-13 11:13:49.268057',3,3,'2024-11-13 11:13:49.268474','2024-11-13 11:13:49.268474',1,2);
INSERT INTO "projects" VALUES(3,'Project 3','Description of Project 3','2024-11-13 11:13:49.268076','2024-12-13 11:13:49.268076',1,2,'2024-11-13 11:13:49.268475','2024-11-13 11:13:49.268475',1,2);
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
INSERT INTO "tasks" VALUES(1,'Task 1','Description of Task 1','2024-11-25 11:13:49.269068',1,2,2,'2024-11-13 11:13:49.269683');
INSERT INTO "tasks" VALUES(2,'Task 2','Description of Task 2','2024-11-30 11:13:49.269112',2,2,1,'2024-11-13 11:13:49.269684');
INSERT INTO "tasks" VALUES(3,'Task 3','Description of Task 3','2024-12-03 11:13:49.269130',1,2,2,'2024-11-13 11:13:49.269684');
INSERT INTO "tasks" VALUES(4,'Task 4','Description of Task 4','2024-11-24 11:13:49.269143',2,1,2,'2024-11-13 11:13:49.269685');
INSERT INTO "tasks" VALUES(5,'Task 5','Description of Task 5','2024-11-25 11:13:49.269156',2,3,2,'2024-11-13 11:13:49.269685');
INSERT INTO "tasks" VALUES(6,'Task 6','Description of Task 6','2024-12-03 11:13:49.269168',3,2,3,'2024-11-13 11:13:49.269685');
INSERT INTO "tasks" VALUES(7,'Task 7','Description of Task 7','2024-12-02 11:13:49.269180',3,1,1,'2024-11-13 11:13:49.269686');
INSERT INTO "tasks" VALUES(8,'Task 8','Description of Task 8','2024-11-24 11:13:49.269192',1,1,1,'2024-11-13 11:13:49.269686');
INSERT INTO "tasks" VALUES(9,'Task 9','Description of Task 9','2024-12-03 11:13:49.269204',1,1,3,'2024-11-13 11:13:49.269686');
INSERT INTO "tasks" VALUES(10,'Task 10','Description of Task 10','2024-11-23 11:13:49.269216',2,2,3,'2024-11-13 11:13:49.269687');
CREATE TABLE user_roles (
	user_id INTEGER NOT NULL, 
	role_id INTEGER NOT NULL, 
	PRIMARY KEY (user_id, role_id), 
	FOREIGN KEY(user_id) REFERENCES users (id), 
	FOREIGN KEY(role_id) REFERENCES roles (id)
);
INSERT INTO "user_roles" VALUES(1,1);
INSERT INTO "user_roles" VALUES(2,2);
INSERT INTO "user_roles" VALUES(3,4);
CREATE TABLE users (
	id INTEGER NOT NULL, 
	username VARCHAR(64) NOT NULL, 
	email VARCHAR(120) NOT NULL, 
	password_hash VARCHAR(256) NOT NULL, 
	first_name VARCHAR(55) NOT NULL, 
	last_name VARCHAR(55) NOT NULL, 
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
INSERT INTO "users" VALUES(1,'admin','admin@example.com','scrypt:32768:8:1$YrEv2w6Gsy4cdnnf$f731b4a232b45d1e900a185db66a748f33a5fd11c499a5d99360dbe6cc4e2b7a80d707bd06cabfa33fc49d071be419c5cf02091ec22d676d2f0ab6fd9d1e70dd','Admin','User','A',NULL,NULL,1,'2024-11-13 11:13:49.133446',NULL,'2024-11-14 09:42:12.451412');
INSERT INTO "users" VALUES(2,'manager1','manager1@example.com','scrypt:32768:8:1$FrzMSCjFswxxF8LL$71682f6f6d7ef630706cd03c86ab62ee5bd8f5fe2aa0965fa558734ab6466395406af629166907e8413a64b88a5940915f707bb1676b7434b42b87abdcfe4b64','Manager','One','M',NULL,NULL,1,'2024-11-13 11:13:49.204120',NULL,'2024-11-13 11:43:51.839965');
INSERT INTO "users" VALUES(3,'executor1','executor1@example.com','scrypt:32768:8:1$Mmo3XHXYDukCar84$3c3a24ce4b021dc053869978fd6159c37ea0e807c9bde26e8a4e62907d6d6a8b2d671cd549c7bd04e6f34eac984d05237f2c41689db1ac724631b88efd2350a0','Executor','E',NULL,NULL,NULL,1,'2024-11-13 11:13:49.264818',NULL,'2024-11-13 11:13:49.264822');
CREATE UNIQUE INDEX ix_users_username ON users (username);
CREATE UNIQUE INDEX ix_users_email ON users (email);
CREATE INDEX ix_projects_title ON projects (title);
CREATE INDEX ix_posts_timestamp ON posts (timestamp);
CREATE INDEX ix_tasks_title ON tasks (title);
COMMIT;
