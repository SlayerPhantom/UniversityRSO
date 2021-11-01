--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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
-- Name: rso_active_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rso_active_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    if ((SELECT COUNT(*) FROM rso_members where rsoid = new.rsoid) > 4) then
        update rsos set active = TRUE where rsos.rsoid = new.rsoid;
    end if;
    RETURN new;
END;
$$;


ALTER FUNCTION public.rso_active_update() OWNER TO postgres;

--
-- Name: rso_inactive_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rso_inactive_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    if ((SELECT COUNT(*) FROM rso_members where rsoid = old.rsoid) = 4) then
        update rsos set active = FALSE where rsos.rsoid = old.rsoid;
    end if;
    RETURN new;
END;
$$;


ALTER FUNCTION public.rso_inactive_update() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: event_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_locations (
    name character varying(60) NOT NULL,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL
);


ALTER TABLE public.event_locations OWNER TO postgres;

--
-- Name: eventtimes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eventtimes (
    start_time time without time zone NOT NULL,
    location_name character varying(60) NOT NULL,
    event_date date NOT NULL,
    timeid bigint NOT NULL
);


ALTER TABLE public.eventtimes OWNER TO postgres;

--
-- Name: eventtimes_timeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eventtimes_timeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eventtimes_timeid_seq OWNER TO postgres;

--
-- Name: eventtimes_timeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eventtimes_timeid_seq OWNED BY public.eventtimes.timeid;


--
-- Name: personal_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_info (
    uid bigint NOT NULL,
    fname character varying(20) NOT NULL,
    lname character varying(20) NOT NULL,
    username character varying(20) NOT NULL,
    userlevel integer DEFAULT 1 NOT NULL,
    university character varying(20) NOT NULL
);


ALTER TABLE public.personal_info OWNER TO postgres;

--
-- Name: personal_info_uid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_info_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_info_uid_seq OWNER TO postgres;

--
-- Name: personal_info_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_info_uid_seq OWNED BY public.personal_info.uid;


