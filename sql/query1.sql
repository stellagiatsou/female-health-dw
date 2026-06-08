SELECT 
	dt.year_id, 
	AVG(female_life_expectancy) AS "Female life expectancy",
	AVG(gender_inequality_index) as "Gender inequality index"
from fact_female_health ffh
join dim_time dt 
	on dt.year_id = ffh.year_id 
group by dt.year_id
order by dt.year_id ASC;