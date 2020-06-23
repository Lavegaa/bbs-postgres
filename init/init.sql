CREATE DATABASE board
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Korean_Korea.949'
    LC_CTYPE = 'Korean_Korea.949'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

\c board

CREATE TABLE public.boardmaster
(
    bd_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9999999 CACHE 1 ),
    bd_subject text COLLATE pg_catalog."default" NOT NULL,
    bd_intro text COLLATE pg_catalog."default" NOT NULL,
    bd_type character varying(20) COLLATE pg_catalog."default" NOT NULL,
    bd_use_at character(1) COLLATE pg_catalog."default" NOT NULL,
    bd_create_date timestamp without time zone,
    CONSTRAINT bd_pri PRIMARY KEY (bd_subject)
)

TABLESPACE pg_default;

ALTER TABLE public.boardmaster
    OWNER to postgres;

CREATE TABLE public."user"
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999 CACHE 1 ),
    uid text COLLATE pg_catalog."default" NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    "isAdmin" boolean NOT NULL,
    salt text COLLATE pg_catalog."default" NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE public."user"
    OWNER to postgres;

CREATE TABLE public.userboard
(
    ub_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9999999 CACHE 1 ),
    ub_subject text COLLATE pg_catalog."default" NOT NULL,
    ub_description text COLLATE pg_catalog."default" NOT NULL,
    ub_host text COLLATE pg_catalog."default" NOT NULL,
    ub_create_date timestamp without time zone NOT NULL,
    ub_type text COLLATE pg_catalog."default",
    CONSTRAINT ub_fk FOREIGN KEY (ub_type)
        REFERENCES public.boardmaster (bd_subject) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public.userboard
    OWNER to postgres;
-- Index: fki_ub_fk

-- DROP INDEX public.fki_ub_fk;

CREATE INDEX fki_ub_fk
    ON public.userboard USING btree
    (ub_subject COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;