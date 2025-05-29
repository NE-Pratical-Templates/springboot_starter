--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1+b1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1+b1)

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
-- Name: deductions; Type: TABLE; Schema: public; Owner: jodos
--

CREATE TABLE public.deductions (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by uuid,
    updated_by uuid,
    code character varying(255),
    name character varying(255),
    percentage numeric(38,2)
);


ALTER TABLE public.deductions OWNER TO jodos;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: jodos
--

CREATE TABLE public.employees (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by uuid,
    updated_by uuid,
    activation_code character varying(255),
    activation_code_expires_at timestamp(6) without time zone,
    dob date,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    mobile character varying(255) NOT NULL,
    nationalid character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    status character varying(255),
    employee_id uuid,
    profile_image_id uuid,
    CONSTRAINT employees_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'RESET'::character varying, 'ACTIVE'::character varying, 'DEACTIVATED'::character varying])::text[])))
);


ALTER TABLE public.employees OWNER TO jodos;

--
-- Name: employments; Type: TABLE; Schema: public; Owner: jodos
--

CREATE TABLE public.employments (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by uuid,
    updated_by uuid,
    base_salary numeric(38,2),
    code character varying(255),
    department character varying(255),
    joining_date date,
    "position" character varying(255),
    status character varying(255),
    employee_id uuid,
    CONSTRAINT employments_status_check CHECK (((status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);


ALTER TABLE public.employments OWNER TO jodos;

--
-- Name: files; Type: TABLE; Schema: public; Owner: jodos
--

CREATE TABLE public.files (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by uuid,
    updated_by uuid,
    name character varying(255),
    path character varying(255),
    size integer,
    size_type character varying(255),
    status character varying(255),
    type character varying(255),
    CONSTRAINT files_size_type_check CHECK (((size_type)::text = ANY ((ARRAY['B'::character varying, 'KB'::character varying, 'MB'::character varying, 'GB'::character varying, 'TB'::character varying])::text[]))),
    CONSTRAINT files_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'SAVED'::character varying, 'FAILED'::character varying])::text[])))
);


ALTER TABLE public.files OWNER TO jodos;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: jodos
--

CREATE TABLE public.messages (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by uuid,
    updated_by uuid,
    banking_date_time timestamp(6) without time zone,
    message character varying(255),
    employee_id uuid
);


ALTER TABLE public.messages OWNER TO jodos;

--
-- Name: payslips; Type: TABLE; Schema: public; Owner: jodos
--

CREATE TABLE public.payslips (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    created_by uuid,
    updated_by uuid,
    employee_tax_amount numeric(38,2),
    gross_salary_amount numeric(38,2),
    "house-amount" numeric(38,2),
    medical_insurance_amount numeric(38,2),
    month integer,
    net_salary numeric(38,2),
    other_tax_amount numeric(38,2),
    pension_amount numeric(38,2),
    status character varying(255),
    transport_amount numeric(38,2),
    year integer,
    employee_id uuid,
    CONSTRAINT payslips_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'PAID'::character varying])::text[])))
);


ALTER TABLE public.payslips OWNER TO jodos;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: jodos
--

CREATE TABLE public.roles (
    id uuid NOT NULL,
    description character varying(255),
    name character varying(255),
    CONSTRAINT roles_name_check CHECK (((name)::text = ANY ((ARRAY['ADMIN'::character varying, 'MANAGER'::character varying, 'EMPLOYEE'::character varying])::text[])))
);


ALTER TABLE public.roles OWNER TO jodos;

--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: jodos
--

CREATE TABLE public.user_roles (
    user_id uuid NOT NULL,
    role_id uuid NOT NULL
);


ALTER TABLE public.user_roles OWNER TO jodos;

--
-- Data for Name: deductions; Type: TABLE DATA; Schema: public; Owner: jodos
--

