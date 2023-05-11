--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2023-05-09 19:46:41 -05

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
-- TOC entry 4 (class 2615 OID 22955)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 845 (class 1247 OID 22966)
-- Name: Enum_RoleName; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Enum_RoleName" AS ENUM (
    'ADMIN',
    'USER'
);


ALTER TYPE public."Enum_RoleName" OWNER TO postgres;

--
-- TOC entry 240 (class 1255 OID 23743)
-- Name: audit_user_insert(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.audit_user_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if (TG_OP = 'INSERT') then
			insert into "user_audit"
			values(new.id, new.email, new."emailVerified", new.name, new.phone, new.address, new.photo_link, new.image, new.position_id, new.document, nextval('user_audit_audit_id_seq'::regclass), 'I', now(), current_user);
		elsif (TG_OP = 'UPDATE') then
			insert into "user_audit"
			values(new.id, new.email, new."emailVerified", new.name, new.phone, new.address, new.photo_link, new.image, new.position_id, new.document, nextval('user_audit_audit_id_seq'::regclass), 'U', now(), current_user);
		elsif (TG_OP = 'DELETE') then
			insert into "user_audit"
			values(old.id, old.email, old."emailVerified", old.name, old.phone, old.address, old.photo_link, old.image, old.position_id, old.document, nextval('user_audit_audit_id_seq'::regclass), 'D', now(), current_user);
		end if;
		return null;
	END;
$$;


ALTER FUNCTION public.audit_user_insert() OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 23725)
-- Name: user_audit_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_audit_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into user_audit
		values(OLD.*);
	return null;
	END;
$$;


ALTER FUNCTION public.user_audit_trigger() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 22971)
-- Name: Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Account" (
    id text NOT NULL,
    "userId" text NOT NULL,
    type text NOT NULL,
    provider text NOT NULL,
    "providerAccountId" text NOT NULL,
    refresh_token text,
    access_token text,
    expires_at integer,
    token_type text,
    scope text,
    id_token text,
    session_state text
);


ALTER TABLE public."Account" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 23026)
-- Name: Comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comment" (
    id text NOT NULL,
    text text NOT NULL,
    creation_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_date timestamp(3) without time zone NOT NULL,
    user_id text NOT NULL,
    training_id text NOT NULL
);


ALTER TABLE public."Comment" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 23042)
-- Name: Course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Course" (
    id text NOT NULL,
    name text NOT NULL,
    duration integer NOT NULL,
    link text NOT NULL,
    creation_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_date timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Course" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 23058)
-- Name: CourseState; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CourseState" (
    id text NOT NULL,
    is_completed boolean NOT NULL,
    certificated boolean NOT NULL,
    certificate_link text NOT NULL,
    creation_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_date timestamp(3) without time zone NOT NULL,
    user_id text NOT NULL,
    course_id text NOT NULL
);


ALTER TABLE public."CourseState" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 23034)
-- Name: Like; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Like" (
    id text NOT NULL,
    creation_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_date timestamp(3) without time zone NOT NULL,
    user_id text NOT NULL,
    note_id text NOT NULL
);


ALTER TABLE public."Like" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 23018)
-- Name: Note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Note" (
    id text NOT NULL,
    text text NOT NULL,
    creation_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_date timestamp(3) without time zone NOT NULL,
    user_id text NOT NULL,
    course_id text NOT NULL
);


ALTER TABLE public."Note" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 22985)
-- Name: Page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Page" (
    id text NOT NULL,
    name text NOT NULL,
    path text NOT NULL,
    "isPublic" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Page" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 23010)
-- Name: Position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Position" (
    id text NOT NULL,
    name text NOT NULL,
    creation_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_date timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Position" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 22994)
-- Name: Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Role" (
    id text NOT NULL,
    name public."Enum_RoleName" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Role" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 22978)
-- Name: Session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Session" (
    id text NOT NULL,
    "sessionToken" text NOT NULL,
    "userId" text NOT NULL,
    expires timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Session" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 23050)
