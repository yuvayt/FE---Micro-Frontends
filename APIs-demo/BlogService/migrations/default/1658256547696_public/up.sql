SET check_function_bodies = false;

DROP TABLE IF EXISTS public.tag CASCADE;
DROP SEQUENCE IF EXISTS public.tag_id_seq CASCADE;
DROP TABLE IF EXISTS public.post_tag CASCADE;
DROP TABLE IF EXISTS public.comment CASCADE;
DROP SEQUENCE IF EXISTS public.comment_id_seq CASCADE;
DROP TABLE IF EXISTS public.post CASCADE;
DROP TABLE IF EXISTS public.blog_category CASCADE;

CREATE TABLE public.blog_category (
    id integer NOT NULL,
    title character varying NOT NULL,
    slug character varying,
    number_post integer DEFAULT 0
);
CREATE TABLE public.comment (
    id integer NOT NULL,
    email bpchar NOT NULL,
    content character varying NOT NULL,
    create_at date NOT NULL,
    update_at date NOT NULL,
    post_id integer
);
CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;
CREATE TABLE public.post (
    id integer NOT NULL,
    title character varying NOT NULL,
    slug character varying,
    content character varying NOT NULL,
    sumary character varying NOT NULL,
    is_related boolean NOT NULL,
    create_at date NOT NULL,
    update_at date NOT NULL,
    image character varying NOT NULL,
    category_id integer,
    user_id integer NOT NULL
);
CREATE TABLE public.post_tag (
    tag_id integer NOT NULL,
    post_id integer NOT NULL
);
CREATE TABLE public.tag (
    id integer NOT NULL,
    title character varying NOT NULL,
    post_id integer
);
CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;
ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);
ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);
ALTER TABLE ONLY public.blog_category
    ADD CONSTRAINT blog_category_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.post_tag
    ADD CONSTRAINT post_tag_pkey PRIMARY KEY (tag_id, post_id);
ALTER TABLE ONLY public.post_tag
    ADD CONSTRAINT post_tag_post_id_key UNIQUE (post_id);
ALTER TABLE ONLY public.post_tag
    ADD CONSTRAINT post_tag_tag_id_key UNIQUE (tag_id);
ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_id_fkey FOREIGN KEY (id) REFERENCES public.blog_category(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.post_tag
    ADD CONSTRAINT post_tag_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.post_tag
    ADD CONSTRAINT post_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
