--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Ubuntu 16.8-0ubuntu0.24.10.1)
-- Dumped by pg_dump version 16.8 (Ubuntu 16.8-0ubuntu0.24.10.1)

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
-- Name: achats; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.achats (
    ac_id integer NOT NULL,
    fo_id integer,
    ac_date date DEFAULT now() NOT NULL,
    ac_etat smallint DEFAULT 0 NOT NULL,
    rec_etat smallint DEFAULT 0,
    id_bt integer,
    id_user integer,
    CONSTRAINT achats_check2 CHECK ((ac_etat = ANY (ARRAY[0, 1]))),
    CONSTRAINT achats_check3 CHECK ((rec_etat = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.achats OWNER TO md;

--
-- Name: achats_ac_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.achats_ac_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.achats_ac_id_seq OWNER TO md;

--
-- Name: achats_ac_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.achats_ac_id_seq OWNED BY public.achats.ac_id;


--
-- Name: acontenu; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.acontenu (
    aco_id integer NOT NULL,
    ac_id integer,
    pr_id integer,
    aco_qte integer NOT NULL,
    pu integer,
    CONSTRAINT acontenu_check1 CHECK ((aco_qte > 0)),
    CONSTRAINT acontenu_check2 CHECK ((pu > 0))
);


ALTER TABLE public.acontenu OWNER TO md;

--
-- Name: acontenu_aco_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.acontenu_aco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.acontenu_aco_id_seq OWNER TO md;

--
-- Name: acontenu_aco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.acontenu_aco_id_seq OWNED BY public.acontenu.aco_id;


--
-- Name: apaiements; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.apaiements (
    ap_id integer NOT NULL,
    ac_id integer,
    ap_date date DEFAULT now(),
    ap_motif character varying(100) NOT NULL,
    ap_montant integer NOT NULL,
    CONSTRAINT apaiements_check1 CHECK ((ap_date <= now())),
    CONSTRAINT apaiements_check2 CHECK ((ap_montant > 0))
);


ALTER TABLE public.apaiements OWNER TO md;

--
-- Name: apaiements_ap_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.apaiements_ap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.apaiements_ap_id_seq OWNER TO md;

--
-- Name: apaiements_ap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.apaiements_ap_id_seq OWNED BY public.apaiements.ap_id;


--
-- Name: boutique; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.boutique (
    id_bt integer NOT NULL,
    nom_bt character varying(60) NOT NULL,
    num_bt integer NOT NULL,
    adresse_bt character varying(60),
    tel_bt character varying(60),
    etat_bt integer,
    id_dg integer
);


ALTER TABLE public.boutique OWNER TO md;

--
-- Name: boutique_id_bt_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.boutique_id_bt_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.boutique_id_bt_seq OWNER TO md;

--
-- Name: boutique_id_bt_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.boutique_id_bt_seq OWNED BY public.boutique.id_bt;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.clients (
    cl_id integer NOT NULL,
    cl_nom character varying(50) NOT NULL,
    cl_adresse character varying(80),
    cl_tel character varying(20),
    type character varying(20) NOT NULL,
    id_bt integer
);


ALTER TABLE public.clients OWNER TO md;

--
-- Name: clients_cl_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.clients_cl_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_cl_id_seq OWNER TO md;

--
-- Name: clients_cl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.clients_cl_id_seq OWNED BY public.clients.cl_id;


--
-- Name: depenses; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.depenses (
    de_id integer NOT NULL,
    de_motif character varying(100) NOT NULL,
    de_date date DEFAULT now(),
    de_montant integer,
    id_bt integer,
    de_time time without time zone DEFAULT now(),
    id_user integer,
    CONSTRAINT depenses_check1 CHECK ((de_date <= now())),
    CONSTRAINT depenses_check2 CHECK ((de_montant >= 100))
);


ALTER TABLE public.depenses OWNER TO md;

--
-- Name: depenses_de_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.depenses_de_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.depenses_de_id_seq OWNER TO md;

--
-- Name: depenses_de_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.depenses_de_id_seq OWNED BY public.depenses.de_id;


--
-- Name: dg; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.dg (
    id_dg integer NOT NULL,
    nom_dg character varying(50) NOT NULL,
    prenom_dg character varying(50),
    tel_dg character varying(60),
    adresse_dg character varying(60),
    etat_dg integer,
    type_dg character varying(30),
    username character varying(50) NOT NULL,
    dgpass character varying(255),
    dgipass character varying(50),
    code character varying(50),
    dgimg character varying(255)
);


ALTER TABLE public.dg OWNER TO md;

--
-- Name: dg_id_dg_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.dg_id_dg_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dg_id_dg_seq OWNER TO md;

--
-- Name: dg_id_dg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.dg_id_dg_seq OWNED BY public.dg.id_dg;


--
-- Name: fournisseurs; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.fournisseurs (
    fo_id integer NOT NULL,
    fo_nom character varying(50) NOT NULL,
    fo_adresse character varying(80) NOT NULL,
    fo_tel character varying(50) NOT NULL,
    fo_email character varying(50),
    id_dg integer,
    id_bt integer
);


ALTER TABLE public.fournisseurs OWNER TO md;

--
-- Name: fournisseurs_fo_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.fournisseurs_fo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fournisseurs_fo_id_seq OWNER TO md;

--
-- Name: fournisseurs_fo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.fournisseurs_fo_id_seq OWNED BY public.fournisseurs.fo_id;


--
-- Name: lcontenu; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.lcontenu (
    lco_id integer NOT NULL,
    li_id integer,
    pr_id integer,
    lco_qte integer,
    CONSTRAINT lcontenu_check1 CHECK ((lco_qte >= 0))
);


ALTER TABLE public.lcontenu OWNER TO md;

--
-- Name: lcontenu_lco_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.lcontenu_lco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lcontenu_lco_id_seq OWNER TO md;

--
-- Name: lcontenu_lco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.lcontenu_lco_id_seq OWNED BY public.lcontenu.lco_id;


--
-- Name: livraison; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.livraison (
    li_id integer NOT NULL,
    ve_id integer,
    li_date date DEFAULT now(),
    li_etat smallint DEFAULT 0,
    CONSTRAINT livraison_check1 CHECK ((li_date <= now()))
);


ALTER TABLE public.livraison OWNER TO md;

--
-- Name: livraison_li_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.livraison_li_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livraison_li_id_seq OWNER TO md;

--
-- Name: livraison_li_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.livraison_li_id_seq OWNED BY public.livraison.li_id;


--
-- Name: paiements; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.paiements (
    pa_id integer NOT NULL,
    pe_id integer,
    pa_date date,
    mois smallint,
    montant integer NOT NULL,
    CONSTRAINT paiements_check1 CHECK ((pa_date <= now())),
    CONSTRAINT paiements_check2 CHECK (((mois >= 1) AND (mois <= 12))),
    CONSTRAINT paiements_check3 CHECK ((montant >= 5000))
);


ALTER TABLE public.paiements OWNER TO md;

--
-- Name: paiements_pa_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.paiements_pa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paiements_pa_id_seq OWNER TO md;

--
-- Name: paiements_pa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.paiements_pa_id_seq OWNED BY public.paiements.pa_id;


--
-- Name: personnels; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.personnels (
    pe_id integer NOT NULL,
    pe_nom character varying(30) NOT NULL,
    pe_prenom character varying(30) NOT NULL,
    pe_sexe character(1),
    pe_tel character varying(50),
    po_id integer,
    salaire integer NOT NULL,
    id_bt integer,
    CONSTRAINT personnels_check1 CHECK ((pe_sexe = ANY (ARRAY['H'::bpchar, 'F'::bpchar]))),
    CONSTRAINT personnels_check2 CHECK ((salaire >= 40000))
);


ALTER TABLE public.personnels OWNER TO md;

--
-- Name: personnels_pe_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.personnels_pe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personnels_pe_id_seq OWNER TO md;

--
-- Name: personnels_pe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.personnels_pe_id_seq OWNED BY public.personnels.pe_id;


--
-- Name: poste; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.poste (
    po_id integer NOT NULL,
    po_nom character varying(30) NOT NULL,
    id_bt integer
);


ALTER TABLE public.poste OWNER TO md;

--
-- Name: poste_po_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.poste_po_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.poste_po_id_seq OWNER TO md;

--
-- Name: poste_po_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.poste_po_id_seq OWNED BY public.poste.po_id;


--
-- Name: produits; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.produits (
    pr_id integer NOT NULL,
    pr_nom character varying(40) NOT NULL,
    reference character varying(40) NOT NULL,
    pr_stock integer DEFAULT 0,
    prix_vente integer NOT NULL,
    pu integer,
    id_bt integer,
    CONSTRAINT produits_check1 CHECK ((prix_vente > 0)),
    CONSTRAINT produits_check2 CHECK ((pr_stock > '-1'::integer))
);


ALTER TABLE public.produits OWNER TO md;

--
-- Name: produits_pr_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.produits_pr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produits_pr_id_seq OWNER TO md;

--
-- Name: produits_pr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.produits_pr_id_seq OWNED BY public.produits.pr_id;


--
-- Name: rcontenu; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.rcontenu (
    rco_id integer NOT NULL,
    re_id integer,
    pr_id integer,
    rco_qte integer,
    CONSTRAINT rcontenu_check1 CHECK ((rco_qte >= 0))
);


ALTER TABLE public.rcontenu OWNER TO md;

--
-- Name: rcontenu_rco_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.rcontenu_rco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rcontenu_rco_id_seq OWNER TO md;

--
-- Name: rcontenu_rco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.rcontenu_rco_id_seq OWNED BY public.rcontenu.rco_id;


--
-- Name: reception; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.reception (
    re_id integer NOT NULL,
    ac_id integer,
    re_date date DEFAULT now(),
    re_etat smallint DEFAULT 0,
    CONSTRAINT receptions_check CHECK ((re_date <= now()))
);


ALTER TABLE public.reception OWNER TO md;

--
-- Name: reception_re_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.reception_re_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reception_re_id_seq OWNER TO md;

--
-- Name: reception_re_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.reception_re_id_seq OWNED BY public.reception.re_id;


--
-- Name: scontenu; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.scontenu (
    sco_id integer NOT NULL,
    so_id integer,
    pr_id integer,
    sco_qte integer,
    CONSTRAINT scontenu_check1 CHECK ((sco_qte > 0))
);


ALTER TABLE public.scontenu OWNER TO md;

--
-- Name: scontenu_sco_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.scontenu_sco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scontenu_sco_id_seq OWNER TO md;

--
-- Name: scontenu_sco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.scontenu_sco_id_seq OWNED BY public.scontenu.sco_id;


--
-- Name: sorties; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.sorties (
    so_id integer NOT NULL,
    so_motif character varying(100) NOT NULL,
    so_date timestamp without time zone DEFAULT now(),
    id_bt integer
);


ALTER TABLE public.sorties OWNER TO md;

--
-- Name: sorties_so_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.sorties_so_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sorties_so_id_seq OWNER TO md;

--
-- Name: sorties_so_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.sorties_so_id_seq OWNED BY public.sorties.so_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.users (
    id_user integer NOT NULL,
    nom_user character varying(50) NOT NULL,
    val_user integer DEFAULT 0,
    type_user character varying(30),
    password character varying(255),
    ipass character varying(50),
    id_bt integer,
    id_dg integer,
    uimg character varying(255)
);


ALTER TABLE public.users OWNER TO md;

--
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_user_seq OWNER TO md;

--
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;


--
-- Name: vcontenu; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.vcontenu (
    vco_id integer NOT NULL,
    ve_id integer,
    pr_id integer,
    vco_qte integer NOT NULL,
    pu integer NOT NULL,
    CONSTRAINT vcontenu_check1 CHECK ((vco_qte > 0)),
    CONSTRAINT vcontenu_check2 CHECK ((pu > 0))
);


ALTER TABLE public.vcontenu OWNER TO md;

--
-- Name: vcontenu_vco_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.vcontenu_vco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vcontenu_vco_id_seq OWNER TO md;

--
-- Name: vcontenu_vco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.vcontenu_vco_id_seq OWNED BY public.vcontenu.vco_id;


--
-- Name: ventes; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.ventes (
    ve_id integer NOT NULL,
    cl_id integer,
    ve_date date DEFAULT now() NOT NULL,
    liv_etat smallint DEFAULT 0,
    ve_etat smallint,
    id_bt integer,
    id_user integer,
    ve_time time without time zone DEFAULT now(),
    CONSTRAINT ventes_check1 CHECK ((liv_etat = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.ventes OWNER TO md;

--
-- Name: ventes_ve_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.ventes_ve_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventes_ve_id_seq OWNER TO md;

--
-- Name: ventes_ve_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.ventes_ve_id_seq OWNED BY public.ventes.ve_id;


--
-- Name: vpaiements; Type: TABLE; Schema: public; Owner: md
--

CREATE TABLE public.vpaiements (
    vp_id integer NOT NULL,
    ve_id integer,
    vp_date timestamp without time zone DEFAULT now(),
    vp_motif character varying(100) NOT NULL,
    vp_montant integer NOT NULL,
    CONSTRAINT vpaiements_check1 CHECK ((vp_date <= now())),
    CONSTRAINT vpaiements_check2 CHECK ((vp_montant > 0))
);


ALTER TABLE public.vpaiements OWNER TO md;

--
-- Name: vpaiements_vp_id_seq; Type: SEQUENCE; Schema: public; Owner: md
--

CREATE SEQUENCE public.vpaiements_vp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vpaiements_vp_id_seq OWNER TO md;

--
-- Name: vpaiements_vp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: md
--

ALTER SEQUENCE public.vpaiements_vp_id_seq OWNED BY public.vpaiements.vp_id;


--
-- Name: achats ac_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.achats ALTER COLUMN ac_id SET DEFAULT nextval('public.achats_ac_id_seq'::regclass);


--
-- Name: acontenu aco_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.acontenu ALTER COLUMN aco_id SET DEFAULT nextval('public.acontenu_aco_id_seq'::regclass);


--
-- Name: apaiements ap_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.apaiements ALTER COLUMN ap_id SET DEFAULT nextval('public.apaiements_ap_id_seq'::regclass);


--
-- Name: boutique id_bt; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.boutique ALTER COLUMN id_bt SET DEFAULT nextval('public.boutique_id_bt_seq'::regclass);


--
-- Name: clients cl_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.clients ALTER COLUMN cl_id SET DEFAULT nextval('public.clients_cl_id_seq'::regclass);


--
-- Name: depenses de_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.depenses ALTER COLUMN de_id SET DEFAULT nextval('public.depenses_de_id_seq'::regclass);


--
-- Name: dg id_dg; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.dg ALTER COLUMN id_dg SET DEFAULT nextval('public.dg_id_dg_seq'::regclass);


--
-- Name: fournisseurs fo_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.fournisseurs ALTER COLUMN fo_id SET DEFAULT nextval('public.fournisseurs_fo_id_seq'::regclass);


--
-- Name: lcontenu lco_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.lcontenu ALTER COLUMN lco_id SET DEFAULT nextval('public.lcontenu_lco_id_seq'::regclass);


--
-- Name: livraison li_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.livraison ALTER COLUMN li_id SET DEFAULT nextval('public.livraison_li_id_seq'::regclass);


--
-- Name: paiements pa_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.paiements ALTER COLUMN pa_id SET DEFAULT nextval('public.paiements_pa_id_seq'::regclass);


--
-- Name: personnels pe_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.personnels ALTER COLUMN pe_id SET DEFAULT nextval('public.personnels_pe_id_seq'::regclass);


--
-- Name: poste po_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.poste ALTER COLUMN po_id SET DEFAULT nextval('public.poste_po_id_seq'::regclass);


--
-- Name: produits pr_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.produits ALTER COLUMN pr_id SET DEFAULT nextval('public.produits_pr_id_seq'::regclass);


--
-- Name: rcontenu rco_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.rcontenu ALTER COLUMN rco_id SET DEFAULT nextval('public.rcontenu_rco_id_seq'::regclass);


--
-- Name: reception re_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.reception ALTER COLUMN re_id SET DEFAULT nextval('public.reception_re_id_seq'::regclass);


--
-- Name: scontenu sco_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.scontenu ALTER COLUMN sco_id SET DEFAULT nextval('public.scontenu_sco_id_seq'::regclass);


--
-- Name: sorties so_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.sorties ALTER COLUMN so_id SET DEFAULT nextval('public.sorties_so_id_seq'::regclass);


--
-- Name: users id_user; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);


--
-- Name: vcontenu vco_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.vcontenu ALTER COLUMN vco_id SET DEFAULT nextval('public.vcontenu_vco_id_seq'::regclass);


--
-- Name: ventes ve_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.ventes ALTER COLUMN ve_id SET DEFAULT nextval('public.ventes_ve_id_seq'::regclass);


--
-- Name: vpaiements vp_id; Type: DEFAULT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.vpaiements ALTER COLUMN vp_id SET DEFAULT nextval('public.vpaiements_vp_id_seq'::regclass);


--
-- Data for Name: achats; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.achats (ac_id, fo_id, ac_date, ac_etat, rec_etat, id_bt, id_user) FROM stdin;
3	7	2021-04-15	1	\N	1	\N
10	3	2022-06-25	1	0	1	\N
4	6	2022-05-21	1	0	1	\N
12	6	2022-06-25	1	0	1	\N
13	3	2022-06-24	1	0	1	\N
14	3	2023-12-15	1	0	1	\N
15	7	2023-12-19	1	0	1	\N
16	7	2023-12-21	1	0	1	\N
17	21	2024-05-20	1	0	\N	\N
20	21	2024-08-14	0	0	\N	\N
21	24	2024-08-20	0	0	\N	\N
22	24	2024-08-19	0	0	\N	\N
23	24	2024-08-19	0	0	\N	\N
24	24	2024-12-07	1	0	\N	\N
25	25	2024-12-13	1	0	\N	\N
26	24	2025-02-07	1	0	\N	\N
27	25	2025-02-07	0	0	\N	\N
28	3	2025-02-07	0	0	\N	\N
29	25	2025-02-07	0	0	\N	\N
30	25	2025-02-07	0	0	\N	\N
31	25	2025-02-07	0	0	\N	\N
32	25	2025-02-07	0	0	\N	\N
37	26	2025-02-08	1	0	6	\N
33	25	2025-02-14	1	0	6	\N
38	26	2025-02-08	1	0	6	\N
39	26	2025-02-08	0	0	6	\N
40	28	2025-02-08	1	0	6	\N
41	30	2025-04-28	1	0	7	\N
45	21	2025-05-01	0	0	1	\N
43	30	2025-04-29	1	0	7	\N
44	34	2025-04-29	1	0	7	\N
\.


--
-- Data for Name: acontenu; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.acontenu (aco_id, ac_id, pr_id, aco_qte, pu) FROM stdin;
7	3	9	15	200
9	3	2	15	200
16	12	9	50	50000
19	13	9	4	40000
20	14	1	6	4000
22	14	16	10	100000
23	15	17	12	100000
24	15	16	16	100000
25	16	15	200	150
26	16	4	100	3000
27	16	3	500	500
28	17	9	50	1000
29	24	19	100	12000
30	24	3	1000	500
31	25	18	10	450000
32	26	21	16	1000
33	33	21	6	1000
34	37	21	3	1000
35	38	21	2	1000
36	40	23	15	4000
37	40	22	150	50
38	41	24	60	150000
39	41	25	30	50000
40	43	26	13	123
41	43	24	1234	150000
42	43	25	1	50000
44	44	26	15	123
\.


--
-- Data for Name: apaiements; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.apaiements (ap_id, ac_id, ap_date, ap_motif, ap_montant) FROM stdin;
14	12	2022-06-22	tranche 3	2000000
15	12	2023-12-15	end	500000
18	14	2023-12-18	final	1000000
19	14	2023-12-18	end	24000
20	15	2023-12-20	1er	2600000
25	15	2023-12-20	tout	200000
26	16	2023-12-21	Tout	580000
27	17	2024-05-20	payer	50000
28	25	2024-12-13	1et tranche	2500000
29	26	2025-02-07	TOTAL P	16000
30	37	2025-02-08	TOUS	3000
31	41	2025-04-28	1er tranche	9800000
32	41	2025-04-28	2ème tranche	600000
33	44	2025-05-01	fac	1845
\.


--
-- Data for Name: boutique; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.boutique (id_bt, nom_bt, num_bt, adresse_bt, tel_bt, etat_bt, id_dg) FROM stdin;
1	ANKA	1	Faladje socoro	20 10 52 80	1	7
3	Yayou	2	Fala	10101010	0	7
5	Web-service	10	ACI 2000	60 60 60 60	0	7
6	RMD-BOO	17	BAKO	66 60 87 89	0	7
7	RM-Word-Service sarl	19	BKO	66660000	0	7
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.clients (cl_id, cl_nom, cl_adresse, cl_tel, type, id_bt) FROM stdin;
1	TOURE awa	aci2000	62-12-60-45	Personne	1
2	Togouna	faladje	66-12-60-41	Societe	1
3	SY ali	badala	66-12-60-60	Personne	1
4	Sarl	kalaban	66-12-60-40	Societe	1
5	Baramuso	bozola	66-12-60-42	Societe	1
6	Satoutou	aci 2000	12131254	societe_prive	1
10	yqy	wert	60562138		1
11	Sore	faladie	75201956	prive	3
12	Mourou	Sogoniko 	74147447	Ong	3
9	Femmes	Faladie socoro	20 20 23 45	ong-MALI	1
13	Diver	inconu	inconu	inconu@inconu.ml	1
14	SOBE	zert	57281728	ONG	1
7	Homme	qwertyu	509765233	ong	1
15	MS	BKO	71147141	ONG	6
16	CD-RS	KATI	90909090	Private	6
17	Divers	div			7
18	Daoud	Kalanba	66609090	ONG	7
\.


--
-- Data for Name: depenses; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.depenses (de_id, de_motif, de_date, de_montant, id_bt, de_time, id_user) FROM stdin;
10	test01	2024-04-16	100000	1	12:52:41.731825	4
9	Don	2024-04-15	50000	1	\N	4
7	Eau Janvier	2024-01-02	18000	1	\N	4
11	zerty20	2024-08-11	220000	1	23:26:05.890444	4
3	tranche 	2022-07-01	55000	1	\N	4
15	EAU	2025-02-08	1000	6	01:08:53.89282	9
16	Électricité 	2025-04-28	10000	7	18:26:22.99179	10
\.


--
-- Data for Name: dg; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.dg (id_dg, nom_dg, prenom_dg, tel_dg, adresse_dg, etat_dg, type_dg, username, dgpass, dgipass, code, dgimg) FROM stdin;
8	DIABATE 	Moussa 	66608789	Faladie 	1	admin	admin	e22dd5dabde45eda5a1a67772c8e25dd	1760	5050	\N
10	BT RMD	RMD BT	76608789	BKO	1	dg	md	3bff829dde3583558708865f6de7be37	6513	1010	\N
7	DIALLO	MAFA	60809076	bara	1	dg	diallo	fcd04e26e900e94b9ed6dd604fed2b64	0002	0045	\N
\.


--
-- Data for Name: fournisseurs; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.fournisseurs (fo_id, fo_nom, fo_adresse, fo_tel, fo_email, id_dg, id_bt) FROM stdin;
6	Societe KOUMA	ACI 2000	99 88 77 00	kouma@gmail.com	7	1
7	Societe DA	Kati	99 88 77 66	daou@gmail.com	7	1
3	meta	bagadaji	75 95 11 07	four3@domaine.com	7	1
21	PUB	ACI	20211019	pub@ml,ml	7	1
18	yaya DIALLO	niamakro	70 70 70 70 	yaya.ml@ml.com	7	1
24	RMD-gs	FALADIE	70707075	rmd@ml.com	7	1
25	MADANE	azerty	162789797	md@gmail.com	7	1
26	META	SOGONIKO	76767676	meta@ml.ml	\N	6
28	MAHA	ACI 200	3276589	mh@gmail.com	\N	6
29	ALIO BAH	Sotiba	20202425	Alihou@gmail.com	\N	6
30	INCO	INCO	12		\N	7
34	BABA	Faladie	12345679	baba@baba	\N	7
\.


--
-- Data for Name: lcontenu; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.lcontenu (lco_id, li_id, pr_id, lco_qte) FROM stdin;
8	7	9	0
6	6	9	5
16	11	2	8
22	13	15	50
20	13	4	10
21	13	3	30
24	14	9	7
23	14	19	0
25	15	9	1
26	15	2	3
27	16	2	25
29	18	15	50
32	20	4	5
33	20	3	70
34	21	22	45
35	21	23	2
36	21	21	3
37	22	22	40
39	23	3	40
38	23	1	2
40	24	24	15
41	25	24	0
42	25	26	0
43	25	25	0
44	26	24	0
45	26	26	0
46	26	25	0
\.


--
-- Data for Name: livraison; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.livraison (li_id, ve_id, li_date, li_etat) FROM stdin;
4	10	2022-07-01	0
6	13	2022-07-02	0
7	13	2022-07-02	0
11	16	2023-12-14	0
13	18	2023-12-21	0
14	20	2024-03-08	0
15	22	2024-05-11	0
16	59	2024-06-30	0
18	61	2024-06-30	0
20	64	2024-12-13	0
21	68	2025-02-08	0
22	69	2025-02-08	0
23	66	2025-02-13	0
24	70	2025-04-28	0
25	71	2025-05-01	0
26	71	2025-05-01	0
\.


--
-- Data for Name: paiements; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.paiements (pa_id, pe_id, pa_date, mois, montant) FROM stdin;
\.


--
-- Data for Name: personnels; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.personnels (pe_id, pe_nom, pe_prenom, pe_sexe, pe_tel, po_id, salaire, id_bt) FROM stdin;
3	malle	Abou	H	20202116	3	200000	1
4	Ada	Abou	F	76101226	8	45000	3
6	DIALLO	Cheikna	F	69543210	1	500000	1
7	MARIAM	BAH	F	20232450	12	150000	6
8	RM	MD	H	12345678	13	100000	7
\.


--
-- Data for Name: poste; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.poste (po_id, po_nom, id_bt) FROM stdin;
1	comptable	1
2	caissier	1
3	gerant	1
4	technicien-de-surface	1
5	agent-securite	1
7	my	1
8	chef	3
12	COMPTABLE	6
13	DGA	7
\.


--
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.produits (pr_id, pr_nom, reference, pr_stock, prix_vente, pu, id_bt) FROM stdin;
15	PP	Boisson	0	200	150	1
2	huile	dinor	0	1000	500	1
3	savons	super	0	6000	500	1
4	savons	koulikoro	0	4000	3000	1
17	Tecno	spark 10	0	110000	100000	1
16	samsung	A10	0	110000	100000	1
18	TV	ecran plas	0	500000	450000	1
9	Boisson01	planete	0	2500	1000	1
19	NURA	lait	0	15000	12000	3
1	Lait	NIDO	0	6000	3500	1
21	LAIT	NIDO	0	2500	1000	6
22	CAFE	Nes-Cafe	0	150	50	6
23	HUIL	AES	0	5000	4000	6
24	ORDINATEUR	HP	0	300000	150000	7
25	PRINT	HP	0	175000	50000	7
26	azer	sdf	0	1566	123	7
\.


--
-- Data for Name: rcontenu; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.rcontenu (rco_id, re_id, pr_id, rco_qte) FROM stdin;
19	6	9	2
21	6	2	3
14	4	9	3
16	4	2	1
46	15	9	0
48	15	2	0
49	16	9	3
51	18	9	1
55	20	9	4
62	23	16	16
61	23	17	12
60	22	16	10
59	22	1	6
65	25	15	200
66	25	4	100
67	25	3	500
68	26	9	50
69	27	18	10
70	28	21	16
71	29	21	6
72	30	21	3
73	31	21	2
75	32	22	145
74	32	23	10
76	33	24	60
77	33	25	30
78	34	26	0
79	34	24	0
80	34	25	0
81	35	26	15
\.


--
-- Data for Name: reception; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.reception (re_id, ac_id, re_date, re_etat) FROM stdin;
6	3	2022-06-11	1
4	3	2021-04-14	1
15	3	2022-06-11	0
16	13	2022-06-25	1
18	13	2022-06-25	1
20	12	2022-07-02	1
23	15	2023-12-18	1
22	14	2023-12-18	1
25	16	2023-12-21	1
26	17	2024-05-20	1
27	25	2024-12-13	0
28	26	2025-02-07	1
29	33	2025-02-07	1
30	37	2025-02-08	1
31	38	2025-02-08	1
32	40	2025-02-08	0
33	41	2025-04-28	1
34	43	2025-05-01	0
35	44	2025-05-01	1
\.


--
-- Data for Name: scontenu; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.scontenu (sco_id, so_id, pr_id, sco_qte) FROM stdin;
\.


--
-- Data for Name: sorties; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.sorties (so_id, so_motif, so_date, id_bt) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.users (id_user, nom_user, val_user, type_user, password, ipass, id_bt, id_dg, uimg) FROM stdin;
8	ali	1	gerant	81dc9bdb52d04dc20036dbd8313ed055	1234	3	7	\N
5	diabate	1	gerant	5bf8aaef51c6e0d363cbe554acaf3f20	4125	1	7	\N
6	Yaya	1	agen	fa246d0262c3925617b0c72bb20eeb1d	9999	1	7	\N
9	bah	1	agen	81dc9bdb52d04dc20036dbd8313ed055	1234	6	\N	\N
4	RMD	1	gerant	e22dd5dabde45eda5a1a67772c8e25dd	1760	1	7	\N
10	MD	1	gerant	81dc9bdb52d04dc20036dbd8313ed055	1234	7	\N	\N
\.


--
-- Data for Name: vcontenu; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.vcontenu (vco_id, ve_id, pr_id, vco_qte, pu) FROM stdin;
7	3	9	1	2000
9	3	2	2	1000
15	13	9	10	200
17	11	9	4	250
26	16	2	8	1000
32	18	4	10	4000
33	18	3	30	6000
31	18	15	50	200
35	20	19	4	15000
34	20	9	7	2500
36	22	9	1	2500
69	22	2	3	1000
70	55	9	5	2500
71	55	1	5	5000
72	55	18	4	500000
73	55	2	10	1000
74	55	19	100	15000
75	55	3	15	6000
76	55	15	2	200
77	55	4	4	4000
78	55	16	3	110000
79	55	17	4	110000
81	59	2	50	1000
82	60	9	20	2500
83	61	15	50	200
84	62	9	3	2500
85	63	9	6	2500
86	63	4	20	4000
87	64	4	5	4000
88	64	3	70	6000
89	66	1	2	6000
90	66	3	40	6000
91	68	22	45	150
92	68	23	2	5000
93	68	21	3	2500
94	69	22	400	150
95	70	24	15	300000
96	71	24	20	300000
97	71	26	5	1566
98	71	25	30	175000
\.


--
-- Data for Name: ventes; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.ventes (ve_id, cl_id, ve_date, liv_etat, ve_etat, id_bt, id_user, ve_time) FROM stdin;
3	3	2021-06-13	\N	\N	1	\N	\N
4	4	2021-06-14	\N	\N	1	\N	\N
5	5	2021-06-14	\N	\N	1	\N	\N
6	5	2022-06-25	0	\N	1	\N	\N
7	4	2022-07-01	0	\N	1	\N	\N
9	2	2022-07-01	0	\N	1	\N	\N
10	6	2022-07-01	0	1	1	\N	\N
13	5	2022-07-02	0	1	1	\N	\N
11	5	2022-07-02	0	1	1	\N	\N
14	6	2023-12-13	0	\N	1	\N	\N
15	7	2023-12-14	0	\N	1	\N	\N
16	7	2023-12-14	0	1	1	\N	\N
18	7	2023-12-21	0	1	1	\N	\N
19	7	2024-01-11	0	\N	1	\N	\N
20	7	2024-03-08	0	1	1	4	\N
21	9	2024-03-12	0	\N	1	4	\N
22	7	2024-03-17	0	1	1	4	\N
55	7	2024-05-11	0	1	1	4	\N
56	12	2024-05-19	0	\N	1	4	\N
57	12	2024-05-20	0	\N	1	4	\N
58	12	2024-05-20	0	\N	1	4	\N
59	12	2024-05-20	0	1	1	4	\N
60	6	2024-05-20	0	1	1	4	14:16:35.688019
61	7	2024-06-30	0	1	1	4	10:47:31.692272
62	9	2024-06-30	0	\N	1	4	11:01:56.951621
63	7	2024-07-05	0	1	1	4	21:08:51.189197
64	14	2024-12-13	0	1	1	4	23:11:33.402329
65	5	2024-12-17	0	\N	1	4	16:03:43.520816
66	13	2024-12-17	0	1	1	4	16:11:11.043553
67	15	2025-02-08	0	\N	6	9	00:56:12.517858
68	15	2025-02-08	0	1	6	9	00:59:31.259972
69	16	2025-02-08	0	1	6	9	01:33:43.308062
70	17	2025-04-28	0	1	7	10	18:24:25.415742
71	18	2025-05-01	0	1	7	10	16:14:08.426994
\.


--
-- Data for Name: vpaiements; Type: TABLE DATA; Schema: public; Owner: md
--

COPY public.vpaiements (vp_id, ve_id, vp_date, vp_motif, vp_montant) FROM stdin;
3	10	2022-07-02 00:00:00	tranche 3	50000
11	10	2022-07-02 13:22:02.262293	tranche 1	50000
1	10	2022-07-02 00:00:00	tranche 2	60000
12	13	2022-07-02 14:03:07.704076	tranche 1	2000
13	13	2022-07-02 14:03:26.90087	tranche 2	2000
14	13	2022-07-02 14:04:36.597507	tranche 3	2000
15	11	2023-12-13 17:40:49.084916		1000
18	16	2023-12-15 15:28:47.040183	final	1
19	16	2023-12-15 15:30:10.048492	final	7999
21	18	2023-12-21 17:02:59.45815	Tout	230000
22	20	2024-03-08 00:32:25.352052	planete	2500
23	22	2024-05-11 00:22:44.016882	p	5000
24	22	2024-05-11 00:23:24.480009	2	500
25	55	2024-05-12 18:40:28.452919	1er	3000000
26	59	2024-06-30 10:41:58.818014	1er	25000
27	64	2024-12-13 23:14:45.467066	toto	440000
28	66	2024-12-17 16:13:19.372466	1er tranche	250000
29	68	2025-02-08 01:07:16.570941	TOTAL R	14250
30	68	2025-02-08 01:07:36.162155	RSET	10000
31	69	2025-02-08 01:36:16.399477	tout	60000
32	66	2025-02-13 00:27:08.617217	tout	2000
33	61	2025-02-13 00:28:19.25089	tout	9000
34	61	2025-02-13 00:29:18.424742	tout	1000
\.


--
-- Name: achats_ac_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.achats_ac_id_seq', 45, true);


--
-- Name: acontenu_aco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.acontenu_aco_id_seq', 44, true);


--
-- Name: apaiements_ap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.apaiements_ap_id_seq', 33, true);


--
-- Name: boutique_id_bt_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.boutique_id_bt_seq', 7, true);


--
-- Name: clients_cl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.clients_cl_id_seq', 18, true);


--
-- Name: depenses_de_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.depenses_de_id_seq', 16, true);


--
-- Name: dg_id_dg_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.dg_id_dg_seq', 10, true);


--
-- Name: fournisseurs_fo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.fournisseurs_fo_id_seq', 34, true);


--
-- Name: lcontenu_lco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.lcontenu_lco_id_seq', 46, true);


--
-- Name: livraison_li_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.livraison_li_id_seq', 26, true);


--
-- Name: paiements_pa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.paiements_pa_id_seq', 1, false);


--
-- Name: personnels_pe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.personnels_pe_id_seq', 8, true);


--
-- Name: poste_po_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.poste_po_id_seq', 13, true);


--
-- Name: produits_pr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.produits_pr_id_seq', 26, true);


--
-- Name: rcontenu_rco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.rcontenu_rco_id_seq', 81, true);


--
-- Name: reception_re_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.reception_re_id_seq', 35, true);


--
-- Name: scontenu_sco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.scontenu_sco_id_seq', 1, false);


--
-- Name: sorties_so_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.sorties_so_id_seq', 1, false);


--
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.users_id_user_seq', 10, true);


--
-- Name: vcontenu_vco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.vcontenu_vco_id_seq', 98, true);


--
-- Name: ventes_ve_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.ventes_ve_id_seq', 71, true);


--
-- Name: vpaiements_vp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: md
--

SELECT pg_catalog.setval('public.vpaiements_vp_id_seq', 34, true);


--
-- Name: achats achats_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.achats
    ADD CONSTRAINT achats_pkey PRIMARY KEY (ac_id);


--
-- Name: acontenu acontenu_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.acontenu
    ADD CONSTRAINT acontenu_pkey PRIMARY KEY (aco_id);


--
-- Name: acontenu acontenu_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.acontenu
    ADD CONSTRAINT acontenu_unique1 UNIQUE (ac_id, pr_id);


--
-- Name: apaiements apaiements_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.apaiements
    ADD CONSTRAINT apaiements_pkey PRIMARY KEY (ap_id);


--
-- Name: boutique bt_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.boutique
    ADD CONSTRAINT bt_pkey PRIMARY KEY (id_bt);


--
-- Name: boutique bt_unique; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.boutique
    ADD CONSTRAINT bt_unique UNIQUE (nom_bt, num_bt);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (cl_id);


--
-- Name: clients clients_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_unique1 UNIQUE (cl_nom);


--
-- Name: depenses depenses_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.depenses
    ADD CONSTRAINT depenses_pkey PRIMARY KEY (de_id);


--
-- Name: dg dg_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.dg
    ADD CONSTRAINT dg_pkey PRIMARY KEY (id_dg);


--
-- Name: dg dg_unique; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.dg
    ADD CONSTRAINT dg_unique UNIQUE (nom_dg, prenom_dg, tel_dg);


--
-- Name: fournisseurs fournisseurs_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.fournisseurs
    ADD CONSTRAINT fournisseurs_pkey PRIMARY KEY (fo_id);


--
-- Name: fournisseurs fournisseurs_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.fournisseurs
    ADD CONSTRAINT fournisseurs_unique1 UNIQUE (fo_nom);


--
-- Name: fournisseurs fournisseurs_unique2; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.fournisseurs
    ADD CONSTRAINT fournisseurs_unique2 UNIQUE (fo_adresse);


--
-- Name: fournisseurs fournisseurs_unique3; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.fournisseurs
    ADD CONSTRAINT fournisseurs_unique3 UNIQUE (fo_tel);


--
-- Name: fournisseurs fournisseurs_unique4; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.fournisseurs
    ADD CONSTRAINT fournisseurs_unique4 UNIQUE (fo_email);


--
-- Name: lcontenu lcontenu_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.lcontenu
    ADD CONSTRAINT lcontenu_pkey PRIMARY KEY (lco_id);


--
-- Name: lcontenu lcontenu_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.lcontenu
    ADD CONSTRAINT lcontenu_unique1 UNIQUE (li_id, pr_id);


--
-- Name: livraison livraison_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_pkey PRIMARY KEY (li_id);


--
-- Name: paiements paiement_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiement_pkey PRIMARY KEY (pa_id);


--
-- Name: personnels perso_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT perso_pkey PRIMARY KEY (pe_id);


--
-- Name: personnels personnels_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT personnels_unique1 UNIQUE (pe_nom, pe_prenom);


--
-- Name: personnels personnels_unique2; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT personnels_unique2 UNIQUE (pe_tel);


--
-- Name: poste poste_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_pkey PRIMARY KEY (po_id);


--
-- Name: poste poste_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_unique1 UNIQUE (po_nom);


--
-- Name: produits produits_key; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_key PRIMARY KEY (pr_id);


--
-- Name: produits produits_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_unique1 UNIQUE (pr_nom, reference);


--
-- Name: rcontenu rcontenu_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.rcontenu
    ADD CONSTRAINT rcontenu_pkey PRIMARY KEY (rco_id);


--
-- Name: rcontenu rcontenu_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.rcontenu
    ADD CONSTRAINT rcontenu_unique1 UNIQUE (re_id, pr_id);


--
-- Name: reception receptions_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.reception
    ADD CONSTRAINT receptions_pkey PRIMARY KEY (re_id);


--
-- Name: scontenu scontenu_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.scontenu
    ADD CONSTRAINT scontenu_pkey PRIMARY KEY (sco_id);


--
-- Name: scontenu scontenu_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.scontenu
    ADD CONSTRAINT scontenu_unique1 UNIQUE (so_id, pr_id);


--
-- Name: sorties sortie_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.sorties
    ADD CONSTRAINT sortie_pkey PRIMARY KEY (so_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- Name: vcontenu vcontenu_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.vcontenu
    ADD CONSTRAINT vcontenu_pkey PRIMARY KEY (vco_id);


--
-- Name: vcontenu vcontenu_unique1; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.vcontenu
    ADD CONSTRAINT vcontenu_unique1 UNIQUE (ve_id, pr_id);


--
-- Name: ventes ventes_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_pkey PRIMARY KEY (ve_id);


--
-- Name: vpaiements vpaiements_pkey; Type: CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.vpaiements
    ADD CONSTRAINT vpaiements_pkey PRIMARY KEY (vp_id);


--
-- Name: achats ac_fkey_dg; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.achats
    ADD CONSTRAINT ac_fkey_dg FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: achats ac_fkey_user; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.achats
    ADD CONSTRAINT ac_fkey_user FOREIGN KEY (id_user) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: achats achats_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.achats
    ADD CONSTRAINT achats_fkey FOREIGN KEY (fo_id) REFERENCES public.fournisseurs(fo_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acontenu acontenu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.acontenu
    ADD CONSTRAINT acontenu_fkey FOREIGN KEY (ac_id) REFERENCES public.achats(ac_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: acontenu acontenu_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.acontenu
    ADD CONSTRAINT acontenu_fkey1 FOREIGN KEY (pr_id) REFERENCES public.produits(pr_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: apaiements apaiements_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.apaiements
    ADD CONSTRAINT apaiements_fkey FOREIGN KEY (ac_id) REFERENCES public.achats(ac_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: boutique bt_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.boutique
    ADD CONSTRAINT bt_fkey FOREIGN KEY (id_dg) REFERENCES public.dg(id_dg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: clients cl_fkey_bt; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT cl_fkey_bt FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: depenses de_fkey_bt; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.depenses
    ADD CONSTRAINT de_fkey_bt FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fournisseurs fkey_dg_id; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.fournisseurs
    ADD CONSTRAINT fkey_dg_id FOREIGN KEY (id_dg) REFERENCES public.dg(id_dg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: depenses fkey_user_id; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.depenses
    ADD CONSTRAINT fkey_user_id FOREIGN KEY (id_user) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lcontenu lcontenu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.lcontenu
    ADD CONSTRAINT lcontenu_fkey FOREIGN KEY (li_id) REFERENCES public.livraison(li_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lcontenu lcontenu_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.lcontenu
    ADD CONSTRAINT lcontenu_fkey1 FOREIGN KEY (pr_id) REFERENCES public.produits(pr_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: livraison livraison_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_fkey FOREIGN KEY (ve_id) REFERENCES public.ventes(ve_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: paiements paiements_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_fkey FOREIGN KEY (pe_id) REFERENCES public.personnels(pe_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personnels pe_fkey_bt; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT pe_fkey_bt FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personnels personnels_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.personnels
    ADD CONSTRAINT personnels_fkey1 FOREIGN KEY (po_id) REFERENCES public.poste(po_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: poste po_fkey_bt; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT po_fkey_bt FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: produits pr_fkey_bt; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.produits
    ADD CONSTRAINT pr_fkey_bt FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rcontenu rcontenu_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.rcontenu
    ADD CONSTRAINT rcontenu_fkey1 FOREIGN KEY (re_id) REFERENCES public.reception(re_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rcontenu rcontenu_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.rcontenu
    ADD CONSTRAINT rcontenu_fkey2 FOREIGN KEY (pr_id) REFERENCES public.produits(pr_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reception receptions_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.reception
    ADD CONSTRAINT receptions_fkey1 FOREIGN KEY (ac_id) REFERENCES public.achats(ac_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: scontenu scontenu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.scontenu
    ADD CONSTRAINT scontenu_fkey FOREIGN KEY (so_id) REFERENCES public.sorties(so_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: scontenu scontenu_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.scontenu
    ADD CONSTRAINT scontenu_fkey1 FOREIGN KEY (pr_id) REFERENCES public.produits(pr_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sorties so_fkey_bt; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.sorties
    ADD CONSTRAINT so_fkey_bt FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users user_fkey01; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_fkey01 FOREIGN KEY (id_dg) REFERENCES public.dg(id_dg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users user_fkey02; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_fkey02 FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vcontenu vcontenu_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.vcontenu
    ADD CONSTRAINT vcontenu_fkey1 FOREIGN KEY (ve_id) REFERENCES public.ventes(ve_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vcontenu vcontenu_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.vcontenu
    ADD CONSTRAINT vcontenu_fkey2 FOREIGN KEY (pr_id) REFERENCES public.produits(pr_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ventes ve_fkey_bt; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ve_fkey_bt FOREIGN KEY (id_bt) REFERENCES public.boutique(id_bt) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ventes ve_fkey_user; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ve_fkey_user FOREIGN KEY (id_user) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ventes ventes_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_fkey FOREIGN KEY (cl_id) REFERENCES public.clients(cl_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vpaiements vpaiements_fkey; Type: FK CONSTRAINT; Schema: public; Owner: md
--

ALTER TABLE ONLY public.vpaiements
    ADD CONSTRAINT vpaiements_fkey FOREIGN KEY (ve_id) REFERENCES public.ventes(ve_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