-- Name: Training; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Training" (
    id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    creation_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_date timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Training" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 23002)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id text NOT NULL,
    email text NOT NULL,
    "emailVerified" timestamp(3) without time zone,
    name text,
    phone text,
    address text,
    photo_link text,
    image text,
    creation_date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_date timestamp(3) without time zone NOT NULL,
    position_id text,
    document text
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 23076)
-- Name: _CourseToTraining; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_CourseToTraining" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_CourseToTraining" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 23066)
-- Name: _PageToRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_PageToRole" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_PageToRole" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 23071)
-- Name: _RoleToUser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_RoleToUser" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_RoleToUser" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 23081)
-- Name: _TrainingToUser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_TrainingToUser" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_TrainingToUser" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 22956)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 23698)
-- Name: user_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_audit (
    id text NOT NULL,
    email text NOT NULL,
    "emailVerified" timestamp(3) without time zone,
    name text,
    phone text,
    address text,
    photo_link text,
    image text,
    position_id text,
    document text,
    audit_id bigint NOT NULL,
    op character(1),
    stamp timestamp without time zone,
    "user" character varying
);


ALTER TABLE public.user_audit OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 23708)
-- Name: user_audit_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_audit_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_audit_audit_id_seq OWNER TO postgres;

--
-- TOC entry 3747 (class 0 OID 0)
-- Dependencies: 227
-- Name: user_audit_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_audit_audit_id_seq OWNED BY public.user_audit.audit_id;


--
-- TOC entry 3517 (class 2604 OID 23709)
-- Name: user_audit audit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_audit ALTER COLUMN audit_id SET DEFAULT nextval('public.user_audit_audit_id_seq'::regclass);


