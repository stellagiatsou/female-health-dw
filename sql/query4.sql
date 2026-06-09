SELECT 
	dc.income_group, 
	AVG(ffh.female_life_expectancy) AS "Average female life expectancy",
	AVG(ffh.gender_inequality_index) as "Average gender inequality index"
from fact_female_health ffh
join dim_country dc 
	on dc.country_id = ffh.country_id 
group by dc.income_group;
