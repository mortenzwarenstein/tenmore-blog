DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.8 (Debian 13.8-1.pgdg110+1)
-- Dumped by pg_dump version 13.8 (Debian 13.8-1.pgdg110+1)

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
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO directus;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO directus;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO directus;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: directus
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.contacts (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    email character varying(255) NOT NULL
);


ALTER TABLE public.contacts OWNER TO directus;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(30) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(30) DEFAULT 'bookmark_outline'::character varying NOT NULL,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255),
    share uuid,
    origin character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(50) DEFAULT NULL::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    translation_strings json,
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64),
    item character varying(255),
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.posts (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    excerpt text,
    content text
);


ALTER TABLE public.posts OWNER TO directus;

--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.contacts (id, date_created, email) FROM stdin;
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment, origin) FROM stdin;
1	login	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:36:13.278+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_users	a6a6909b-9337-4cd9-ba52-8e039912b11c	\N	http://localhost:8055
2	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:36:39.358+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	1	\N	http://localhost:8055
3	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:36:39.363+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	2	\N	http://localhost:8055
4	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:36:39.366+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	3	\N	http://localhost:8055
5	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:36:39.371+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	4	\N	http://localhost:8055
6	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:36:39.375+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_collections	posts	\N	http://localhost:8055
7	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:36:49.796+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	5	\N	http://localhost:8055
8	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:00.311+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	6	\N	http://localhost:8055
9	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:10.544+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	7	\N	http://localhost:8055
10	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:29.99+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	8	\N	http://localhost:8055
11	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:29.995+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	9	\N	http://localhost:8055
12	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:29.999+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_collections	contacts	\N	http://localhost:8055
13	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:37.778+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_fields	10	\N	http://localhost:8055
14	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:49.878+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_permissions	1	\N	http://localhost:8055
15	update	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:51.458+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_permissions	1	\N	http://localhost:8055
16	create	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:37:57.968+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_permissions	2	\N	http://localhost:8055
17	update	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-01-27 21:38:07.771+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	directus_permissions	2	\N	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse) FROM stdin;
posts	\N	\N	\N	f	f	\N	status	t	archived	draft	\N	all	\N	\N	\N	\N	open
contacts	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
1	posts	id	uuid	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
2	posts	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--warning)"}]}	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
3	posts	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
4	posts	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
5	posts	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
6	posts	excerpt	\N	input-multiline	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
7	posts	content	\N	input-rich-text-html	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
8	contacts	id	uuid	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
9	contacts	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
10	contacts	email	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2023-01-27 21:35:51.247336+00
20201029A	Remove System Relations	2023-01-27 21:35:51.253724+00
20201029B	Remove System Collections	2023-01-27 21:35:51.259093+00
20201029C	Remove System Fields	2023-01-27 21:35:51.263515+00
20201105A	Add Cascade System Relations	2023-01-27 21:35:51.322987+00
20201105B	Change Webhook URL Type	2023-01-27 21:35:51.331067+00
20210225A	Add Relations Sort Field	2023-01-27 21:35:51.336606+00
20210304A	Remove Locked Fields	2023-01-27 21:35:51.340328+00
20210312A	Webhooks Collections Text	2023-01-27 21:35:51.348255+00
20210331A	Add Refresh Interval	2023-01-27 21:35:51.353301+00
20210415A	Make Filesize Nullable	2023-01-27 21:35:51.359246+00
20210416A	Add Collections Accountability	2023-01-27 21:35:51.36504+00
20210422A	Remove Files Interface	2023-01-27 21:35:51.367379+00
20210506A	Rename Interfaces	2023-01-27 21:35:51.380969+00
20210510A	Restructure Relations	2023-01-27 21:35:51.408781+00
20210518A	Add Foreign Key Constraints	2023-01-27 21:35:51.414385+00
20210519A	Add System Fk Triggers	2023-01-27 21:35:51.448118+00
20210521A	Add Collections Icon Color	2023-01-27 21:35:51.453858+00
20210525A	Add Insights	2023-01-27 21:35:51.480616+00
20210608A	Add Deep Clone Config	2023-01-27 21:35:51.485115+00
20210626A	Change Filesize Bigint	2023-01-27 21:35:51.498965+00
20210716A	Add Conditions to Fields	2023-01-27 21:35:51.505013+00
20210721A	Add Default Folder	2023-01-27 21:35:51.512593+00
20210802A	Replace Groups	2023-01-27 21:35:51.515408+00
20210803A	Add Required to Fields	2023-01-27 21:35:51.520656+00
20210805A	Update Groups	2023-01-27 21:35:51.525457+00
20210805B	Change Image Metadata Structure	2023-01-27 21:35:51.528339+00
20210811A	Add Geometry Config	2023-01-27 21:35:51.533562+00
20210831A	Remove Limit Column	2023-01-27 21:35:51.538783+00
20210903A	Add Auth Provider	2023-01-27 21:35:51.560125+00
20210907A	Webhooks Collections Not Null	2023-01-27 21:35:51.569908+00
20210910A	Move Module Setup	2023-01-27 21:35:51.57837+00
20210920A	Webhooks URL Not Null	2023-01-27 21:35:51.591682+00
20210924A	Add Collection Organization	2023-01-27 21:35:51.6018+00
20210927A	Replace Fields Group	2023-01-27 21:35:51.614787+00
20210927B	Replace M2M Interface	2023-01-27 21:35:51.617765+00
20210929A	Rename Login Action	2023-01-27 21:35:51.622333+00
20211007A	Update Presets	2023-01-27 21:35:51.6309+00
20211009A	Add Auth Data	2023-01-27 21:35:51.637529+00
20211016A	Add Webhook Headers	2023-01-27 21:35:51.642874+00
20211103A	Set Unique to User Token	2023-01-27 21:35:51.651769+00
20211103B	Update Special Geometry	2023-01-27 21:35:51.654783+00
20211104A	Remove Collections Listing	2023-01-27 21:35:51.660261+00
20211118A	Add Notifications	2023-01-27 21:35:51.678838+00
20211211A	Add Shares	2023-01-27 21:35:51.716179+00
20211230A	Add Project Descriptor	2023-01-27 21:35:51.722021+00
20220303A	Remove Default Project Color	2023-01-27 21:35:51.73433+00
20220308A	Add Bookmark Icon and Color	2023-01-27 21:35:51.737527+00
20220314A	Add Translation Strings	2023-01-27 21:35:51.742279+00
20220322A	Rename Field Typecast Flags	2023-01-27 21:35:51.745666+00
20220323A	Add Field Validation	2023-01-27 21:35:51.751308+00
20220325A	Fix Typecast Flags	2023-01-27 21:35:51.753606+00
20220325B	Add Default Language	2023-01-27 21:35:51.766405+00
20220402A	Remove Default Value Panel Icon	2023-01-27 21:35:51.775376+00
20220429A	Add Flows	2023-01-27 21:35:51.831887+00
20220429B	Add Color to Insights Icon	2023-01-27 21:35:51.835311+00
20220429C	Drop Non Null From IP of Activity	2023-01-27 21:35:51.841165+00
20220429D	Drop Non Null From Sender of Notifications	2023-01-27 21:35:51.846544+00
20220614A	Rename Hook Trigger to Event	2023-01-27 21:35:51.848489+00
20220801A	Update Notifications Timestamp Column	2023-01-27 21:35:51.857922+00
20220802A	Add Custom Aspect Ratios	2023-01-27 21:35:51.863197+00
20220826A	Add Origin to Accountability	2023-01-27 21:35:51.872504+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields) FROM stdin;
1	\N	contacts	create	\N	\N	\N	id
2	\N	posts	read	{"_and":[{"status":{"_eq":"published"}}]}	\N	\N	\N
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent) FROM stdin;
1	2	directus_fields	1	{"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"posts"}	{"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"posts"}	\N
2	3	directus_fields	2	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--warning)"}]},"field":"status","collection":"posts"}	{"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--warning)"}]},"field":"status","collection":"posts"}	\N
3	4	directus_fields	3	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"posts"}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"posts"}	\N
4	5	directus_fields	4	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"posts"}	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"posts"}	\N
5	6	directus_collections	posts	{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"posts"}	{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"posts"}	\N
6	7	directus_fields	5	{"interface":"input","special":null,"required":true,"collection":"posts","field":"title"}	{"interface":"input","special":null,"required":true,"collection":"posts","field":"title"}	\N
7	8	directus_fields	6	{"interface":"input-multiline","special":null,"collection":"posts","field":"excerpt"}	{"interface":"input-multiline","special":null,"collection":"posts","field":"excerpt"}	\N
8	9	directus_fields	7	{"interface":"input-rich-text-html","special":null,"collection":"posts","field":"content"}	{"interface":"input-rich-text-html","special":null,"collection":"posts","field":"content"}	\N
9	10	directus_fields	8	{"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"contacts"}	{"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"contacts"}	\N
10	11	directus_fields	9	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"contacts"}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"contacts"}	\N
11	12	directus_collections	contacts	{"singleton":false,"collection":"contacts"}	{"singleton":false,"collection":"contacts"}	\N
12	13	directus_fields	10	{"interface":"input","special":null,"collection":"contacts","field":"email"}	{"interface":"input","special":null,"collection":"contacts","field":"email"}	\N
13	14	directus_permissions	1	{"role":null,"collection":"contacts","action":"create"}	{"role":null,"collection":"contacts","action":"create"}	\N
14	15	directus_permissions	1	{"id":1,"role":null,"collection":"contacts","action":"create","permissions":null,"validation":null,"presets":null,"fields":["id"]}	{"role":null,"collection":"contacts","action":"create","permissions":null,"validation":null,"presets":null,"fields":["id"]}	\N
15	16	directus_permissions	2	{"role":null,"collection":"posts","action":"read"}	{"role":null,"collection":"posts","action":"read"}	\N
16	17	directus_permissions	2	{"id":2,"role":null,"collection":"posts","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":null}	{"role":null,"collection":"posts","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":null}	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
564019de-dd1e-4e01-91c1-540116972ae5	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin) FROM stdin;
UFbh3Y-Y4jLDLaJbjsbMrBoejoYdRbymV1ckb8Kookrdpfwo924AK1g6ka7yh8ht	a6a6909b-9337-4cd9-ba52-8e039912b11c	2023-02-03 21:36:13.266+00	172.20.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	\N	http://localhost:8055
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, translation_strings, default_language, custom_aspect_ratios) FROM stdin;
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications) FROM stdin;
a6a6909b-9337-4cd9-ba52-8e039912b11c	Admin	User	mortenzwarenstein@hotmail.com	$argon2id$v=19$m=65536,t=3,p=4$MjEthqGaWw3EnHamx0TQMg$STfoEOjLdXSQLXehBolyKrT9fOWFmbU2EtAp5CVD2PE	\N	\N	\N	\N	\N	\N	auto	\N	active	564019de-dd1e-4e01-91c1-540116972ae5	\N	2023-01-27 21:36:13.284+00	/settings/roles/public	default	\N	\N	t
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.posts (id, status, date_created, date_updated, title, excerpt, content) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 17, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 10, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 2, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, false);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, false);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 16, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: contacts contacts_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_email_unique UNIQUE (email);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: posts posts_title_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_title_unique UNIQUE (title);


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