--
-- TOC entry 3724 (class 0 OID 22971)
-- Dependencies: 210
-- Data for Name: Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Account" (id, "userId", type, provider, "providerAccountId", refresh_token, access_token, expires_at, token_type, scope, id_token, session_state) FROM stdin;
clhfnl6k90003sjb61l7lxes6	clhfnl6k10000sjb659m9gco5	oauth	auth0	auth0|64565da41a82c05eefdee0a5	\N	eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiaXNzIjoiaHR0cHM6Ly9sZWFybmluZy10cmVlLXNvZnR3YXJlLnVzLmF1dGgwLmNvbS8ifQ..Crwkldh3rHPoXpfD.Sii9O8dTla18Tw9QVH8mblg5bLv2CPwFBQhZUYoN3mrJe4bHyP3LbRVY1jvy29lXyJ6fBrzQ6nK0TXeOhaCf06ZiP1pKN3v1oZQU1CfQCak0EduUwBi7scs7H3WXVx89IMnj3JjQ0TXKMDVInuMBLmjfbsyAEf5loCSkHTDZGC_svQBLkwtXUwnxC5TOhrLm-A_BRnTqszFYMB-iuHLAL01a2Ucc5PZB6ydTFNjXOmKb5hiwhYwumvetA6NpYXkfIDj1UtJh5DCzYMpACAOFJPMNSUFxxiEi-SBwyI8ExbVc7g8HO7oF__TLJf9wFWXiHhc8DcxfghUq_vnlkorw5klO7dwtgw.Udd2EZgyrKvbfSTTV1eEnw	1683685757	Bearer	openid profile email	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IllqdTJUU1pHNEsxZlUzYV9FM0pqcSJ9.eyJuaWNrbmFtZSI6ImFsZ28iLCJuYW1lIjoiYWxnb0BnbWFpbC5jb20iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zLmdyYXZhdGFyLmNvbS9hdmF0YXIvMzM4NmFlZjZlYWE0NDIyZjU2NWQ1ZmE4NDQ3NjliMTA_cz00ODAmcj1wZyZkPWh0dHBzJTNBJTJGJTJGY2RuLmF1dGgwLmNvbSUyRmF2YXRhcnMlMkZhbC5wbmciLCJ1cGRhdGVkX2F0IjoiMjAyMy0wNS0wNlQxNDowMTowOC4zMDRaIiwiZW1haWwiOiJhbGdvQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiaXNzIjoiaHR0cHM6Ly9sZWFybmluZy10cmVlLXNvZnR3YXJlLnVzLmF1dGgwLmNvbS8iLCJhdWQiOiJRRVlNbkFZMkhkanhTbXJ6MWJNdWhuQUhTbFNXY0tEWiIsImlhdCI6MTY4MzU5OTM1NywiZXhwIjoxNjgzNjM1MzU3LCJzdWIiOiJhdXRoMHw2NDU2NWRhNDFhODJjMDVlZWZkZWUwYTUiLCJzaWQiOiJVWmFwZXV1WC1aYlRmSjdDdFZlOHl1bllrcUFreVdwMCJ9.xw_7K3hFQ12hXFNeowlgPug_2PfjdtbP4OosOsodV_HOqSuObEnOTNGoZf6aSuLO-qAUkk5mXafeF_q88_T0Xpw3jgUf0TL8gCAg1FYBGI0m-2_AeglUOvp9t_FGT7zY0gpfWhx76OSNzf22XU2WiSNISYpuESlyVJMpDoX2yRI1ZxYkp7cLwcyoJ4TEKFBCbjiQDcNZgmT6KZIiGx81RnxWmtrWRonAMa1Q2QRIqW7Gwo1GobDT7DgEJDzjQeGmsSmY61RU-4Tr0AjZMUJ58j4WOe_bTLoJU73UD8H5UmN0bEYczJU7QupMJDHyYWbT5ZRiOAhWFYoIEQGUi4t7qQ	\N
clhfnng5q0003sj1lgt9r7zej	clhfnng5k0000sj1lxsh1otg3	oauth	auth0	auth0|6455abb40c1aee4f2c823516	\N	eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiaXNzIjoiaHR0cHM6Ly9sZWFybmluZy10cmVlLXNvZnR3YXJlLnVzLmF1dGgwLmNvbS8ifQ..k9Jh_qQI2_CIxctL.-7g9tetuLYsuOcUpFbki2wG5i6qrTeAXfHEe40zTO79s0tetU0tXNjBBPGN8OpJH0X0q0l_8zEeZneWDd-Tdw9od0LWqOch97Axn4CXv5ldC4jyd5uvQrsfBM_lH5ELMm4Bv7HHY_ICUyN13_euAn3rTCQHPYLhxj3pUUO-IoPm1GYl4FfM9yIBZh9AgwmVDkG1B_za6f7e5tcM8QqCvLIx1aX9mrCjBnv0YVD3tcckhDYeKYyHWTizp8_fj7qTonK3ig2_WO0anaEQlJlEHWt482DFjJvygqMomnwweTF5yxi1OFPuFaMBplMgk9Rcyxyb3JN6l3Uyd2PV-ldpuoqUeadF33A.rdOSX7F9mZOTywxGboa83w	1683685863	Bearer	openid profile email	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IllqdTJUU1pHNEsxZlUzYV9FM0pqcSJ9.eyJuaWNrbmFtZSI6InJlZmlnYTc5MzAiLCJuYW1lIjoicmVmaWdhNzkzMEBsYXJsYW5kLmNvbSIsInBpY3R1cmUiOiJodHRwczovL3MuZ3JhdmF0YXIuY29tL2F2YXRhci9jZGJiZWJkNzlmYjZhMTczNmM2MGYzMTM4ZDY4MjMxOT9zPTQ4MCZyPXBnJmQ9aHR0cHMlM0ElMkYlMkZjZG4uYXV0aDAuY29tJTJGYXZhdGFycyUyRnJlLnBuZyIsInVwZGF0ZWRfYXQiOiIyMDIzLTA1LTA2VDE0OjAyOjM2LjQzMVoiLCJlbWFpbCI6InJlZmlnYTc5MzBAbGFybGFuZC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImlzcyI6Imh0dHBzOi8vbGVhcm5pbmctdHJlZS1zb2Z0d2FyZS51cy5hdXRoMC5jb20vIiwiYXVkIjoiUUVZTW5BWTJIZGp4U21yejFiTXVobkFIU2xTV2NLRFoiLCJpYXQiOjE2ODM1OTk0NjMsImV4cCI6MTY4MzYzNTQ2Mywic3ViIjoiYXV0aDB8NjQ1NWFiYjQwYzFhZWU0ZjJjODIzNTE2Iiwic2lkIjoiR0V0SUJtekdVaEJLQ1FVOTlhSk5jaHFtQWNjdTlsd0kifQ.w0yVE9mzc1rBwl5ugGXGMrkNuq1wgHfrmQnBX7lrv_dNrndVJe5RuTE3d7OPVD1PJYMojt2DBGSEDx_D4_aq6f0x2XPFrAH_FxB9K78Igy8TX5B5OQW4uGUM2bMbrgkwGG40cVhK-uC1ALiAP0LQR_cBWgk6aBnegJmCQyg_3ootXbYzuCmoCNenvu4VmXV-gx2Jt-BL5XkB1FI5J3k_97KOrpqwzrWWPJypLkSjfxIA-6X4JSPWbRTl7jJHhUht9dKlkRK5qt64fwWL-ItB0Dgs8-EG-ewtSLsjO2nJ5bsfSjFwqw-GoqzMQWHZB_jjhfSzdEwKeZflkSl3nrwmFQ	\N
clhfno1280009sj1lvhganogy	clhfno1210006sj1le39ecp38	oauth	auth0	auth0|6459b07f5dacc356c0072722	\N	eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiaXNzIjoiaHR0cHM6Ly9sZWFybmluZy10cmVlLXNvZnR3YXJlLnVzLmF1dGgwLmNvbS8ifQ..eddvftiRnMJiBC7Q.1d-SIa2VXe_6A6u0czMKIFSdyWmCUAMpBU9X-bFEoY1bh37Z90AhVNVO3JW0DgXJjIiETjSrvuGIUZVgKkA5WmNiI-Orv0yWGjO5PLRY18vyunnFQGz6B9ttmksmu6QNPqw-XiVFBMXgCEbzXeIHmOF9nl3NGg0YDWsxHmDC9korSBvNwLMLaOFJ3eyKXV9UKmMNBsVUqO0au4We6if0r9DuYa9J71dNQeP9sZMns9yaOd31m_ViHBFXU7hvTtB4bACjN7aDYarsLQdv5_-2DawNK5MbGMJCMhBNcVkyi0FtiXMdZDyZRsNZ10K88teewe_75dB3aIU9J-F-uwOsCi1CzUGf3g.dPIQg6nkks0k7KJIof-MOQ	1683685890	Bearer	openid profile email	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IllqdTJUU1pHNEsxZlUzYV9FM0pqcSJ9.eyJuaWNrbmFtZSI6InBydWViYSIsIm5hbWUiOiJwcnVlYmFAbmV3cHJ1ZWJhLmNvbSIsInBpY3R1cmUiOiJodHRwczovL3MuZ3JhdmF0YXIuY29tL2F2YXRhci85MDU1YjVhZTMxNDkzMDUzODQzMWE0OGJjYWE5MDBiOT9zPTQ4MCZyPXBnJmQ9aHR0cHMlM0ElMkYlMkZjZG4uYXV0aDAuY29tJTJGYXZhdGFycyUyRnByLnBuZyIsInVwZGF0ZWRfYXQiOiIyMDIzLTA1LTA5VDAyOjMxOjI3LjA2N1oiLCJlbWFpbCI6InBydWViYUBuZXdwcnVlYmEuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJpc3MiOiJodHRwczovL2xlYXJuaW5nLXRyZWUtc29mdHdhcmUudXMuYXV0aDAuY29tLyIsImF1ZCI6IlFFWU1uQVkySGRqeFNtcnoxYk11aG5BSFNsU1djS0RaIiwiaWF0IjoxNjgzNTk5NDkwLCJleHAiOjE2ODM2MzU0OTAsInN1YiI6ImF1dGgwfDY0NTliMDdmNWRhY2MzNTZjMDA3MjcyMiIsInNpZCI6IlB4RFh5b2Q2YzNEdEhqN2h3YTJXRF9ReTFJa2FwclM5In0.nO2fIKT659GUYthWsQUVOWHntHiuXxX5G2QqZoNfiXQWT2iZ728dkjLeHKaaV57nKptMqWww0amFwqXC3utAKVA_O6SZWNSZEHLsk2dVKTNTmcrazlJExPfQQ3J15PUw2U1cua58bDHZmjLdGDJ1ggKhA5DVveuty7lyOh9fgjcEYr1Tp594D30cGKLZqaX4fAEDFETbMhnUOq3VzlwhhtTFaYA5BEL4YtN4acgOBHh2_fw1-vok3kmTAe8mcFBDtS7qtTSfPVP_LGnnWqFtK7klkQ34bAyFWJo6jw-1MhLcSmzFQByZgKlDy3OmNX1ZP_l0S2u5_aVKhsyI0gPqrA	\N
\.


