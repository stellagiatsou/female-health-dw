DROP TABLE IF EXISTS dim_legal;

CREATE TABLE dim_legal (
    country_id VARCHAR(10),
    year INTEGER,

    can_choose_residence BOOLEAN,
    can_travel_domestic BOOLEAN,
    can_apply_passport BOOLEAN,
    can_travel_abroad BOOLEAN,

    get_job BOOLEAN,

    no_gender_discrimination_employment BOOLEAN,

    sexual_harassment_legislation BOOLEAN,
    sexual_harassment_penalties BOOLEAN,

    no_gender_discrimination_credit BOOLEAN,

    can_sign_contract BOOLEAN,
    can_register_business BOOLEAN,
    can_open_bank_account BOOLEAN,

    PRIMARY KEY (country_id, year)
);

--Create Legal_id primary key

--add column
ALTER TABLE dim_legal
ADD COLUMN legal_id INTEGER;

-- create sequence
CREATE SEQUENCE dim_legal_seq;

-- update values
UPDATE dim_legal
SET legal_id = nextval('dim_legal_seq');

--drop primay key (country_id, year_id)
ALTER TABLE dim_legal DROP CONSTRAINT dim_legal_pkey;

--set default
ALTER TABLE dim_legal
ALTER COLUMN legal_id SET DEFAULT nextval('dim_legal_seq');

--set primary key
ALTER TABLE dim_legal -- χρησιμοποιείται για την τροποποίηση της δομής ενός ήδη υπάρχοντος πίνακα, χωρίς να χρειάζεται να τον διαγράψετε και να τον ξαναδημιουργήσετε.
ADD CONSTRAINT pk_dim_legal PRIMARY KEY (legal_id);

--check primary key
SELECT conname, pg_get_constraintdef(c.oid)
FROM pg_constraint c
JOIN pg_class t ON c.conrelid = t.oid
WHERE t.relname = 'dim_legal';

--Insert values
INSERT INTO dim_legal
SELECT
    country_code,
    year,

    (can_choose_residence = 1) AS can_choose_residence,
    (can_travel_domestic = 1) AS can_travel_domestic,
    (can_apply_passport = 1) AS can_apply_passport,
    (can_travel_abroad = 1) AS can_travel_abroad,

    (get_job = 1) AS get_job,

    (no_gender_discrimination_employment = 1) AS no_gender_discrimination_employment,

    (sexual_harassment_legislation = 1) AS sexual_harassment_legislation,
    (sexual_harassment_penalties = 1) AS sexual_harassment_penalties,

    (no_gender_discrimination_credit = 1) AS no_gender_discrimination_credit,

    (can_sign_contract = 1) AS can_sign_contract,
    (can_register_business = 1) AS can_register_business,
    (can_open_bank_account = 1) AS can_open_bank_account
FROM stg_wbl_index;

SELECT * FROM dim_legal LIMIT 100;