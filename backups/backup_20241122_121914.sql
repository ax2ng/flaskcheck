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
    description character varying(500) NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    status_id integer NOT NULL,
    priority_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    manager_id integer NOT NULL,
    responsible_id integer
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
6fa96a6659be
\.


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.chat_messages (id, chat_room_id, user_id, content, "timestamp") FROM stdin;
1	1	1	Message 1 in project 1	2024-11-22 12:14:42.432604
2	1	1	Message 2 in project 1	2024-11-22 12:14:42.432652
3	1	3	Message 3 in project 1	2024-11-22 12:14:42.432671
4	1	1	Message 4 in project 1	2024-11-22 12:14:42.432686
5	1	1	Message 5 in project 1	2024-11-22 12:14:42.432701
6	2	2	Message 1 in project 2	2024-11-22 12:14:42.434533
7	2	2	Message 2 in project 2	2024-11-22 12:14:42.434562
8	2	3	Message 3 in project 2	2024-11-22 12:14:42.434579
9	2	3	Message 4 in project 2	2024-11-22 12:14:42.434593
10	2	1	Message 5 in project 2	2024-11-22 12:14:42.434605
11	3	2	Message 1 in project 3	2024-11-22 12:14:42.435705
12	3	2	Message 2 in project 3	2024-11-22 12:14:42.435733
13	3	1	Message 3 in project 3	2024-11-22 12:14:42.435749
14	3	3	Message 4 in project 3	2024-11-22 12:14:42.435762
15	3	2	Message 5 in project 3	2024-11-22 12:14:42.435775
\.


--
-- Data for Name: chat_rooms; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.chat_rooms (id, project_id, task_id, created_at, type) FROM stdin;
1	1	\N	2024-11-22 12:14:42.431714	project
2	2	\N	2024-11-22 12:14:42.432988	project
3	3	\N	2024-11-22 12:14:42.434772	project
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.files (id, user_id, project_id, task_id, chat_message_id, file_url, upload_time) FROM stdin;
1	3	1	\N	\N	https://example.com/file1.txt	2024-11-22 12:14:42.441737
2	1	1	\N	\N	https://example.com/file2.txt	2024-11-22 12:14:42.44178
3	2	3	\N	\N	https://example.com/file3.txt	2024-11-22 12:14:42.441794
4	3	3	\N	\N	https://example.com/file4.txt	2024-11-22 12:14:42.441803
5	2	1	\N	\N	https://example.com/file5.txt	2024-11-22 12:14:42.441813
6	2	2	\N	\N	https://example.com/file6.txt	2024-11-22 12:14:42.441821
7	3	1	\N	\N	https://example.com/file7.txt	2024-11-22 12:14:42.44183
8	3	1	\N	\N	https://example.com/file8.txt	2024-11-22 12:14:42.441838
9	3	3	\N	\N	https://example.com/file9.txt	2024-11-22 12:14:42.441847
10	1	3	\N	\N	https://example.com/file10.txt	2024-11-22 12:14:42.441856
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
1	Low
2	Medium
3	High
\.


--
-- Data for Name: project_executors; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.project_executors (user_id, project_id) FROM stdin;
\.