--
-- TOC entry 3731 (class 0 OID 23026)
-- Dependencies: 217
-- Data for Name: Comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Comment" (id, text, creation_date, update_date, user_id, training_id) FROM stdin;
\.


--
-- TOC entry 3733 (class 0 OID 23042)
-- Dependencies: 219
-- Data for Name: Course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Course" (id, name, duration, link, creation_date, update_date) FROM stdin;
\.


--
-- TOC entry 3735 (class 0 OID 23058)
-- Dependencies: 221
-- Data for Name: CourseState; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CourseState" (id, is_completed, certificated, certificate_link, creation_date, update_date, user_id, course_id) FROM stdin;
\.


--
-- TOC entry 3732 (class 0 OID 23034)
-- Dependencies: 218
-- Data for Name: Like; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Like" (id, creation_date, update_date, user_id, note_id) FROM stdin;
\.


--
-- TOC entry 3730 (class 0 OID 23018)
-- Dependencies: 216
-- Data for Name: Note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Note" (id, text, creation_date, update_date, user_id, course_id) FROM stdin;
\.


--
-- TOC entry 3726 (class 0 OID 22985)
-- Dependencies: 212
-- Data for Name: Page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Page" (id, name, path, "isPublic", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3729 (class 0 OID 23010)
-- Dependencies: 215
-- Data for Name: Position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Position" (id, name, creation_date, update_date) FROM stdin;
\.


