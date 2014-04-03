--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: dependent_steps; Type: TABLE; Schema: public; Owner: catappuser; Tablespace: 
--

CREATE TABLE dependent_steps (
    recipe integer NOT NULL,
    step  integer NOT NULL,
    dependant integer NOT NULL
);


ALTER TABLE public.dependent_steps OWNER TO catappuser;

--
-- Name: likes; Type: TABLE; Schema: public; Owner: catappuser; Tablespace: 
--

CREATE TABLE likes (
    user_id integer NOT NULL,
    recipe_id integer NOT NULL
);


ALTER TABLE public.likes OWNER TO catappuser;

--
-- Name: recipes; Type: TABLE; Schema: public; Owner: catappuser; Tablespace: 
--

CREATE TABLE recipes (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255) DEFAULT NULL::character varying,
    picture_url character varying(255) DEFAULT NULL::character varying,
    user_id integer NOT NULL
);


ALTER TABLE public.recipes OWNER TO catappuser;

--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: catappuser
--

CREATE SEQUENCE recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipes_id_seq OWNER TO catappuser;

--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catappuser
--

ALTER SEQUENCE recipes_id_seq OWNED BY recipes.id;


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catappuser
--

SELECT pg_catalog.setval('recipes_id_seq', 1, false);


--
-- Name: step_types; Type: TABLE; Schema: public; Owner: catappuser; Tablespace: 
--

