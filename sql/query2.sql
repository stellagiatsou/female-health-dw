SELECT
	ffh.country_name,
	ffh.country_id,
	AVG(ffh.gender_inequality_index) as avg_gender_inequality_index
from fact_female_health ffh
where ffh.gender_inequality_index is not null
group by ffh.country_name, ffh.country_id 
order by avg_gender_inequality_index asc
limit 30;