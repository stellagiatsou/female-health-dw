SELECT
    country_id,
    AVG(gii) AS avg_gender_inequality_index
FROM (
    SELECT
        country_id,
        year_id,
        AVG(gender_inequality_index) AS gii
    FROM fact_female_health
    WHERE gender_inequality_index IS NOT NULL
    GROUP BY country_id, year_id
) t
GROUP BY country_id
ORDER BY avg_gender_inequality_index ASC
LIMIT 30;