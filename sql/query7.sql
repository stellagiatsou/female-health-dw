SELECT
    education_id,
    CORR(female_life_expectancy, gender_inequality_index) AS corr_value
FROM fact_female_health
GROUP BY education_id;