--
-- TOC entry 3727 (class 0 OID 22994)
-- Dependencies: 213
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Role" (id, name, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3725 (class 0 OID 22978)
-- Dependencies: 211
-- Data for Name: Session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Session" (id, "sessionToken", "userId", expires) FROM stdin;
clhfnl6kj0005sjb68gg5z8p9	56ed407b-b942-4fb7-b2f9-83001dcd0a89	clhfnl6k10000sjb659m9gco5	2023-06-08 02:29:17.826
clhfnng5s0005sj1llkwvrcoc	eb318d35-c386-4c27-be4f-d620927575ef	clhfnng5k0000sj1lxsh1otg3	2023-06-08 02:31:03.568
clhfno12d000bsj1ldan28xfp	8fd062b0-5785-436d-90c5-dbc05d90167b	clhfno1210006sj1le39ecp38	2023-06-08 02:31:30.66
\.


--
-- TOC entry 3734 (class 0 OID 23050)
-- Dependencies: 220
-- Data for Name: Training; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Training" (id, name, description, creation_date, update_date) FROM stdin;
\.


--
-- TOC entry 3728 (class 0 OID 23002)
-- Dependencies: 214
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, email, "emailVerified", name, phone, address, photo_link, image, creation_date, update_date, position_id, document) FROM stdin;
clhfnl6k10000sjb659m9gco5	algo@gmail.com	\N	algo	\N	\N	\N	https://s.gravatar.com/avatar/3386aef6eaa4422f565d5fa844769b10?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fal.png	2023-05-09 02:29:17.808	2023-05-09 02:29:17.808	\N	\N
clhfnng5k0000sj1lxsh1otg3	refiga7930@larland.com	\N	refiga7930	\N	\N	\N	https://s.gravatar.com/avatar/cdbbebd79fb6a1736c60f3138d682319?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fre.png	2023-05-09 02:31:03.561	2023-05-09 02:31:03.561	\N	\N
clhfno1210006sj1le39ecp38	perdedor	\N	prueba	\N	\N	\N	https://s.gravatar.com/avatar/9055b5ae314930538431a48bcaa900b9?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fpr.png	2023-05-09 02:31:30.649	2023-05-09 02:31:30.649	\N	\N
\.


