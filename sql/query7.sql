SELECT 
    CASE 
        WHEN ffh.gender_inequality_index <= 0.2 THEN 'Low inequality'
        WHEN ffh.gender_inequality_index <= 0.4 THEN 'Mid inequality'
        ELSE 'High inequality'
    END AS inequality_bucket,
    AVG(ffh.female_life_expectancy) AS avg_female_life_expectancy
FROM fact_female_health ffh
WHERE ffh.gender_inequality_index IS NOT NULL
  AND ffh.gender_inequality_index <> 0
GROUP BY 
    CASE 
        WHEN ffh.gender_inequality_index <= 0.2 THEN 'Low inequality'
        WHEN ffh.gender_inequality_index <= 0.4 THEN 'Mid inequality'
        ELSE 'High inequality'
    END
ORDER BY avg_female_life_expectancy DESC;