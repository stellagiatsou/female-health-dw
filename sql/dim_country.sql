DROP TABLE IF EXISTS dim_country;

CREATE TABLE dim_country (
    country_id VARCHAR(10) PRIMARY KEY,
    country_name VARCHAR(100),
    region VARCHAR(100),
    income_group VARCHAR(50)
);

INSERT INTO dim_country (country_id, country_name, region, income_group)
SELECT
    country_code,
    MAX(country),
    MAX(region),
    MAX(income_group)
FROM stg_wbl_index
GROUP BY country_code;

SELECT * FROM dim_country LIMIT 200;

--Έπειτα από ετερογένεια 
INSERT INTO dim_country (country_id, country_name, region, income_group) VALUES
('ABW', 'Aruba', NULL, NULL),
('AND', 'Andorra', NULL, NULL),
('ASM', 'American Samoa', NULL, NULL),
('COD', 'Democratic Republic of the Congo', NULL, NULL),
('CUB', 'Cuba', NULL, NULL),
('CUW', 'Curaçao', NULL, NULL),
('CYM', 'Cayman Islands', NULL, NULL),
('LIE', 'Liechtenstein', NULL, NULL),
('MAC', 'Macao', NULL, NULL),
('NCL', 'New Caledonia', NULL, NULL),
('NRU', 'Nauru', NULL, NULL),
('PSE', 'Palestine', NULL, NULL),
('PYF', 'French Polynesia', NULL, NULL),
('TCA', 'Turks and Caicos Islands', NULL, NULL),
('TKM', 'Turkmenistan', NULL, NULL),
('TLS', 'Timor-Leste', NULL, NULL),
('TUV', 'Tuvalu', NULL, NULL);