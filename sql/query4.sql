SELECT
    income_group,
    year_id,
    AVG(life_exp) AS avg_female_life_expectancy
FROM (
    SELECT
        ffh.country_id,
        dc.income_group,
        ffh.year_id,
        AVG(ffh.female_life_expectancy) AS life_exp
    FROM fact_female_health ffh
    JOIN dim_country dc
        ON dc.country_id = ffh.country_id
    WHERE ffh.female_life_expectancy IS NOT NULL
    GROUP BY
        ffh.country_id,
        dc.income_group,
        ffh.year_id
) t
where income_group is not null
GROUP BY
    income_group,
    year_id
ORDER BY
    year_id,
    income_group;