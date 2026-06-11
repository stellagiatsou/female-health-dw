SELECT
    c.income_group,
    f.year,
    AVG(f.life_expectancy) AS avg_life_expectancy
FROM fact_health f
JOIN dim_country c
    ON f.country_id = c.country_id
GROUP BY
    c.income_group,
    f.year
ORDER BY
    f.year, c.income_group;