--
-- TOC entry 3738 (class 0 OID 23076)
-- Dependencies: 224
-- Data for Name: _CourseToTraining; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_CourseToTraining" ("A", "B") FROM stdin;
\.


--
-- TOC entry 3736 (class 0 OID 23066)
-- Dependencies: 222
-- Data for Name: _PageToRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_PageToRole" ("A", "B") FROM stdin;
\.


--
-- TOC entry 3737 (class 0 OID 23071)
-- Dependencies: 223
-- Data for Name: _RoleToUser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_RoleToUser" ("A", "B") FROM stdin;
\.


--
-- TOC entry 3739 (class 0 OID 23081)
-- Dependencies: 225
-- Data for Name: _TrainingToUser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_TrainingToUser" ("A", "B") FROM stdin;
\.


--
-- TOC entry 3723 (class 0 OID 22956)
-- Dependencies: 209
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
8e83ceaf-6698-4553-8ba7-0dd5aabdf31a	e9c60dc6797fb38e95e19a3021204061fd39a747cb9614b09d083dd0c9e90632	2023-05-08 21:28:57.12073-05	20230508233019_	\N	\N	2023-05-08 21:28:57.077971-05	1
046fda1d-427b-4928-a017-f68b027df589	d78cab6489633a403d361bdf0cfa26583f1e3ebac51f5331ba9c899e1affec51	2023-05-08 21:28:57.122648-05	20230509001747_	\N	\N	2023-05-08 21:28:57.121028-05	1
\.


--
-- TOC entry 3740 (class 0 OID 23698)
-- Dependencies: 226
-- Data for Name: user_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_audit (id, email, "emailVerified", name, phone, address, photo_link, image, position_id, document, audit_id, op, stamp, "user") FROM stdin;
15824j12b4iu1bo	jnjksda	2023-05-09 19:21:27.214	fwadsa	\N	\N	\N	asdasd	\N	\N	2	I	2023-05-09 19:21:27.21369	postgres
15824j12b4iu1bo	jnjksda	2023-05-09 19:21:27.214	fwadsa	\N	\N	\N	asdasd	\N	\N	5	D	2023-05-09 19:41:28.548265	postgres
clhfno1210006sj1le39ecp38	perdedor	\N	prueba	\N	\N	\N	https://s.gravatar.com/avatar/9055b5ae314930538431a48bcaa900b9?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fpr.png	\N	\N	6	U	2023-05-09 19:42:26.488539	postgres
\.


--
-- TOC entry 3748 (class 0 OID 0)
-- Dependencies: 227
-- Name: user_audit_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_audit_audit_id_seq', 6, true);


--
-- TOC entry 3521 (class 2606 OID 22977)
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY (id);


--
-- TOC entry 3543 (class 2606 OID 23033)
-- Name: Comment Comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_pkey" PRIMARY KEY (id);


--
-- TOC entry 3553 (class 2606 OID 23065)
-- Name: CourseState CourseState_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CourseState"
    ADD CONSTRAINT "CourseState_pkey" PRIMARY KEY (id);


--
-- TOC entry 3548 (class 2606 OID 23049)
-- Name: Course Course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_pkey" PRIMARY KEY (id);


