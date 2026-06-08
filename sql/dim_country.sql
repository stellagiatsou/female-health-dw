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