COPY public.deductions (id, created_at, updated_at, created_by, updated_by, code, name, percentage) FROM stdin;
127ca84e-1383-4004-b195-7afe8b7a2e02	2025-05-29 17:24:47.304179	2025-05-29 17:24:47.304205	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	DTX001	EmployeeTax	30.00
138259ca-315f-447e-98b0-3ccff1d3101a	2025-05-29 17:24:47.311594	2025-05-29 17:24:47.311623	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	DPN001	Pension	6.00
68059f38-8927-4c75-ae6f-20dce8b97476	2025-05-29 17:24:47.319649	2025-05-29 17:24:47.319679	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	DMI001	MedicalInsurance	5.00
841c0d3a-4bb0-4ba7-a8cf-2d54eec9c9db	2025-05-29 17:24:47.325769	2025-05-29 17:24:47.325807	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	DOT001	Others	5.00
9fab7bd2-a0b8-4d71-a2c1-097ad0a47cc5	2025-05-29 17:24:47.333022	2025-05-29 17:24:47.333045	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	DHO001	Housing	14.00
3e1472e9-e213-46c2-a3ce-e5e86edf8c90	2025-05-29 17:24:47.339176	2025-05-29 17:24:47.339199	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	DTR001	Transport	14.00
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: jodos
--

COPY public.employees (id, created_at, updated_at, created_by, updated_by, activation_code, activation_code_expires_at, dob, email, first_name, last_name, mobile, nationalid, password, status, employee_id, profile_image_id) FROM stdin;
3bee272e-b5ab-4316-b3d4-92eaaef09a1a	2025-05-29 17:18:35.618495	2025-05-29 17:18:35.618546	\N	\N	\N	\N	\N	admin@gmail.com	admin	admin	0799999999	1199980012345678	$2a$10$sRlRbanQBBC/cZLofFB2VOlXFyYXZUTxrIBHIIAeRWAjjmSEYIDMO	ACTIVE	\N	\N
736058e8-76e5-42af-b66f-b47215ab0a69	2025-05-29 17:20:07.819891	2025-05-29 17:20:07.819968	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	\N	\N	1995-08-12	jodos20062@gmail.com	Eric	Ndayisenga	0730276984	1271647344809944	$2a$10$aepuF.BoXzCwjmotlpYNMuz.5Kl5xFDKTTSG1oyaU6JGxferxwRqy	ACTIVE	8f35b5d0-714d-495b-89c0-69b1c0547674	\N
d6827457-4a1b-4670-b3d9-2f18a7e9da0c	2025-05-29 17:23:33.296854	2025-05-29 17:23:33.296901	736058e8-76e5-42af-b66f-b47215ab0a69	736058e8-76e5-42af-b66f-b47215ab0a69	\N	\N	1990-03-12	alice1@example.com	Alice	Johnson	0729946101	1984485977530001	$2a$10$wpsridFlQGnaC5RoGHtpIOb9DB/XX.ycULkqA6bOWTF3MfZLB82TC	ACTIVE	8ff971cb-86e0-49ca-8027-b726ffb7457e	\N
4fe82d0f-d8cb-4043-866c-db5b8f50aa9f	2025-05-29 17:47:35.010273	2025-05-29 17:47:35.010311	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	\N	\N	1988-07-24	tuyishimireericc@gmail.com	Eric	TUYISHIMIRE	0729946062	1655275987700002	$2a$10$//KbIb75jEjWE1.AlZqNm.Ck5x640bhmk4mKnwvWp92.2jFy3wZvC	ACTIVE	8dfdd297-7dd7-48d1-81c5-661102618d20	\N
6a6aea2b-1c31-4f01-8ab4-f1f53aebb428	2025-05-29 17:49:23.794205	2025-05-29 17:49:23.794239	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	\N	\N	1990-03-12	alice.johnson4@example.com	Alice	Johnson	0729940099	1655975987705001	$2a$10$e.sarn01hUUhCsEuHVomi.s7aDue77zydxkfk/T2ut9q1pTCzda6i	ACTIVE	c80bdd1d-52c3-4c81-b7d1-c2c7386f234b	\N
\.


--
-- Data for Name: employments; Type: TABLE DATA; Schema: public; Owner: jodos
--

