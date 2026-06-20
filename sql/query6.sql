SELECT
    equality_group,
    education_type,
    AVG(life_exp) AS avg_female_life_expectancy,
    AVG(labor_participation) AS avg_female_labor_participation,
    AVG(education_rate) AS avg_education_rate
FROM (
    SELECT
        ffh.country_id,
        ffh.year_id,
        ffh.education_id,
        CASE
            WHEN ffh.gender_inequality_index <= 0.2 THEN 'High equality'
            WHEN ffh.gender_inequality_index <= 0.4 THEN 'Mid equality'
            ELSE 'Low equality'
        END AS equality_group,
        CASE
            WHEN ffh.education_id = 1 THEN 'Primary Completion'
            ELSE 'Secondary Enrollment'
        END AS education_type,
        AVG(ffh.female_life_expectancy) AS life_exp,
        AVG(ffh.female_labor_participation) AS labor_participation,
        AVG(ffh.education_rate) AS education_rate
    FROM fact_female_health ffh
    WHERE ffh.gender_inequality_index IS NOT NULL
    GROUP BY
        ffh.country_id,
        ffh.year_id,
        ffh.education_id,
        ffh.gender_inequality_index,
        ffh.education_rate,
        ffh.female_life_expectancy,
        ffh.female_labor_participation
) t
GROUP BY equality_group, education_type
ORDER BY equality_group, education_type;