SELECT 'Primary Completion' AS education_type,
	CASE 
        WHEN ffh.gender_inequality_index <= 0.2 THEN 'High equality' 
        WHEN ffh.gender_inequality_index <= 0.4 THEN 'Mid equality'
        ELSE 'Low equality'
    END AS equality_group,
	AVG(ffh.female_life_expectancy) AS avg_female_life_expectancy,
	AVG(ffh.female_labor_participation ) AS avg_female_labor_participation,
	AVG(ffh.education_rate ) AS avg_education_rate
from fact_female_health ffh
join dim_education de 
	on de.education_id = ffh.education_id 
where ffh.gender_inequality_index is not null AND ffh.gender_inequality_index <>0 and ffh.education_id=1
GROUP BY
	CASE 
        WHEN ffh.gender_inequality_index <= 0.2 THEN 'High equality'
        WHEN ffh.gender_inequality_index <= 0.4 THEN 'Mid equality'
        ELSE 'Low equality'
    END
union ALL
SELECT 'Secondary Enrollment' AS education_type,
	CASE 
        WHEN ffh.gender_inequality_index <= 0.2 THEN 'High equality'
        WHEN ffh.gender_inequality_index <= 0.4 THEN 'Mid equality'
        ELSE 'Low equality'
    END AS equality_group,
	AVG(ffh.female_life_expectancy) AS avg_female_life_expectancy,
	AVG(ffh.female_labor_participation ) AS avg_female_labor_participation,
	AVG(ffh.education_rate ) AS avg_education_rate
from fact_female_health ffh
join dim_education de 
	on de.education_id = ffh.education_id 
where ffh.gender_inequality_index is not null and ffh.gender_inequality_index <>0 and ffh.education_id=2
group by 
	CASE 
        WHEN ffh.gender_inequality_index <= 0.2 THEN 'High equality'
        WHEN ffh.gender_inequality_index <= 0.4 THEN 'Mid equality'
        ELSE 'Low equality'
    end
order by 
education_type,
avg_female_life_expectancy DESC;