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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: games; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.games (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    status character varying DEFAULT 'active'::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: server_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.server_details (
    id bigint NOT NULL,
    server_id uuid NOT NULL,
    name character varying NOT NULL,
    ip character varying NOT NULL,
    port integer NOT NULL,
    current_map character varying NOT NULL,
    max_players integer NOT NULL,
    current_players integer NOT NULL,
    players_in_queue integer NOT NULL,
    total_rounds integer NOT NULL,
    rounds_played integer NOT NULL,
    game_type character varying NOT NULL,
    is_ranked boolean DEFAULT true NOT NULL,
    has_punkbuster boolean DEFAULT true NOT NULL,
    is_official_server boolean DEFAULT false NOT NULL,
    country character varying NOT NULL,
    battlelog_game_id character varying NOT NULL,
    favorites character varying NOT NULL,
    server_link character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: server_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.server_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: server_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.server_details_id_seq OWNED BY public.server_details.id;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: server_details id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_details ALTER COLUMN id SET DEFAULT nextval('public.server_details_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: server_details server_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_details
    ADD CONSTRAINT server_details_pkey PRIMARY KEY (id);


--
-- Name: servers servers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);


--
-- Name: index_servers_on_game_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_servers_on_game_id ON public.servers USING btree (game_id);


--
-- Name: servers fk_rails_0c6fc59a85; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT fk_rails_0c6fc59a85 FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: server_details fk_rails_f3f871a2ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_details
    ADD CONSTRAINT fk_rails_f3f871a2ab FOREIGN KEY (server_id) REFERENCES public.servers(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20211208161326'),
('20211210163239'),
('20211213194903'),
('20211213195410');