COPY public.employments (id, created_at, updated_at, created_by, updated_by, base_salary, code, department, joining_date, "position", status, employee_id) FROM stdin;
8f35b5d0-714d-495b-89c0-69b1c0547674	2025-05-29 17:20:07.759395	2025-05-29 17:20:07.841921	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	75000.00	EMP2025-001	ICT	2023-09-01	Software Engineer	ACTIVE	736058e8-76e5-42af-b66f-b47215ab0a69
8ff971cb-86e0-49ca-8027-b726ffb7457e	2025-05-29 17:23:33.247581	2025-05-29 17:23:33.31494	736058e8-76e5-42af-b66f-b47215ab0a69	736058e8-76e5-42af-b66f-b47215ab0a69	70000.00	EMP001	IT	2022-01-10	Developer	ACTIVE	d6827457-4a1b-4670-b3d9-2f18a7e9da0c
8dfdd297-7dd7-48d1-81c5-661102618d20	2025-05-29 17:47:34.967823	2025-05-29 17:47:35.029221	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	100000.00	EMP002	HR	2021-04-15	HR Manager	ACTIVE	4fe82d0f-d8cb-4043-866c-db5b8f50aa9f
c80bdd1d-52c3-4c81-b7d1-c2c7386f234b	2025-05-29 17:49:23.751274	2025-05-29 17:49:23.80049	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	80000.00	EMP001	IT	2022-01-10	Software Engineer	ACTIVE	6a6aea2b-1c31-4f01-8ab4-f1f53aebb428
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: jodos
--

COPY public.files (id, created_at, updated_at, created_by, updated_by, name, path, size, size_type, status, type) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: jodos
--

COPY public.messages (id, created_at, updated_at, created_by, updated_by, banking_date_time, message, employee_id) FROM stdin;
5d74abae-17e3-49b7-b891-ca3948b6f2d5	2025-05-29 17:27:07.978187	2025-05-29 17:27:07.978224	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	2025-05-29 17:27:07.978212	Dear Alice, your salary for DECEMBER/2024 from ERP System amounting to 57,400.00 has been credited to your account d6827457-4a1b-4670-b3d9-2f18a7e9da0c successfully.	d6827457-4a1b-4670-b3d9-2f18a7e9da0c
9d910130-67e4-4db0-b38f-96621a5df15d	2025-05-29 17:50:49.295194	2025-05-29 17:50:49.295244	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	2025-05-29 17:50:49.295224	Dear Eric, your salary for DECEMBER/2024 from ERP System amounting to 82,000.00 has been credited to your account 4fe82d0f-d8cb-4043-866c-db5b8f50aa9f successfully.	4fe82d0f-d8cb-4043-866c-db5b8f50aa9f
\.


--
-- Data for Name: payslips; Type: TABLE DATA; Schema: public; Owner: jodos
--

COPY public.payslips (id, created_at, updated_at, created_by, updated_by, employee_tax_amount, gross_salary_amount, "house-amount", medical_insurance_amount, month, net_salary, other_tax_amount, pension_amount, status, transport_amount, year, employee_id) FROM stdin;
d5b8273d-4ee9-46ef-99e6-6a996fa5b4e5	2025-05-29 17:26:06.920033	2025-05-29 17:26:59.737784	736058e8-76e5-42af-b66f-b47215ab0a69	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	21000.00	89600.00	9800.00	3500.00	12	57400.00	3500.00	4200.00	PAID	9800.00	2024	d6827457-4a1b-4670-b3d9-2f18a7e9da0c
d8ab63c7-9f61-433b-948e-1c482401c816	2025-05-29 17:49:53.463762	2025-05-29 17:50:41.674047	6a6aea2b-1c31-4f01-8ab4-f1f53aebb428	3bee272e-b5ab-4316-b3d4-92eaaef09a1a	30000.00	128000.00	14000.00	5000.00	12	82000.00	5000.00	6000.00	PAID	14000.00	2024	4fe82d0f-d8cb-4043-866c-db5b8f50aa9f
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: jodos
--

