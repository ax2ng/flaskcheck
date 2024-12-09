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
4977a08156d5
\.


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.chat_messages (id, chat_room_id, user_id, content, "timestamp") FROM stdin;
1	1	1	Message 1 in project 1	2024-11-22 12:14:42.432604
2	1	1	Message 2 in project 1	2024-11-22 12:14:42.432652
17	1	2	asdadsa	2024-12-05 15:36:59.890749
18	1	1	asdasd	2024-12-05 15:37:07.756195
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
1	Низкий
2	Средний
3	Высокий
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
2	2	11	10	1	2024-12-05 15:01:24.537311	2024-12-05 15:01:24.535069
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.projects (id, title, description, start_date, end_date, status_id, priority_id, created_at, updated_at, manager_id, responsible_id, icon_color) FROM stdin;
2	Project 2	Description of Project 2	2024-11-22 12:14:42.423095	2024-12-22 12:14:42.423098	1	1	2024-11-22 12:14:42.424485	2024-11-22 12:14:42.424486	1	2	\N
58	Новый проект	\N	\N	\N	1	1	2024-12-03 08:46:56.88547	2024-12-03 08:46:56.885482	3	3	#9f7d8e
1	Project 1	Описание проекта	2024-11-22 12:14:42.422923	2024-12-22 12:14:42.42293	2	3	2024-11-22 12:14:42.424478	2024-12-03 08:47:28.949418	1	2	\N
3	Project 3	Привет как делаasdasdasds	2024-11-22 12:14:42.423152	2024-12-22 12:14:42.423153	1	1	2024-11-22 12:14:42.424487	2024-12-07 13:34:27.49623	1	2	\N
65	Новый проект	\N	\N	\N	1	1	2024-12-07 13:37:02.822144	2024-12-07 13:48:59.861592	1	1	#28969f
66	Новый проект	\N	\N	\N	1	1	2024-12-07 14:03:38.925093	2024-12-07 14:03:38.925108	1	1	#9472c7
67	Новый проект	\N	\N	\N	1	1	2024-12-07 14:17:36.809666	2024-12-07 14:17:36.809678	1	1	#a00751
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
3	Задача 1	Description of Task 3	0023-02-13 00:00:00	1	3	2	2024-11-22 12:14:42.428156
1	Задача 3	Description of Task 1	0123-02-13 00:00:00	1	3	1	2024-11-22 12:14:42.428153
13	Задача 6	asd	0002-02-13 00:00:00	\N	1	2	2024-11-25 19:11:03.721399
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.user_roles (user_id, role_id) FROM stdin;
1	1
2	1
10	6
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dubinkerus
--

COPY public.users (id, username, email, password_hash, first_name, last_name, middle_name, phone_number, date_birth, avatar_url, is_active, creation_time, about_me, last_seen) FROM stdin;
2	admin2	admin2@example.com	scrypt:32768:8:1$80bCug4nw3VcMDbZ$51796f80192f6df86080e25f2197ef3365d2bcebfae8455856537bcf89759315a940c10635a76f3e0d2a145de26bb0b20435be06882df0d53869e3695a0ca5c8	Admin	User	A	\N	\N	\N	t	2024-11-22 12:14:42.321909	\N	2024-11-22 12:14:42.321913
9	фыфыв	ыфвфыв@gmail.com	scrypt:32768:8:1$56mDhegIWcKq2TSx$f2716c0281f48ea8f417e5d3c9fe76a00c139b215a56406a99ff98c7c16b703ace3d6f1cf4a3064b286e2ced8fde66d5a531c48d077464fb8b57c3bf56420e00	\N	\N	\N	\N	\N	\N	t	2024-12-06 20:44:28.874076	\N	2024-12-06 20:45:02.08378
10	asdasdas	asdasdsds@gmail.com	scrypt:32768:8:1$JIsv0idxBaWWGinj$a7dd22a3843e0ce118186bc989912a4a8fc7af96739daf0673c7d82dce9cace3d3f562201f8b76466635456980a02ebd39fdad8c71c52bb793ca41a1640035a7	\N	\N	\N	\N	\N	\N	t	2024-12-06 21:44:12.497896	\N	2024-12-06 21:50:11.790467
3	executor1	executor1@example.com	scrypt:32768:8:1$zAunqq0KC24e1tHI$d631ff0ed110fbe762ac6d1f2c4f46d3494415f69c95ef7c4ff34b4527476f160263ebd2b5a8783f97f1cecbb40d6a7b2d39dc075e2e040cc4df3194abab3a29	Никитаа	\N	\N	+3123123123	0023-02-13	static/uploads/avatars/3_57.png	t	2024-11-22 12:14:42.382135	Начальник завода	2024-12-06 21:17:43.011873
7	test	test@gmail.com	scrypt:32768:8:1$gXfcUmdP9cIrCyw4$0707b5629d920aac93ca7cbc7f27678bf7a91c8637d657f6af75b328740ba10d91eb4d66e87dbfb1b73e710db3697812d2784783667d24215489ffd167bd913f	dsadasd	sadasdasd	\N	\N	\N	static/uploads/avatars/7_57.png	t	2024-12-06 18:47:48.646732	\N	2024-12-06 19:03:35.661908
8	фывыфв	asdasd@gmail.com	scrypt:32768:8:1$uzSn6vOm3Vptmeh3$2ef5722025bfde42049199b4fde371bf01193c756befbcd7af2c61e6e2604bb7b18461f7da7a1b633bbc92af32c85f564cff6bc51de68748e612491fd58482ea	\N	\N	\N	\N	\N	\N	t	2024-12-06 20:41:24.395187	\N	2024-12-06 20:41:24.395191
6	asdasd	asdas@gmail.com	scrypt:32768:8:1$gOK9RZz5P4fZKvrX$6ed4a67cd48622684257992ce819b01f81c04ad57b2d110bb8e003de97876627f35363ebada6e82a456d943ff29fc41f2df75d6523d7c025fa9a86d44f603181	asdasdas	asd	asdasd	123123123	3222-12-31	\N	f	2024-12-06 17:14:08.938556	asdasdas	2024-12-06 17:14:08.938561
1	admin	admin@example.com	scrypt:32768:8:1$nRpjgaKOLGmGOPuR$e500bf763a106ce9278328655cd3fe9602403de705961c14f93578f83a61bacf6fcede60d8d2c7ad03f86c28d05a8882af8f578f01f80cfd6d26720d778f3fa1	Админ	Админыч	A	\N	\N	\N	t	2024-11-22 12:14:42.246927	\N	2024-12-07 14:19:15.422839
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

SELECT pg_catalog.setval('public.projects_id_seq', 67, true);


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

SELECT pg_catalog.setval('public.tasks_id_seq', 20, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dubinkerus
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


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
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: dubinkerus
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

