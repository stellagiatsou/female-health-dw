/*
SELECT 
	dt.year_id, 
	AVG(female_life_expectancy) AS "Average female life expectancy",
	AVG(gender_inequality_index) as "Average gender inequality index"
from fact_female_health ffh
join dim_time dt 
	on dt.year_id = ffh.year_id 
group by dt.year_id
order by dt.year_id ASC;
*/

SELECT
    year_id,
    AVG(life_exp),
    AVG(gii)
FROM (
    SELECT
        year_id,
        country_id,
        AVG(female_life_expectancy) AS life_exp,
        AVG(gender_inequality_index) AS gii
    FROM fact_female_health
    GROUP BY year_id, country_id
) t
GROUP BY year_id
ORDER BY t.year_id;