CREATE TABLE step_types (
    id integer NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    icon_url character varying(255) DEFAULT NULL::character varying,
    description character varying(255) DEFAULT NULL::character varying,
    html character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.step_types OWNER TO catappuser;

--
-- Name: step_types_id_seq; Type: SEQUENCE; Schema: public; Owner: catappuser
--

CREATE SEQUENCE step_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.step_types_id_seq OWNER TO catappuser;

--
-- Name: step_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catappuser
--

ALTER SEQUENCE step_types_id_seq OWNED BY step_types.id;


--
-- Name: step_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catappuser
--

SELECT pg_catalog.setval('step_types_id_seq', 1, false);


--
-- Name: steps; Type: TABLE; Schema: public; Owner: catappuser; Tablespace: 
--

CREATE TABLE steps (
    recipe integer NOT NULL,
    seq integer,
    type integer,
    instructions character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.steps OWNER TO catappuser;

--
-- Name: users; Type: TABLE; Schema: public; Owner: catappuser; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    created integer NOT NULL,
    modified integer NOT NULL,
    token character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO catappuser;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: catappuser
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO catappuser;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catappuser
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catappuser
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: catappuser
--

ALTER TABLE ONLY recipes ALTER COLUMN id SET DEFAULT nextval('recipes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: catappuser
--

ALTER TABLE ONLY step_types ALTER COLUMN id SET DEFAULT nextval('step_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: catappuser
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: dependent_steps; Type: TABLE DATA; Schema: public; Owner: catappuser
--

INSERT INTO dependent_steps VALUES (15, 2, 1);
INSERT INTO dependent_steps VALUES (16, 2, 1);
INSERT INTO dependent_steps VALUES (17, 2, 1);
INSERT INTO dependent_steps VALUES (18, 3, 2);
INSERT INTO dependent_steps VALUES (20, 2, 1);
INSERT INTO dependent_steps VALUES (20, 1, 1);
INSERT INTO dependent_steps VALUES (21, 2, 1);
INSERT INTO dependent_steps VALUES (21, 1, 1);
INSERT INTO dependent_steps VALUES (22, 3, 2);
INSERT INTO dependent_steps VALUES (22, 2, 1);
INSERT INTO dependent_steps VALUES (22, 0, 1);


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: catappuser
--



--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: catappuser
--

INSERT INTO recipes VALUES (10, 'pate a choux', 'cream puff dough', NULL, 3);
INSERT INTO recipes VALUES (11, 'Pastry Cream', 'A custard used in French tarts', NULL, 3);
INSERT INTO recipes VALUES (13, 'Chocolate Mousse', 'A velvety dessert', NULL, 3);
INSERT INTO recipes VALUES (15, 'Carrot Muffins', 'the health-food junk-food snack', NULL, 3);
INSERT INTO recipes VALUES (16, 'blueberry muff', 'staple', NULL, 3);
INSERT INTO recipes VALUES (17, 'croissants', 'a flaky pastry', NULL, 3);
INSERT INTO recipes VALUES (18, 'Faux Gateux ', '', NULL, 4);
INSERT INTO recipes VALUES (19, 'Parapluie de Parmesan ', 'PARAPLUIE', NULL, 4);
INSERT INTO recipes VALUES (20, 'Pie D''Inception', 'its a pie, within a pie', NULL, 4);
INSERT INTO recipes VALUES (21, 'Tarte Blanche', 'Clean slate ', NULL, 4);
INSERT INTO recipes VALUES (22, 'Orange Muffins', 'These Muffins have Orange flavoring', NULL, 5);


--
-- Data for Name: step_types; Type: TABLE DATA; Schema: public; Owner: catappuser
--

INSERT INTO step_types VALUES (1, 'Bake', 'bake.png', 'Bake item in an oven', '<br><label>Enter instructions here</label><textarea class="recipe-textarea"></textarea><br>');
INSERT INTO step_types VALUES (2, 'Stir', 'stir.png', 'mix a bunch of ingredients', '<br><label>Enter instructions here</label><textarea class="recipe-textarea"></textarea>');
INSERT INTO step_types VALUES (3, 'Roll', 'roll.png', 'Roll out dough into a flat sheet', '<br><label>Enter instructions here</label> <textarea class="recipe-textarea"></textarea><br>');
INSERT INTO step_types VALUES (6, 'Chop', 'chop.png', 'Cut and slice', '<br><label>Enter instructions here</label> <textarea class="recipe-textarea"></textarea><br>');
INSERT INTO step_types VALUES (7, 'Chill', 'chill.png', 'Place in fridge until cool', '<br><label>Enter instructions here</label><textarea class="recipe-textarea"></textarea><br>');
INSERT INTO step_types VALUES (10, 'Ingredients', 'mipl.png', 'Mise-on-Place', '<br><label>Enter ingredients here</label> <textarea class="recipe-textarea"></textarea><br>');


--
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: catappuser
--

INSERT INTO steps VALUES (10, 1, 2, 'boil water with butter and salt');
INSERT INTO steps VALUES (10, 2, 2, 'mix in flour');
INSERT INTO steps VALUES (11, 1, 10, '3 eggs\n1 pt milk\n75g sugar');
INSERT INTO steps VALUES (11, 2, 2, 'Whisk to ribbon stage');
INSERT INTO steps VALUES (11, 3, 10, '1 pt milk\n75g sugar');
INSERT INTO steps VALUES (11, 4, 1, 'boil two ingredients together');
INSERT INTO steps VALUES (13, 1, 10, '1 pt cream\n3 eggs\n4 sheets gelatin');
INSERT INTO steps VALUES (15, 1, 10, 'eggs\nsugar \nil');
INSERT INTO steps VALUES (15, 2, 2, 'Stir all this together');
INSERT INTO steps VALUES (16, 1, 10, 'eggs\nmelted butter\nsugar');
INSERT INTO steps VALUES (16, 2, 2, 'cream ingredients together');
INSERT INTO steps VALUES (17, 1, 10, 'butter');
INSERT INTO steps VALUES (17, 2, 7, 'flatten butter into a square and chill');
INSERT INTO steps VALUES (18, 1, 10, 'Sugar 2 Kilos\nFlour 4 Kilos \nFaux 1 Kilo \nWater 5 Kilos');
INSERT INTO steps VALUES (18, 2, 7, 'Chill Faux for seven hours, thirty two minutes');
INSERT INTO steps VALUES (18, 3, 6, 'Chop Faux into small pieces ');
INSERT INTO steps VALUES (18, 4, 3, 'Roll faux into flour');
INSERT INTO steps VALUES (18, 5, 2, 'Stir flour, water, faux, sugar for twelve hours');
INSERT INTO steps VALUES (18, 6, 1, 'Bake into cake pan, 13 hours');
INSERT INTO steps VALUES (19, 1, 10, '4 Stone Parmesan \n1 Half Stone Lobster \n');
INSERT INTO steps VALUES (19, 2, 6, 'Chop the Lobster extensively ');
INSERT INTO steps VALUES (19, 3, 2, 'Stir the parmesan into the lobster over a boiling pot of water');
INSERT INTO steps VALUES (19, 4, 1, 'Bake for 7 minutes');
INSERT INTO steps VALUES (19, 5, 3, 'Roll into a thin sheet');
INSERT INTO steps VALUES (19, 6, 1, 'Bake for three hours at 450 degrees C');
INSERT INTO steps VALUES (20, 1, 10, 'Pie');
INSERT INTO steps VALUES (20, 2, 3, 'Roll the pie into a pie crust');
INSERT INTO steps VALUES (20, 3, 6, 'Chop the resulting pie, into more pie based pie');
INSERT INTO steps VALUES (20, 4, 1, 'BAKE THE PIES ');
INSERT INTO steps VALUES (21, 1, 10, 'Flour Five Kilos \nSugar Five Kilos \nWater Three Kilos ');
INSERT INTO steps VALUES (21, 2, 2, 'Stir ingredients in bowl for nine (9) minutes ');
INSERT INTO steps VALUES (21, 3, 3, 'Roll into Tarte Shape');
INSERT INTO steps VALUES (21, 4, 1, 'Bake it, or don''t');
INSERT INTO steps VALUES (22, 1, 10, 'Oranges \nOrange Peelz \nFlour\nSuger \nOrange Blossom Water');
INSERT INTO steps VALUES (22, 2, 6, 'CHOP THE ORANGES\nLEAVE NO ORANGE UNCHOPT');
INSERT INTO steps VALUES (22, 3, 2, 'EVERYTHING NEEDS TO BE STIRRED');
INSERT INTO steps VALUES (22, 4, 1, 'BUT IT IN MUFFIN TINS AND BAKE AT 500 DEGREES FOR 12 Minutes');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: catappuser
--

INSERT INTO users VALUES (3, 1355869061, 1355869061, '8586a9b087142c8440d4a6334819d5b753191096', '28bb23cb47d62588494400af5d26cba6b79df798', 'ah@hellskitchen.com', 'Gordon', 'Ramsey');
INSERT INTO users VALUES (4, 1356140402, 1356140402, '51915e396c899e3ac6f5c4493c8b31e5fec128ec', 'e9aba03b1ab689d65561d3816ffc6fe5ce552fcd', 'J.Child@FamousChefs.ie', 'Julia', 'Child');
INSERT INTO users VALUES (5, 1356142437, 1356142437, 'b8b0f58625e4c83bc4f8b366b543f3f30874b2c2', '0cd962f1153e5a33fc932bf9b79920306f52cee7', 'O.Jamie@chefs.au', 'Jamie ', 'Oliver');


--
-- Name: likes_pkey; Type: CONSTRAINT; Schema: public; Owner: catappuser; Tablespace: 
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (user_id, recipe_id);


--
-- Name: recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: catappuser; Tablespace: 
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: step_types_pkey; Type: CONSTRAINT; Schema: public; Owner: catappuser; Tablespace: 
--

ALTER TABLE ONLY step_types
    ADD CONSTRAINT step_types_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: catappuser; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: dependent_steps; Type: ACL; Schema: public; Owner: catappuser
--

REVOKE ALL ON TABLE dependent_steps FROM PUBLIC;
REVOKE ALL ON TABLE dependent_steps FROM catappuser;
GRANT ALL ON TABLE dependent_steps TO catappuser;
GRANT ALL ON TABLE dependent_steps TO pgn;


--
-- Name: likes; Type: ACL; Schema: public; Owner: catappuser
--

REVOKE ALL ON TABLE likes FROM PUBLIC;
REVOKE ALL ON TABLE likes FROM catappuser;
GRANT ALL ON TABLE likes TO catappuser;
GRANT ALL ON TABLE likes TO pgn;


--
-- Name: recipes; Type: ACL; Schema: public; Owner: catappuser
--

REVOKE ALL ON TABLE recipes FROM PUBLIC;
REVOKE ALL ON TABLE recipes FROM catappuser;
GRANT ALL ON TABLE recipes TO catappuser;
GRANT ALL ON TABLE recipes TO pgn;


--
-- Name: step_types; Type: ACL; Schema: public; Owner: catappuser
--

REVOKE ALL ON TABLE step_types FROM PUBLIC;
REVOKE ALL ON TABLE step_types FROM catappuser;
GRANT ALL ON TABLE step_types TO catappuser;
GRANT ALL ON TABLE step_types TO pgn;


--
-- Name: steps; Type: ACL; Schema: public; Owner: catappuser
--

REVOKE ALL ON TABLE steps FROM PUBLIC;
REVOKE ALL ON TABLE steps FROM catappuser;
GRANT ALL ON TABLE steps TO catappuser;
GRANT ALL ON TABLE steps TO pgn;


--
-- Name: users; Type: ACL; Schema: public; Owner: catappuser
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM catappuser;
GRANT ALL ON TABLE users TO catappuser;
GRANT ALL ON TABLE users TO pgn;


--
-- PostgreSQL database dump complete
--

