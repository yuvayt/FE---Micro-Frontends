SET check_function_bodies = false;
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.address (
    id integer NOT NULL,
    country_id integer DEFAULT 0 NOT NULL,
    city_id integer DEFAULT 0 NOT NULL,
    district_id integer DEFAULT 0 NOT NULL,
    ward_id integer DEFAULT 0 NOT NULL,
    street character varying NOT NULL,
    user_id integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.address_id_seq OWNED BY public.address.id;
CREATE TABLE public.city (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    country_id integer DEFAULT 0 NOT NULL
);
CREATE SEQUENCE public.city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;
CREATE TABLE public.country (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.country_id_seq OWNED BY public.country.id;
CREATE TABLE public.district (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    city_id integer DEFAULT 0 NOT NULL
);
CREATE SEQUENCE public.district_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.district_id_seq OWNED BY public.district.id;
CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    firstname character varying,
    lastname character varying,
    billing_address integer DEFAULT 0 NOT NULL,
    shipping_address integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    mobile_number integer
);
CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
CREATE TABLE public.ward (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    district_id integer DEFAULT 0 NOT NULL
);
CREATE SEQUENCE public.ward_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.ward_id_seq OWNED BY public.ward.id;
ALTER TABLE ONLY public.address ALTER COLUMN id SET DEFAULT nextval('public.address_id_seq'::regclass);
ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);
ALTER TABLE ONLY public.country ALTER COLUMN id SET DEFAULT nextval('public.country_id_seq'::regclass);
ALTER TABLE ONLY public.district ALTER COLUMN id SET DEFAULT nextval('public.district_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.ward ALTER COLUMN id SET DEFAULT nextval('public.ward_id_seq'::regclass);
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.ward
    ADD CONSTRAINT ward_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_address_updated_at BEFORE UPDATE ON public.address FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_address_updated_at ON public.address IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_city_updated_at BEFORE UPDATE ON public.city FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_city_updated_at ON public.city IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_country_updated_at BEFORE UPDATE ON public.country FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_country_updated_at ON public.country IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_district_updated_at BEFORE UPDATE ON public.district FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_district_updated_at ON public.district IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_users_updated_at ON public.users IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_ward_updated_at BEFORE UPDATE ON public.ward FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_ward_updated_at ON public.ward IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(id) ON DELETE SET NULL;
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(id) ON DELETE SET NULL;
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_district_id_fkey FOREIGN KEY (district_id) REFERENCES public.district(id) ON DELETE SET NULL;
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT;
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_ward_id_fkey FOREIGN KEY (ward_id) REFERENCES public.ward(id) ON DELETE SET NULL;
ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(id) ON DELETE RESTRICT;
ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(id) ON DELETE RESTRICT;
ALTER TABLE ONLY public.ward
    ADD CONSTRAINT ward_district_id_fkey FOREIGN KEY (district_id) REFERENCES public.district(id) ON DELETE RESTRICT;