--
-- Name: privatecomments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.privatecomments (
    cid bigint NOT NULL,
    eid bigint NOT NULL,
    username character varying(20) NOT NULL,
    uid bigint NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.privatecomments OWNER TO postgres;

--
-- Name: privatecomments_cid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.privatecomments_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privatecomments_cid_seq OWNER TO postgres;

--
-- Name: privatecomments_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.privatecomments_cid_seq OWNED BY public.privatecomments.cid;


--
-- Name: privatecomments_eid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.privatecomments_eid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privatecomments_eid_seq OWNER TO postgres;

--
-- Name: privatecomments_eid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.privatecomments_eid_seq OWNED BY public.privatecomments.eid;


--
-- Name: privatecomments_uid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.privatecomments_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privatecomments_uid_seq OWNER TO postgres;

--
-- Name: privatecomments_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.privatecomments_uid_seq OWNED BY public.privatecomments.uid;


--
-- Name: privateevents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.privateevents (
    eid bigint NOT NULL,
    name character varying(60) NOT NULL,
    university character varying(20),
    description text,
    active boolean DEFAULT false,
    rating double precision DEFAULT 0,
    phone character varying(12),
    email character varying(30),
    category character varying(30),
    timeid bigint NOT NULL,
    CONSTRAINT privateevents_rating_check CHECK (((rating <= (5)::double precision) AND (rating >= (0)::double precision)))
);


ALTER TABLE public.privateevents OWNER TO postgres;

--
-- Name: privateevents_eid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.privateevents_eid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privateevents_eid_seq OWNER TO postgres;

--
-- Name: privateevents_eid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.privateevents_eid_seq OWNED BY public.privateevents.eid;


--
-- Name: privateevents_timeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.privateevents_timeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privateevents_timeid_seq OWNER TO postgres;

--
-- Name: privateevents_timeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.privateevents_timeid_seq OWNED BY public.privateevents.timeid;


--
-- Name: publiccomments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publiccomments (
    cid bigint NOT NULL,
    eid bigint NOT NULL,
    username character varying(20) NOT NULL,
    uid bigint NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.publiccomments OWNER TO postgres;

--
-- Name: publiccomments_cid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publiccomments_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publiccomments_cid_seq OWNER TO postgres;

--
-- Name: publiccomments_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publiccomments_cid_seq OWNED BY public.publiccomments.cid;


--
-- Name: publiccomments_eid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publiccomments_eid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publiccomments_eid_seq OWNER TO postgres;

--
-- Name: publiccomments_eid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publiccomments_eid_seq OWNED BY public.publiccomments.eid;


--
-- Name: publiccomments_uid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publiccomments_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publiccomments_uid_seq OWNER TO postgres;

--
-- Name: publiccomments_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publiccomments_uid_seq OWNED BY public.publiccomments.uid;


--
-- Name: publicevents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publicevents (
    eid bigint NOT NULL,
    name character varying(60) NOT NULL,
    description text,
    active boolean DEFAULT false,
    rating double precision DEFAULT 0,
    phone character varying(12),
    email character varying(30),
    category character varying(30),
    timeid bigint NOT NULL,
    CONSTRAINT publicevents_rating_check CHECK (((rating <= (5)::double precision) AND (rating >= (0)::double precision)))
);


ALTER TABLE public.publicevents OWNER TO postgres;

--
-- Name: publicevents_eid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publicevents_eid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publicevents_eid_seq OWNER TO postgres;

--
-- Name: publicevents_eid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publicevents_eid_seq OWNED BY public.publicevents.eid;


--
-- Name: publicevents_timeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publicevents_timeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publicevents_timeid_seq OWNER TO postgres;

--
-- Name: publicevents_timeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publicevents_timeid_seq OWNED BY public.publicevents.timeid;


--
-- Name: revents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revents (
    eid bigint NOT NULL,
    rsoid bigint NOT NULL,
    name character varying(60) NOT NULL,
    description text,
    rating double precision DEFAULT 0,
    phone character varying(12),
    email character varying(30),
    category character varying(30),
    timeid bigint NOT NULL,
    CONSTRAINT revents_rating_check CHECK (((rating <= (5)::double precision) AND (rating >= (0)::double precision)))
);


ALTER TABLE public.revents OWNER TO postgres;

--
-- Name: revents_eid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.revents_eid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revents_eid_seq OWNER TO postgres;

--
-- Name: revents_eid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.revents_eid_seq OWNED BY public.revents.eid;


--
-- Name: revents_rsoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.revents_rsoid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revents_rsoid_seq OWNER TO postgres;

--
-- Name: revents_rsoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.revents_rsoid_seq OWNED BY public.revents.rsoid;


--
-- Name: revents_timeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.revents_timeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revents_timeid_seq OWNER TO postgres;

--
-- Name: revents_timeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.revents_timeid_seq OWNED BY public.revents.timeid;


--
-- Name: rso_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rso_members (
    rsoid bigint NOT NULL,
    uid bigint NOT NULL
);


ALTER TABLE public.rso_members OWNER TO postgres;

--
-- Name: rso_members_rsoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rso_members_rsoid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rso_members_rsoid_seq OWNER TO postgres;

--
-- Name: rso_members_rsoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rso_members_rsoid_seq OWNED BY public.rso_members.rsoid;


--
-- Name: rso_members_uid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rso_members_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rso_members_uid_seq OWNER TO postgres;

--
-- Name: rso_members_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rso_members_uid_seq OWNED BY public.rso_members.uid;


--
-- Name: rsocomments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rsocomments (
    cid bigint NOT NULL,
    eid bigint NOT NULL,
    username character varying(20) NOT NULL,
    uid bigint NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.rsocomments OWNER TO postgres;

--
-- Name: rsocomments_cid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rsocomments_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rsocomments_cid_seq OWNER TO postgres;

--
-- Name: rsocomments_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rsocomments_cid_seq OWNED BY public.rsocomments.cid;


--
-- Name: rsocomments_eid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rsocomments_eid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rsocomments_eid_seq OWNER TO postgres;

--
-- Name: rsocomments_eid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rsocomments_eid_seq OWNED BY public.rsocomments.eid;


--
-- Name: rsocomments_uid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rsocomments_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rsocomments_uid_seq OWNER TO postgres;

--
-- Name: rsocomments_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rsocomments_uid_seq OWNED BY public.rsocomments.uid;


--
-- Name: rsos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rsos (
    rsoid bigint NOT NULL,
    rso_name character varying(20) NOT NULL,
    email character varying(60) NOT NULL,
    description character varying(255) NOT NULL,
    admin bigint NOT NULL,
    university character varying(20),
    active boolean DEFAULT false
);


ALTER TABLE public.rsos OWNER TO postgres;

--
-- Name: rsos_admin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rsos_admin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rsos_admin_seq OWNER TO postgres;

--
-- Name: rsos_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rsos_admin_seq OWNED BY public.rsos.admin;


--
-- Name: rsos_rsoid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rsos_rsoid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rsos_rsoid_seq OWNER TO postgres;

--
-- Name: rsos_rsoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rsos_rsoid_seq OWNED BY public.rsos.rsoid;


--
-- Name: university; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university (
    name character varying(20),
    address character varying(60),
    num_students integer,
    super_admin bigint NOT NULL,
    description text
);


ALTER TABLE public.university OWNER TO postgres;

--
-- Name: university_super_admin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.university_super_admin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.university_super_admin_seq OWNER TO postgres;

--
-- Name: university_super_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.university_super_admin_seq OWNED BY public.university.super_admin;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    uid bigint NOT NULL,
    email character varying(60) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_uid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_uid_seq OWNER TO postgres;

--
-- Name: users_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_uid_seq OWNED BY public.users.uid;


--
-- Name: eventtimes timeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventtimes ALTER COLUMN timeid SET DEFAULT nextval('public.eventtimes_timeid_seq'::regclass);


--
-- Name: personal_info uid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_info ALTER COLUMN uid SET DEFAULT nextval('public.personal_info_uid_seq'::regclass);


--
-- Name: privatecomments cid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privatecomments ALTER COLUMN cid SET DEFAULT nextval('public.privatecomments_cid_seq'::regclass);


--
-- Name: privatecomments eid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privatecomments ALTER COLUMN eid SET DEFAULT nextval('public.privatecomments_eid_seq'::regclass);


--
-- Name: privatecomments uid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privatecomments ALTER COLUMN uid SET DEFAULT nextval('public.privatecomments_uid_seq'::regclass);


--
-- Name: privateevents eid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privateevents ALTER COLUMN eid SET DEFAULT nextval('public.privateevents_eid_seq'::regclass);


--
-- Name: privateevents timeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privateevents ALTER COLUMN timeid SET DEFAULT nextval('public.privateevents_timeid_seq'::regclass);


--
-- Name: publiccomments cid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publiccomments ALTER COLUMN cid SET DEFAULT nextval('public.publiccomments_cid_seq'::regclass);


--
-- Name: publiccomments eid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publiccomments ALTER COLUMN eid SET DEFAULT nextval('public.publiccomments_eid_seq'::regclass);


--
-- Name: publiccomments uid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publiccomments ALTER COLUMN uid SET DEFAULT nextval('public.publiccomments_uid_seq'::regclass);


--
-- Name: publicevents eid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicevents ALTER COLUMN eid SET DEFAULT nextval('public.publicevents_eid_seq'::regclass);


--
-- Name: publicevents timeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicevents ALTER COLUMN timeid SET DEFAULT nextval('public.publicevents_timeid_seq'::regclass);


--
-- Name: revents eid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revents ALTER COLUMN eid SET DEFAULT nextval('public.revents_eid_seq'::regclass);


--
-- Name: revents rsoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revents ALTER COLUMN rsoid SET DEFAULT nextval('public.revents_rsoid_seq'::regclass);


--
-- Name: revents timeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revents ALTER COLUMN timeid SET DEFAULT nextval('public.revents_timeid_seq'::regclass);


--
-- Name: rso_members rsoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rso_members ALTER COLUMN rsoid SET DEFAULT nextval('public.rso_members_rsoid_seq'::regclass);


--
-- Name: rso_members uid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rso_members ALTER COLUMN uid SET DEFAULT nextval('public.rso_members_uid_seq'::regclass);


--
-- Name: rsocomments cid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsocomments ALTER COLUMN cid SET DEFAULT nextval('public.rsocomments_cid_seq'::regclass);


--
-- Name: rsocomments eid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsocomments ALTER COLUMN eid SET DEFAULT nextval('public.rsocomments_eid_seq'::regclass);


--
-- Name: rsocomments uid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsocomments ALTER COLUMN uid SET DEFAULT nextval('public.rsocomments_uid_seq'::regclass);


--
-- Name: rsos rsoid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsos ALTER COLUMN rsoid SET DEFAULT nextval('public.rsos_rsoid_seq'::regclass);


--
-- Name: rsos admin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsos ALTER COLUMN admin SET DEFAULT nextval('public.rsos_admin_seq'::regclass);


--
-- Name: university super_admin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university ALTER COLUMN super_admin SET DEFAULT nextval('public.university_super_admin_seq'::regclass);


--
-- Name: users uid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN uid SET DEFAULT nextval('public.users_uid_seq'::regclass);


--
-- Data for Name: event_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_locations (name, longitude, latitude) FROM stdin;
Gainesville, FL 32611	-82.3248	29.6516
4000 Central Florida Blvd, Orlando, FL 32816	-81.20005	28.6024274
4365 Andromeda Loop N, Orlando, FL 32816	-81.2022	28.599085
virtual	0	0
12777 Gemini Blvd N. Orlando, Florida 32816.	-81.1969	28.6081
\.


--
-- Data for Name: eventtimes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eventtimes (start_time, location_name, event_date, timeid) FROM stdin;
01:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-03-20	1
05:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-04-22	2
08:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-05-26	3
12:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-05-26	4
13:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-05-26	5
01:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-10-20	6
01:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-10-21	7
01:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-10-22	8
01:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-10-23	9
01:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-10-24	10
01:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-10-25	11
01:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-11-21	12
02:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-11-22	13
04:00:00	4000 Central Florida Blvd, Orlando, FL 32816	2001-11-23	14
02:00:00	4365 Andromeda Loop N, Orlando, FL 32816	2021-05-02	16
01:00:00	4365 Andromeda Loop N, Orlando, FL 32816	2021-04-18	17
01:00:00	virtual	2021-04-22	18
02:00:00	virtual	2021-04-22	19
01:00:00	virtual	2021-04-16	20
05:00:00	virtual	2021-04-16	21
13:00:00	virtual	2021-04-21	22
15:00:00	virtual	2021-04-21	23
15:00:00	4365 Andromeda Loop N, Orlando, FL 32816	2021-04-15	24
15:00:00	4365 Andromeda Loop N, Orlando, FL 32816	2021-04-16	27
16:00:00	4365 Andromeda Loop N, Orlando, FL 32816	2021-04-16	28
\.


--
-- Data for Name: personal_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_info (uid, fname, lname, username, userlevel, university) FROM stdin;
1	John	Smith	unravelphantom	3	UCF
2	John	Doe	ocularskill	3	UF
3	Ben	Jammin	Benjammin	1	UCF
4	Tyler	Woods	Prof. Golf	2	UCF
5	Nice	Job	nicejob	2	UF
6	Alice	Watson	neverland	2	UF
7	Serious	Black	Wizard101	1	UCF
8	Brandon	Deng	Sorceror	1	UCF
9	Kevin	Leng	Magic	1	UCF
10	Harry	Potter	Wizard King	2	UF
12	Ben	Jammin	Benjammin	1	UCF
13	Tyler	Woods	Prof. Golf	2	UCF
14	Nice	Job	nicejob	2	UF
15	Alice	Watson	neverland	2	UF
16	Serious	Black	Wizard101	1	UCF
17	Brandon	Deng	Sorceror	1	UCF
18	Kevin	Leng	Magic	1	UCF
19	Harry	Potter	Wizard King	2	UF
20	John	Smith	unravelphantom	2	UCF
11	John	Doe	ocularskill	2	UF
21	new	new	new	3	UCF
\.


--
-- Data for Name: privatecomments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.privatecomments (cid, eid, username, uid, description, created_at) FROM stdin;
\.


--
-- Data for Name: privateevents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.privateevents (eid, name, university, description, active, rating, phone, email, category, timeid) FROM stdin;
6	1st public	UCF	1st event	f	0	111-111-1111	email@email.com	Social	7
7	public Dinner	UCF	Dinner event	f	5	222-111-1111	dinner@email.com	Dinner	8
8	Game Night and Friends	UCF	Game night with Everyone	f	1	111-222-1111	email@email.com	Games	9
9	public tutoring	UCF	tutoring at UCF	f	0	111-111-3333	tutor@email.com	Tutoring	10
10	Last event	UF	last event	f	1	234-234-2314	last@email.com	Last	11
11	new private	UCF	something private	t	1	111-111-1111	private@email.com	private	23
\.


--
-- Data for Name: publiccomments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publiccomments (cid, eid, username, uid, description, created_at) FROM stdin;
1	1	unravelphantom	1	1st comment	2021-04-18 16:49:33.995353
2	2	ocularskills	2	2nd comment	2021-04-18 16:49:33.995353
3	3	Benjammin	3	3rd comment	2021-04-18 16:49:33.995353
4	1	unravelphantom	1	1st comment	2021-04-18 16:50:00.846162
5	1	ocularskills	2	2nd comment	2021-04-18 16:50:00.846162
6	1	Benjammin	3	3rd comment	2021-04-18 16:50:00.846162
7	6	unravelphantom	1	update description	2021-04-18 18:47:24.023155
\.


--
-- Data for Name: publicevents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publicevents (eid, name, description, active, rating, phone, email, category, timeid) FROM stdin;
1	1st public	1st event	f	0	111-111-1111	email@email.com	Social	1
2	public Dinner	Dinner event	t	5	222-111-1111	dinner@email.com	Dinner	2
3	Game Night and Friends	Game night with Everyone	t	1	111-222-1111	email@email.com	Games	3
4	public tutoring	tutoring at UCF	f	0	111-111-3333	tutor@email.com	Tutoring	4
5	Last event	last event	t	1	234-234-2314	last@email.com	Last	5
6	example event	new example event	f	5	222-111-1111	dinner@email.com	Dinner	6
7	new	email	f	0	111-111-1111	email@email.com	email	16
8	new	e	f	0	111-111-1111	new	some	17
10	some	s	t	0	111-111-1111	email@email.com	social	19
11	something else	dsadsa	f	0	222-222-2222	email@email.com	so	20
12	something else	dgfg	t	0	222-222-2222	email@email.com	so	21
9	some	f	t	2	111-111-1111	email@email.com	social	18
\.


--
-- Data for Name: revents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revents (eid, rsoid, name, description, rating, phone, email, category, timeid) FROM stdin;
1	1	1st public	1st event	0	111-111-1111	email@email.com	Social	12
2	1	1st public	1st event	0	111-111-1111	email@email.com	Social	13
3	1	1st public	1st event	0	111-111-1111	email@email.com	Social	14
4	7	ewnrsoevent	fghgh	0	222-222-2222	email@email.com	email	28
\.


--
-- Data for Name: rso_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rso_members (rsoid, uid) FROM stdin;
5	1
6	21
1	21
7	21
\.


--
-- Data for Name: rsocomments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rsocomments (cid, eid, username, uid, description, created_at) FROM stdin;
\.


--
-- Data for Name: rsos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rsos (rsoid, rso_name, email, description, admin, university, active) FROM stdin;
1	1st rso	rso1@email.com	1st description	1	UCF	f
2	2nd rso	rso2@email.com	2nd description	2	UCF	f
3	3rd rso	rso3@email.com	3rd description	3	UF	f
4	example rso	email@email.com	Example RSO Insertion	1	UCF	f
5	example rso	email@email.com	Example RSO Insertion	1	UCF	f
6	new rso group	new@email.com	new rso	21	UCF	t
7	newuser	user@email.com	rso	21	UCF	t
\.


--
-- Data for Name: university; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university (name, address, num_students, super_admin, description) FROM stdin;
UCF	4000 Central Florida Blvd, Orlando, FL 32816	100	1	UCF description
UF	Gainesville, FL 32611	150	2	UF description
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (uid, email, password) FROM stdin;
1	unravelphantom@gmail.com	9029Gods
2	ocularskills@gmail.com	somepassword
3	ucfuser@knights.ucf.edu	ucfuser
4	ufuser@uf.edu	ufuser
5	slayerphantom@knights.ucf.edu	slayer
6	hello@gmail.com	hello
7	byebye@gmail.com	byebye
8	enterhere@knights.ucf.edu	enter
9	something@gmail.com	something
10	another@knights.uf.edu	anotherone
11	sunravelphantom@gmail.com	9029Gods
12	socularskills@gmail.com	somepassword
13	sucfuser@knights.ucf.edu	ucfuser
14	sufuser@uf.edu	ufuser
15	sslayerphantom@knights.ucf.edu	slayer
16	shello@gmail.com	hello
17	sbyebye@gmail.com	byebye
18	senterhere@knights.ucf.edu	enter
19	ssomething@gmail.com	something
20	sanother@knights.uf.edu	anotherone
21	new@email.com	$2a$12$vdDde40/5VQx7B3zTttpgO63549foC3/BM5zyk8/nU6.DgxVZ0sem
\.


--
-- Name: eventtimes_timeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eventtimes_timeid_seq', 28, true);


--
-- Name: personal_info_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_info_uid_seq', 1, false);


--
-- Name: privatecomments_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.privatecomments_cid_seq', 1, true);


--
-- Name: privatecomments_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.privatecomments_eid_seq', 1, false);


--
-- Name: privatecomments_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.privatecomments_uid_seq', 1, false);


--
-- Name: privateevents_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.privateevents_eid_seq', 11, true);


--
-- Name: privateevents_timeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.privateevents_timeid_seq', 1, false);


--
-- Name: publiccomments_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publiccomments_cid_seq', 8, true);


--
-- Name: publiccomments_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publiccomments_eid_seq', 1, false);


--
-- Name: publiccomments_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publiccomments_uid_seq', 1, false);


--
-- Name: publicevents_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publicevents_eid_seq', 12, true);


--
-- Name: publicevents_timeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publicevents_timeid_seq', 1, false);


--
-- Name: revents_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.revents_eid_seq', 4, true);


--
-- Name: revents_rsoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.revents_rsoid_seq', 1, false);


--
-- Name: revents_timeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.revents_timeid_seq', 1, false);


--
-- Name: rso_members_rsoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rso_members_rsoid_seq', 1, false);


--
-- Name: rso_members_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rso_members_uid_seq', 1, false);


--
-- Name: rsocomments_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rsocomments_cid_seq', 1, false);


--
-- Name: rsocomments_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rsocomments_eid_seq', 1, false);


--
-- Name: rsocomments_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rsocomments_uid_seq', 1, false);


--
-- Name: rsos_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rsos_admin_seq', 1, false);


--
-- Name: rsos_rsoid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rsos_rsoid_seq', 7, true);


--
-- Name: university_super_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_super_admin_seq', 1, false);


--
-- Name: users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_uid_seq', 21, true);


--
-- Name: event_locations event_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_locations
    ADD CONSTRAINT event_locations_pkey PRIMARY KEY (name);


--
-- Name: eventtimes eventtimes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventtimes
    ADD CONSTRAINT eventtimes_pkey PRIMARY KEY (start_time, location_name, event_date);


--
-- Name: privatecomments privatecomments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privatecomments
    ADD CONSTRAINT privatecomments_pkey PRIMARY KEY (cid);


--
-- Name: privateevents privateevents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privateevents
    ADD CONSTRAINT privateevents_pkey PRIMARY KEY (eid);


--
-- Name: publiccomments publiccomments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publiccomments
    ADD CONSTRAINT publiccomments_pkey PRIMARY KEY (cid);


--
-- Name: publicevents publicevents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicevents
    ADD CONSTRAINT publicevents_pkey PRIMARY KEY (eid);


--
-- Name: revents revents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revents
    ADD CONSTRAINT revents_pkey PRIMARY KEY (eid);


--
-- Name: rso_members rso_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rso_members
    ADD CONSTRAINT rso_members_pkey PRIMARY KEY (rsoid, uid);


--
-- Name: rsocomments rsocomments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsocomments
    ADD CONSTRAINT rsocomments_pkey PRIMARY KEY (cid);


--
-- Name: rsos rsos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsos
    ADD CONSTRAINT rsos_pkey PRIMARY KEY (rsoid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- Name: rso_members update_inactivity_rso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_inactivity_rso AFTER DELETE ON public.rso_members FOR EACH ROW EXECUTE FUNCTION public.rso_inactive_update();


--
-- Name: rso_members update_rso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_rso AFTER INSERT ON public.rso_members FOR EACH ROW EXECUTE FUNCTION public.rso_active_update();


--
-- Name: eventtimes eventtimes_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventtimes
    ADD CONSTRAINT eventtimes_location_fkey FOREIGN KEY (location_name) REFERENCES public.event_locations(name);


--
-- Name: privatecomments privatecomments_eid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privatecomments
    ADD CONSTRAINT privatecomments_eid_fkey FOREIGN KEY (eid) REFERENCES public.privateevents(eid);


--
-- Name: privatecomments privatecomments_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privatecomments
    ADD CONSTRAINT privatecomments_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(uid);


--
-- Name: publiccomments publiccomments_eid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publiccomments
    ADD CONSTRAINT publiccomments_eid_fkey FOREIGN KEY (eid) REFERENCES public.publicevents(eid);


--
-- Name: publiccomments publiccomments_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publiccomments
    ADD CONSTRAINT publiccomments_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(uid);


--
-- Name: revents revents_rsoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revents
    ADD CONSTRAINT revents_rsoid_fkey FOREIGN KEY (rsoid) REFERENCES public.rsos(rsoid);


--
-- Name: rso_members rso_members_rsoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rso_members
    ADD CONSTRAINT rso_members_rsoid_fkey FOREIGN KEY (rsoid) REFERENCES public.rsos(rsoid);


--
-- Name: rso_members rso_members_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rso_members
    ADD CONSTRAINT rso_members_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(uid);


--
-- Name: rsocomments rsocomments_eid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsocomments
    ADD CONSTRAINT rsocomments_eid_fkey FOREIGN KEY (eid) REFERENCES public.revents(eid);


--
-- Name: rsocomments rsocomments_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsocomments
    ADD CONSTRAINT rsocomments_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(uid);


--
-- Name: rsos rsos_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rsos
    ADD CONSTRAINT rsos_admin_fkey FOREIGN KEY (admin) REFERENCES public.users(uid);


--
-- Name: university university_super_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT university_super_admin_fkey FOREIGN KEY (super_admin) REFERENCES public.users(uid);


--
-- PostgreSQL database dump complete
--

