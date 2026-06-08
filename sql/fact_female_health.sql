DROP TABLE IF EXISTS fact_female_health;

CREATE TABLE fact_female_health AS

-- PRIMARY EDUCATION
SELECT
    dc.country_id,
    dc.country_name,
    dc.region,
    dt.year_id,
    1 AS education_id,
    dl.country_id AS legal_country_id,
    dl.year AS legal_year,

    ep.school_completion_primary_female_rate AS education_rate,

    gii.gender_inequality_index,
    labor.female_labor_force_participation_rate AS female_labor_participation,
    life.female_life_expectancy,
    gdp.gdp_growth

FROM stg_education_primary ep

LEFT JOIN dim_country dc
    ON ep.country_code = dc.country_id

LEFT JOIN dim_time dt
    ON ep.year = dt.year_id

LEFT JOIN dim_legal dl
    ON ep.country_code = dl.country_id
   AND ep.year = dl.year

LEFT JOIN stg_gender_inequality gii
    ON ep.country_code = gii.country_code
   AND ep.year = gii.year

LEFT JOIN stg_labor labor
    ON ep.country_code = labor.country_code
   AND ep.year = labor.year

LEFT JOIN stg_life_expectancy life
    ON ep.country_code = life.country_code
   AND ep.year = life.year

LEFT JOIN stg_gdp_growth gdp
    ON ep.country_code = gdp.country_code
   AND ep.year = gdp.year


UNION ALL

-- SECONDARY EDUCATION
SELECT
    dc.country_id,
    dc.country_name,
    dc.region,
    dt.year_id,
    2 AS education_id,
    dl.country_id AS legal_country_id,
    dl.year AS legal_year,

    es.school_enrollment_secondary_female_rate AS education_rate,

    gii.gender_inequality_index,
    labor.female_labor_force_participation_rate AS female_labor_participation,
    life.female_life_expectancy,
    gdp.gdp_growth

FROM stg_education_secondary es

LEFT JOIN dim_country dc
    ON es.country_code = dc.country_id

LEFT JOIN dim_time dt
    ON es.year = dt.year_id

LEFT JOIN dim_legal dl
    ON es.country_code = dl.country_id
   AND es.year = dl.year

LEFT JOIN stg_gender_inequality gii
    ON es.country_code = gii.country_code
   AND es.year = gii.year

LEFT JOIN stg_labor labor
    ON es.country_code = labor.country_code
   AND es.year = labor.year

LEFT JOIN stg_life_expectancy life
    ON es.country_code = life.country_code
   AND es.year = life.year

LEFT JOIN stg_gdp_growth gdp
    ON es.country_code = gdp.country_code
   AND es.year = gdp.year;

   
SELECT * FROM fact_female_health LIMIT 8000;