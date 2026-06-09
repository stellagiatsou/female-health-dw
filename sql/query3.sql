SELECT
	ffh.country_name,
	ffh.country_id,
	AVG(ffh.female_life_expectancy ) as avg_female_life_expectancy
from fact_female_health ffh
group by ffh.country_name, ffh.country_id 
order by avg_female_life_expectancy desc
limit 30;