COPY public.roles (id, description, name) FROM stdin;
a7aa89bd-6566-4bfb-a1ed-9442281a22c2	MANAGER	MANAGER
f640b883-909b-422c-9c75-6c752ebe38c5	EMPLOYEE	EMPLOYEE
cd7f975d-b9e4-4c20-8ce0-d2f54a2656e4	ADMIN	ADMIN
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: jodos
--

COPY public.user_roles (user_id, role_id) FROM stdin;
3bee272e-b5ab-4316-b3d4-92eaaef09a1a	cd7f975d-b9e4-4c20-8ce0-d2f54a2656e4
736058e8-76e5-42af-b66f-b47215ab0a69	a7aa89bd-6566-4bfb-a1ed-9442281a22c2
d6827457-4a1b-4670-b3d9-2f18a7e9da0c	f640b883-909b-422c-9c75-6c752ebe38c5
4fe82d0f-d8cb-4043-866c-db5b8f50aa9f	f640b883-909b-422c-9c75-6c752ebe38c5
6a6aea2b-1c31-4f01-8ab4-f1f53aebb428	a7aa89bd-6566-4bfb-a1ed-9442281a22c2
\.


--
-- Name: deductions deductions_pkey; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.deductions
    ADD CONSTRAINT deductions_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: employments employments_pkey; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employments
    ADD CONSTRAINT employments_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: payslips payslips_pkey; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.payslips
    ADD CONSTRAINT payslips_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: employments ukcpqqfxxkijtphyy2sde67tclx; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employments
    ADD CONSTRAINT ukcpqqfxxkijtphyy2sde67tclx UNIQUE (employee_id);


--
-- Name: employees uken8ws9w8b8q839ks2qdd12xjo; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT uken8ws9w8b8q839ks2qdd12xjo UNIQUE (nationalid);


--
-- Name: files uki2xe46u1dge0ksxkhljlg2ouu; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT uki2xe46u1dge0ksxkhljlg2ouu UNIQUE (path);


--
-- Name: employees ukj9xgmd0ya5jmus09o0b8pqrpb; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT ukj9xgmd0ya5jmus09o0b8pqrpb UNIQUE (email);


--
-- Name: employees ukovvvp79dq21byf7svnuekb6iw; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT ukovvvp79dq21byf7svnuekb6iw UNIQUE (employee_id);


--
-- Name: employees ukrjxn0bj3rkung0nii7qmfhv2t; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT ukrjxn0bj3rkung0nii7qmfhv2t UNIQUE (profile_image_id);


--
-- Name: employees uksm5olvg1ctp19dcrvbr755pi5; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT uksm5olvg1ctp19dcrvbr755pi5 UNIQUE (mobile);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: messages fk1q671yj3ssisaipaue47bgvdc; Type: FK CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk1q671yj3ssisaipaue47bgvdc FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- Name: employees fk56m77ys9oov7jjm53rfdq19r9; Type: FK CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk56m77ys9oov7jjm53rfdq19r9 FOREIGN KEY (employee_id) REFERENCES public.employments(id);


--
-- Name: employees fk6nl7lf5sw4txk4790b5881rcl; Type: FK CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk6nl7lf5sw4txk4790b5881rcl FOREIGN KEY (profile_image_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: user_roles fk9tdu6x1oj5wsxfpvunqv5gccy; Type: FK CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk9tdu6x1oj5wsxfpvunqv5gccy FOREIGN KEY (user_id) REFERENCES public.employees(id);


--
-- Name: employments fkd0t2nvcnyco5o5kj188l4fsql; Type: FK CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.employments
    ADD CONSTRAINT fkd0t2nvcnyco5o5kj188l4fsql FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- Name: user_roles fkh8ciramu9cc9q3qcqiv4ue8a6; Type: FK CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: payslips fki2u90djkfkqooebb9b26gxqmi; Type: FK CONSTRAINT; Schema: public; Owner: jodos
--

ALTER TABLE ONLY public.payslips
    ADD CONSTRAINT fki2u90djkfkqooebb9b26gxqmi FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- PostgreSQL database dump complete
--