--
-- TOC entry 3545 (class 2606 OID 23041)
-- Name: Like Like_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_pkey" PRIMARY KEY (id);


--
-- TOC entry 3541 (class 2606 OID 23025)
-- Name: Note Note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_pkey" PRIMARY KEY (id);


--
-- TOC entry 3529 (class 2606 OID 22993)
-- Name: Page Page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Page"
    ADD CONSTRAINT "Page_pkey" PRIMARY KEY (id);


--
-- TOC entry 3539 (class 2606 OID 23017)
-- Name: Position Position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Position"
    ADD CONSTRAINT "Position_pkey" PRIMARY KEY (id);


--
-- TOC entry 3532 (class 2606 OID 23001)
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- TOC entry 3524 (class 2606 OID 22984)
-- Name: Session Session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_pkey" PRIMARY KEY (id);


--
-- TOC entry 3551 (class 2606 OID 23057)
-- Name: Training Training_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Training"
    ADD CONSTRAINT "Training_pkey" PRIMARY KEY (id);


--
-- TOC entry 3536 (class 2606 OID 23009)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3519 (class 2606 OID 22964)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3563 (class 2606 OID 23719)
-- Name: user_audit user_audit_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_audit
    ADD CONSTRAINT user_audit_pk PRIMARY KEY (audit_id);


--
-- TOC entry 3522 (class 1259 OID 23086)
-- Name: Account_provider_providerAccountId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON public."Account" USING btree (provider, "providerAccountId");


--
-- TOC entry 3546 (class 1259 OID 23093)
-- Name: Course_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Course_name_key" ON public."Course" USING btree (name);


--
-- TOC entry 3526 (class 1259 OID 23088)
-- Name: Page_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Page_name_key" ON public."Page" USING btree (name);


--
-- TOC entry 3527 (class 1259 OID 23089)
-- Name: Page_path_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Page_path_key" ON public."Page" USING btree (path);


--
-- TOC entry 3537 (class 1259 OID 23092)
-- Name: Position_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Position_name_key" ON public."Position" USING btree (name);


--
-- TOC entry 3530 (class 1259 OID 23090)
-- Name: Role_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Role_name_key" ON public."Role" USING btree (name);


--
-- TOC entry 3525 (class 1259 OID 23087)
-- Name: Session_sessionToken_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Session_sessionToken_key" ON public."Session" USING btree ("sessionToken");


--
-- TOC entry 3549 (class 1259 OID 23094)
-- Name: Training_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Training_name_key" ON public."Training" USING btree (name);


--
-- TOC entry 3533 (class 1259 OID 23198)
-- Name: User_document_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_document_key" ON public."User" USING btree (document);


--
-- TOC entry 3534 (class 1259 OID 23091)
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- TOC entry 3558 (class 1259 OID 23099)
-- Name: _CourseToTraining_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_CourseToTraining_AB_unique" ON public."_CourseToTraining" USING btree ("A", "B");


--
-- TOC entry 3559 (class 1259 OID 23100)
-- Name: _CourseToTraining_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_CourseToTraining_B_index" ON public."_CourseToTraining" USING btree ("B");


--
-- TOC entry 3554 (class 1259 OID 23095)
-- Name: _PageToRole_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_PageToRole_AB_unique" ON public."_PageToRole" USING btree ("A", "B");


--
-- TOC entry 3555 (class 1259 OID 23096)
-- Name: _PageToRole_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_PageToRole_B_index" ON public."_PageToRole" USING btree ("B");


--
-- TOC entry 3556 (class 1259 OID 23097)
-- Name: _RoleToUser_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_RoleToUser_AB_unique" ON public."_RoleToUser" USING btree ("A", "B");


--
-- TOC entry 3557 (class 1259 OID 23098)
-- Name: _RoleToUser_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_RoleToUser_B_index" ON public."_RoleToUser" USING btree ("B");