--
-- Data for Name: project_statistics; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.project_statistics (id, project_id, tasks_total, tasks_completed, average_completion_time, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.projects (id, title, description, start_date, end_date, status_id, priority_id, created_at, updated_at, manager_id, responsible_id) FROM stdin;
1	Project 1	Description of Project 1	2024-11-22 12:14:42.422923	2024-12-22 12:14:42.42293	2	3	2024-11-22 12:14:42.424478	2024-11-22 12:14:42.424483	1	2
2	Project 2	Description of Project 2	2024-11-22 12:14:42.423095	2024-12-22 12:14:42.423098	1	1	2024-11-22 12:14:42.424485	2024-11-22 12:14:42.424486	1	2
3	Project 3	Description of Project 3	2024-11-22 12:14:42.423152	2024-12-22 12:14:42.423153	1	2	2024-11-22 12:14:42.424487	2024-11-22 12:14:42.424488	1	2
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.roles (id, name) FROM stdin;
1	admin
2	manager
3	responsible
4	executor
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.statuses (id, name) FROM stdin;
1	Not Started
2	In Progress
3	Completed
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
1	Task 1	Description of Task 1	2024-12-08 12:14:42.427362	1	3	1	2024-11-22 12:14:42.428153
2	Task 2	Description of Task 2	2024-12-02 12:14:42.427434	3	3	2	2024-11-22 12:14:42.428155
3	Task 3	Description of Task 3	2024-11-30 12:14:42.427455	1	2	2	2024-11-22 12:14:42.428156
4	Task 4	Description of Task 4	2024-12-06 12:14:42.427469	2	2	2	2024-11-22 12:14:42.428156
5	Task 5	Description of Task 5	2024-11-30 12:14:42.427483	2	1	1	2024-11-22 12:14:42.428156
6	Task 6	Description of Task 6	2024-12-03 12:14:42.427497	1	2	3	2024-11-22 12:14:42.428157
7	Task 7	Description of Task 7	2024-11-27 12:14:42.427511	3	3	1	2024-11-22 12:14:42.428157
8	Task 8	Description of Task 8	2024-12-12 12:14:42.427524	1	2	3	2024-11-22 12:14:42.428158
9	Task 9	Description of Task 9	2024-12-10 12:14:42.427537	3	1	1	2024-11-22 12:14:42.428158
10	Task 10	Description of Task 10	2024-12-10 12:14:42.42755	1	2	3	2024-11-22 12:14:42.428158
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	1
2	1
3	4
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.users (id, username, email, password_hash, first_name, last_name, middle_name, phone_number, date_birth, avatar_url, is_active, creation_time, about_me, last_seen) FROM stdin;
2	admin2	admin2@example.com	scrypt:32768:8:1$80bCug4nw3VcMDbZ$51796f80192f6df86080e25f2197ef3365d2bcebfae8455856537bcf89759315a940c10635a76f3e0d2a145de26bb0b20435be06882df0d53869e3695a0ca5c8	Admin	User	A	\N	\N	\N	t	2024-11-22 12:14:42.321909	\N	2024-11-22 12:14:42.321913
3	executor1	executor1@example.com	scrypt:32768:8:1$zAunqq0KC24e1tHI$d631ff0ed110fbe762ac6d1f2c4f46d3494415f69c95ef7c4ff34b4527476f160263ebd2b5a8783f97f1cecbb40d6a7b2d39dc075e2e040cc4df3194abab3a29	Executor	E	\N	\N	\N	\N	t	2024-11-22 12:14:42.382135	\N	2024-11-22 12:14:42.382138
1	admin	admin@example.com	scrypt:32768:8:1$nRpjgaKOLGmGOPuR$e500bf763a106ce9278328655cd3fe9602403de705961c14f93578f83a61bacf6fcede60d8d2c7ad03f86c28d05a8882af8f578f01f80cfd6d26720d778f3fa1	Admin	User	A	\N	\N	\N	t	2024-11-22 12:14:42.246927	\N	2024-11-22 12:19:14.393467
\.


--
-- Name: chat_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.chat_messages_id_seq', 15, true);


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

SELECT pg_catalog.setval('public.priorities_id_seq', 3, true);


--
-- Name: project_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.project_statistics_id_seq', 1, false);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.projects_id_seq', 3, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.roles_id_seq', 4, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.statuses_id_seq', 3, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.tasks_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


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
    ADD CONSTRAINT chat_messages_chat_room_id_fkey FOREIGN KEY (chat_room_id) REFERENCES public.chat_rooms(id);


--
-- Name: chat_messages chat_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_messages
    ADD CONSTRAINT chat_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: chat_rooms chat_rooms_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.chat_rooms
    ADD CONSTRAINT chat_rooms_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);


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
    ADD CONSTRAINT files_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);


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
    ADD CONSTRAINT project_executors_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_executors project_executors_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dubinkerus
--

ALTER TABLE ONLY public.project_executors
    ADD CONSTRAINT project_executors_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- PostgreSQL database dump complete
--

