SELECT
    income_group,
    AVG(life_exp) AS avg_female_life_expectancy,
    AVG(gii) AS avg_gender_inequality_index
FROM (
    SELECT
        ffh.country_id,
        dc.income_group,
        ffh.year_id,
        AVG(ffh.female_life_expectancy) AS life_exp,
        AVG(ffh.gender_inequality_index) AS gii
    FROM fact_female_health ffh
    JOIN dim_country dc
        ON dc.country_id = ffh.country_id
    GROUP BY
        ffh.country_id,
        dc.income_group,
        ffh.year_id
) t
WHERE income_group IS NOT NULL
GROUP BY income_group
ORDER BY income_group;