--
-- TOC entry 3560 (class 1259 OID 23101)
-- Name: _TrainingToUser_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_TrainingToUser_AB_unique" ON public."_TrainingToUser" USING btree ("A", "B");


--
-- TOC entry 3561 (class 1259 OID 23102)
-- Name: _TrainingToUser_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_TrainingToUser_B_index" ON public."_TrainingToUser" USING btree ("B");


--
-- TOC entry 3583 (class 2620 OID 23745)
-- Name: User insert_user_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_user_trigger AFTER INSERT OR DELETE OR UPDATE ON public."User" FOR EACH ROW EXECUTE FUNCTION public.audit_user_insert();


--
-- TOC entry 3564 (class 2606 OID 23103)
-- Name: Account Account_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3570 (class 2606 OID 23133)
-- Name: Comment Comment_training_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_training_id_fkey" FOREIGN KEY (training_id) REFERENCES public."Training"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3569 (class 2606 OID 23128)
-- Name: Comment Comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3574 (class 2606 OID 23153)
-- Name: CourseState CourseState_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CourseState"
    ADD CONSTRAINT "CourseState_course_id_fkey" FOREIGN KEY (course_id) REFERENCES public."Course"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3573 (class 2606 OID 23148)
-- Name: CourseState CourseState_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CourseState"
    ADD CONSTRAINT "CourseState_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3572 (class 2606 OID 23143)
-- Name: Like Like_note_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_note_id_fkey" FOREIGN KEY (note_id) REFERENCES public."Note"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3571 (class 2606 OID 23138)
-- Name: Like Like_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Like"
    ADD CONSTRAINT "Like_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3568 (class 2606 OID 23123)
-- Name: Note Note_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_course_id_fkey" FOREIGN KEY (course_id) REFERENCES public."Course"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3567 (class 2606 OID 23118)
-- Name: Note Note_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3565 (class 2606 OID 23108)
-- Name: Session Session_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3566 (class 2606 OID 23113)
-- Name: User User_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_position_id_fkey" FOREIGN KEY (position_id) REFERENCES public."Position"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3579 (class 2606 OID 23178)
-- Name: _CourseToTraining _CourseToTraining_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_CourseToTraining"
    ADD CONSTRAINT "_CourseToTraining_A_fkey" FOREIGN KEY ("A") REFERENCES public."Course"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3580 (class 2606 OID 23183)
-- Name: _CourseToTraining _CourseToTraining_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_CourseToTraining"
    ADD CONSTRAINT "_CourseToTraining_B_fkey" FOREIGN KEY ("B") REFERENCES public."Training"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3575 (class 2606 OID 23158)
-- Name: _PageToRole _PageToRole_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_PageToRole"
    ADD CONSTRAINT "_PageToRole_A_fkey" FOREIGN KEY ("A") REFERENCES public."Page"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3576 (class 2606 OID 23163)
-- Name: _PageToRole _PageToRole_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_PageToRole"
    ADD CONSTRAINT "_PageToRole_B_fkey" FOREIGN KEY ("B") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3577 (class 2606 OID 23168)
-- Name: _RoleToUser _RoleToUser_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_RoleToUser"
    ADD CONSTRAINT "_RoleToUser_A_fkey" FOREIGN KEY ("A") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3578 (class 2606 OID 23173)
-- Name: _RoleToUser _RoleToUser_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_RoleToUser"
    ADD CONSTRAINT "_RoleToUser_B_fkey" FOREIGN KEY ("B") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3581 (class 2606 OID 23188)
-- Name: _TrainingToUser _TrainingToUser_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_TrainingToUser"
    ADD CONSTRAINT "_TrainingToUser_A_fkey" FOREIGN KEY ("A") REFERENCES public."Training"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3582 (class 2606 OID 23193)
-- Name: _TrainingToUser _TrainingToUser_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_TrainingToUser"
    ADD CONSTRAINT "_TrainingToUser_B_fkey" FOREIGN KEY ("B") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2023-05-09 19:46:41 -05

--
-- PostgreSQL database dump complete
--

