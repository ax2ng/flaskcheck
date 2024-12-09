DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Homebrew)
-- Dumped by pg_dump version 16.4 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: dubinkerus
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO dubinkerus;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: dubinkerus
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO dubinkerus;

--
-- Name: chat_messages; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.chat_messages (
    id integer NOT NULL,
    chat_room_id integer NOT NULL,
    user_id integer NOT NULL,
    content text,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.chat_messages OWNER TO dubinkerus;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.chat_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chat_messages_id_seq OWNER TO dubinkerus;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.chat_messages_id_seq OWNED BY public.chat_messages.id;


--
-- Name: chat_rooms; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.chat_rooms (
    id integer NOT NULL,
    project_id integer,
    task_id integer,
    created_at timestamp without time zone NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.chat_rooms OWNER TO dubinkerus;

--
-- Name: chat_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.chat_rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chat_rooms_id_seq OWNER TO dubinkerus;

--
-- Name: chat_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.chat_rooms_id_seq OWNED BY public.chat_rooms.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.files (
    id integer NOT NULL,
    user_id integer NOT NULL,
    project_id integer,
    task_id integer,
    chat_message_id integer,
    file_url character varying(255) NOT NULL,
    upload_time timestamp without time zone NOT NULL
);


ALTER TABLE public.files OWNER TO dubinkerus;

--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_id_seq OWNER TO dubinkerus;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    body character varying(140),
    "timestamp" timestamp without time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.posts OWNER TO dubinkerus;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO dubinkerus;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: priorities; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.priorities (
    id integer NOT NULL,
    level character varying(20) NOT NULL
);


ALTER TABLE public.priorities OWNER TO dubinkerus;

--
-- Name: priorities_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.priorities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.priorities_id_seq OWNER TO dubinkerus;

--
-- Name: priorities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.priorities_id_seq OWNED BY public.priorities.id;


--
-- Name: project_executors; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.project_executors (
    user_id integer NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE public.project_executors OWNER TO dubinkerus;

--
-- Name: project_statistics; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.project_statistics (
    id integer NOT NULL,
    project_id integer NOT NULL,
    tasks_total integer NOT NULL,
    tasks_completed integer NOT NULL,
    average_completion_time double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.project_statistics OWNER TO dubinkerus;

--
-- Name: project_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.project_statistics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_statistics_id_seq OWNER TO dubinkerus;

--
-- Name: project_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.project_statistics_id_seq OWNED BY public.project_statistics.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    title character varying(128) NOT NULL,
    description character varying(500),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    status_id integer NOT NULL,
    priority_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    manager_id integer NOT NULL,
    responsible_id integer,
    icon_color character varying(7)
);


ALTER TABLE public.projects OWNER TO dubinkerus;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO dubinkerus;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.roles OWNER TO dubinkerus;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO dubinkerus;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.statuses (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.statuses OWNER TO dubinkerus;

--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.statuses_id_seq OWNER TO dubinkerus;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: task_executors; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.task_executors (
    user_id integer NOT NULL,
    task_id integer NOT NULL
);


ALTER TABLE public.task_executors OWNER TO dubinkerus;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    title character varying(128) NOT NULL,
    description character varying(500),
    deadline timestamp without time zone,
    project_id integer,
    status_id integer,
    priority_id integer,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.tasks OWNER TO dubinkerus;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_id_seq OWNER TO dubinkerus;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.user_roles (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO dubinkerus;

--
-- Name: users; Type: TABLE; Schema: public; Owner: dubinkerus
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(64) NOT NULL,
    email character varying(120) NOT NULL,
    password_hash character varying(256) NOT NULL,
    first_name character varying(55),
    last_name character varying(55),
    middle_name character varying(55),
    phone_number character varying(55),
    date_birth date,
    avatar_url character varying(255),
    is_active boolean NOT NULL,
    creation_time timestamp without time zone NOT NULL,
    about_me character varying(140),
    last_seen timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO dubinkerus;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: dubinkerus
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO dubinkerus;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dubinkerus
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: chat_messages id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_messages ALTER COLUMN id SET DEFAULT nextval('public.chat_messages_id_seq'::regclass);


--
-- Name: chat_rooms id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_rooms ALTER COLUMN id SET DEFAULT nextval('public.chat_rooms_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: priorities id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.priorities ALTER COLUMN id SET DEFAULT nextval('public.priorities_id_seq'::regclass);


--
-- Name: project_statistics id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.project_statistics ALTER COLUMN id SET DEFAULT nextval('public.project_statistics_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.alembic_version (version_num) FROM stdin;
79e017802111
\.


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.chat_messages (id, chat_room_id, user_id, content, "timestamp") FROM stdin;
\.


--
-- Data for Name: chat_rooms; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.chat_rooms (id, project_id, task_id, created_at, type) FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.files (id, user_id, project_id, task_id, chat_message_id, file_url, upload_time) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.posts (id, body, "timestamp", user_id) FROM stdin;
\.


--
-- Data for Name: priorities; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.priorities (id, level) FROM stdin;
1	Низкий
2	Средний
3	Высокий
\.


--
-- Data for Name: project_executors; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.project_executors (user_id, project_id) FROM stdin;
14	77
\.


--
-- Data for Name: project_statistics; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.project_statistics (id, project_id, tasks_total, tasks_completed, average_completion_time, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.projects (id, title, description, start_date, end_date, status_id, priority_id, created_at, updated_at, manager_id, responsible_id, icon_color) FROM stdin;
77	Новый проектывфыв	Введите описание проекта	\N	\N	1	1	2024-12-10 01:09:05.254559	2024-12-10 01:52:43.439929	1	16	#879aa8
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.roles (id, name) FROM stdin;
1	admin
2	manager
3	responsible
6	executor
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.statuses (id, name) FROM stdin;
1	Не начато
2	В процессе
3	Выполнено
\.


--
-- Data for Name: task_executors; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.task_executors (user_id, task_id) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.tasks (id, title, description, deadline, project_id, status_id, priority_id, created_at) FROM stdin;
24	asdsad	asdasd	2222-12-31 00:00:00	77	2	2	2024-12-10 01:31:30.947668
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	1
14	6
12	3
11	2
16	6
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.users (id, username, email, password_hash, first_name, last_name, middle_name, phone_number, date_birth, avatar_url, is_active, creation_time, about_me, last_seen) FROM stdin;
16	executor2	executor2@gmail.com	scrypt:32768:8:1$KsglJRjm3uxQ1HBU$f7aec6c12bba3f0fa216160559a165eae524a71ad51035defd0ed79c45c4087c0e5f6972101ff098744717a2dfc03612c936ddcda30cbaf25f1c05e348cd2435	Исполнительт	2		9999999999	2221-12-13	\N	t	2024-12-10 01:01:00.215573	Исполнитель 2	2024-12-10 01:40:32.840263
14	executor	executor@gmail.com	scrypt:32768:8:1$YdqkWowevSgJIKsH$0fdf7eeadb5bdbf4dca30de8b37deebeb47c43b680ee2e47e106dc183571b1b4893abbee8a5879647b796ba8bfa9070d665ad173b7f35529768fbe44dfb40847	Исполнитель	Задач		+88888888888	\N	\N	t	2024-12-09 18:38:48.770153	Я исполняю задачи	2024-12-10 01:59:48.462815
11	manager	manager@gmail.com	scrypt:32768:8:1$a8yIG1KafXCAMsVE$a095bf866582823f42588e2f02c7704511817ace13af110e715eae129ec0b7155527c365a550ed9d6edbd8a308485f5ccbc1cc51f9f5c2bffbdf9d86c7b24889	Управляющий	Проектом		+123123123	2000-11-11	\N	t	2024-12-09 17:38:32.544588	Я управленец	2024-12-10 01:06:27.603963
12	responsible	responsible@gmail.com	scrypt:32768:8:1$yRGzTag2vUSb5jKZ$b20fafb1b88144cfabd561a32b610da83c2dd703adb87e72e87eb0a4ba580c26fe15ccc9bbba18b073e9c5aa54402bdda74d7b1302d2e5f05ab0e9e21c86841f	Ответственный	заПроект		+8888888888	2000-11-11	\N	t	2024-12-09 17:51:07.311209	Я ответственный за проект	2024-12-10 01:01:16.833101
1	admin	admin@example.com	scrypt:32768:8:1$nRpjgaKOLGmGOPuR$e500bf763a106ce9278328655cd3fe9602403de705961c14f93578f83a61bacf6fcede60d8d2c7ad03f86c28d05a8882af8f578f01f80cfd6d26720d778f3fa1	Администратор	Системы	A	8888888888	2000-11-11	\N	t	2024-11-22 12:14:42.246927	Я администрирую ЭТО	2024-12-10 02:01:25.368163
\.


--
-- Name: chat_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.chat_messages_id_seq', 18, true);


--
-- Name: chat_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.chat_rooms_id_seq', 3, true);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.files_id_seq', 10, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.posts_id_seq', 1, false);


--
-- Name: priorities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.priorities_id_seq', 6, true);


--
-- Name: project_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.project_statistics_id_seq', 2, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.projects_id_seq', 77, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.roles_id_seq', 6, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.statuses_id_seq', 4, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.tasks_id_seq', 24, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: chat_messages chat_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);


--
-- Name: chat_rooms chat_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_rooms
    ADD CONSTRAINT chat_rooms_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: priorities priorities_level_key; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.priorities
    ADD CONSTRAINT priorities_level_key UNIQUE (level);


--
-- Name: priorities priorities_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.priorities
    ADD CONSTRAINT priorities_pkey PRIMARY KEY (id);


--
-- Name: project_executors project_executors_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.project_executors
    ADD CONSTRAINT project_executors_pkey PRIMARY KEY (user_id, project_id);


--
-- Name: project_statistics project_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.project_statistics
    ADD CONSTRAINT project_statistics_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_name_key; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_name_key UNIQUE (name);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: task_executors task_executors_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.task_executors
    ADD CONSTRAINT task_executors_pkey PRIMARY KEY (user_id, task_id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: users users_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_number_key UNIQUE (phone_number);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_posts_timestamp; Type: INDEX; Schema: public; Owner: dubinkerus
--

CREATE INDEX ix_posts_timestamp ON public.posts USING btree ("timestamp");


--
-- Name: ix_projects_title; Type: INDEX; Schema: public; Owner: dubinkerus
--

CREATE INDEX ix_projects_title ON public.projects USING btree (title);


--
-- Name: ix_tasks_title; Type: INDEX; Schema: public; Owner: dubinkerus
--

CREATE INDEX ix_tasks_title ON public.tasks USING btree (title);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: dubinkerus
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_username; Type: INDEX; Schema: public; Owner: dubinkerus
--

CREATE UNIQUE INDEX ix_users_username ON public.users USING btree (username);


--
-- Name: chat_messages chat_messages_chat_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_chat_room_id_fkey FOREIGN KEY (chat_room_id) REFERENCES public.chat_rooms(id) ON DELETE CASCADE;


--
-- Name: chat_messages chat_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: chat_rooms chat_rooms_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_rooms
    ADD CONSTRAINT chat_rooms_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: chat_rooms chat_rooms_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_rooms
    ADD CONSTRAINT chat_rooms_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: files files_chat_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_chat_message_id_fkey FOREIGN KEY (chat_message_id) REFERENCES public.chat_messages(id);


--
-- Name: files files_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: files files_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: files files_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: project_executors project_executors_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.project_executors
    ADD CONSTRAINT project_executors_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: project_executors project_executors_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.project_executors
    ADD CONSTRAINT project_executors_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: project_statistics project_statistics_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.project_statistics
    ADD CONSTRAINT project_statistics_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: projects projects_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(id);


--
-- Name: projects projects_priority_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_priority_id_fkey FOREIGN KEY (priority_id) REFERENCES public.priorities(id);


--
-- Name: projects projects_responsible_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_responsible_id_fkey FOREIGN KEY (responsible_id) REFERENCES public.users(id);


--
-- Name: projects projects_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.statuses(id);


--
-- Name: task_executors task_executors_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.task_executors
    ADD CONSTRAINT task_executors_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: task_executors task_executors_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.task_executors
    ADD CONSTRAINT task_executors_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_priority_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_priority_id_fkey FOREIGN KEY (priority_id) REFERENCES public.priorities(id);


--
-- Name: tasks tasks_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: tasks tasks_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.statuses(id);


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: dubinkerus
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

