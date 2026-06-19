--DROP TABLE IF EXISTS fact_female_health_;

CREATE TABLE fact_female_health (
    fact_id SERIAL PRIMARY KEY,

    country_id VARCHAR(10) NOT NULL,
    year_id INT NOT NULL,
    education_id INT NOT NULL,
    legal_id INT,

    education_rate NUMERIC,
    gender_inequality_index NUMERIC,
    female_labor_participation NUMERIC,
    female_life_expectancy NUMERIC,
    gdp_growth NUMERIC,

    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (year_id) REFERENCES dim_time(year_id),
    FOREIGN KEY (education_id) REFERENCES dim_education(education_id),
    FOREIGN KEY (legal_id) REFERENCES dim_legal(legal_id)
);


INSERT INTO fact_female_health (
    country_id,
    year_id,
    education_id,
    legal_id,
    education_rate,
    gender_inequality_index,
    female_labor_participation,
    female_life_expectancy,
    gdp_growth
)
-- PRIMARY EDUCATION
SELECT
    dc.country_id,
    dt.year_id,
    1 AS education_id,
    dl.legal_id,
    ep.school_completion_primary_female_rate AS education_rate,
    gii.gender_inequality_index,
    labor.female_labor_force_participation_rate,
    life.female_life_expectancy,
    gdp.gdp_growth
FROM stg_education_primary ep
LEFT JOIN country_mapping cm
    ON ep.country_code = cm.source_code
LEFT JOIN dim_country dc
    ON cm.iso3_code = dc.country_id
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
WHERE dc.country_code IN (
    SELECT country_id FROM dim_country
)
UNION ALL
-- SECONDARY EDUCATION
SELECT
    dc.country_id,
    dt.year_id,
    2 AS education_id,
    dl.legal_id,
    es.school_enrollment_secondary_female_rate AS education_rate,
    gii.gender_inequality_index,
    labor.female_labor_force_participation_rate,
    life.female_life_expectancy,
    gdp.gdp_growth
FROM stg_education_secondary es
LEFT JOIN country_mapping cm
    ON es.country_code = cm.source_code
LEFT JOIN dim_country dc
    ON cm.iso3_code = dc.country_id
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
   AND es.year = gdp.year

INSERT INTO fact_female_health_ (
    country_id,
    year_id,
    education_id,
    legal_id,
    education_rate,
    gender_inequality_index,
    female_labor_participation,
    female_life_expectancy,
    gdp_growth
)
-- PRIMARY EDUCATION
SELECT
    dc.country_id,
    dt.year_id,
    1 AS education_id,
    dl.legal_id,
    ep.school_completion_primary_female_rate AS education_rate,
    gii.gender_inequality_index,
    labor.female_labor_force_participation_rate,
    life.female_life_expectancy,
    gdp.gdp_growth
FROM stg_education_primary ep
LEFT JOIN country_mapping cm
    ON ep.country_code = cm.source_code
LEFT JOIN dim_country dc
    ON cm.iso3_code = dc.country_id
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
WHERE dc.country_id IS NOT NULL
UNION ALL
-- SECONDARY EDUCATION
SELECT
    dc.country_id,
    dt.year_id,
    2 AS education_id,
    dl.legal_id,
    es.school_enrollment_secondary_female_rate AS education_rate,
    gii.gender_inequality_index,
    labor.female_labor_force_participation_rate,
    life.female_life_expectancy,
    gdp.gdp_growth
FROM stg_education_secondary es
LEFT JOIN country_mapping cm
    ON es.country_code = cm.source_code
LEFT JOIN dim_country dc
    ON cm.iso3_code = dc.country_id
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
   AND es.year = gdp.year
WHERE dc.country_id IS NOT NULL;