SET password_encryption = 'scram-sha-256';
CREATE ROLE repuser WITH REPLICATION PASSWORD 'changeme' LOGIN;
SELECT * FROM pg_create_physical_replication_slot('replica_1_slot');
CREATE TABLE public.contact (
sr integer NOT NULL,
name text NOT NULL,
phone_num character varying(15) NOT NULL,
msg text NOT NULL,
date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
email character varying(50) NOT NULL
);
CREATE SEQUENCE public.contact_sr_no_seq
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;
ALTER SEQUENCE public.contact_sr_no_seq OWNED BY public.contact.sr;
CREATE TABLE public.posts (
sr integer NOT NULL,
title character varying(200) NOT NULL,
tagline character varying(50) NOT NULL,
img_file character varying(50) NOT NULL,
slug character varying(25) NOT NULL,
content character varying(500) NOT NULL,
date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE SEQUENCE public.posts_sr_no_seq
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;
ALTER SEQUENCE public.posts_sr_no_seq OWNED BY public.posts.sr;
CREATE TABLE public.users (
srno integer NOT NULL,
psswd bytea NOT NULL,
email character varying(60) NOT NULL,
creation_time timestamp without time zone NOT NULL
);
CREATE SEQUENCE public.users_srno_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;
ALTER SEQUENCE public.users_srno_seq OWNED BY public.users.srno;
ALTER TABLE ONLY public.contact ALTER COLUMN sr SET DEFAULT nextval('public.contact_sr_no_seq'::regclass);
ALTER TABLE ONLY public.posts ALTER COLUMN sr SET DEFAULT nextval('public.posts_sr_no_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN srno SET DEFAULT nextval('public.users_srno_seq'::regclass);
GRANT SELECT ON TABLE public.contact TO admin;
GRANT SELECT ON TABLE public.posts TO admin;
GRANT SELECT ON TABLE public.users TO admin;