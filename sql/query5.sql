SELECT 
 'Primary Completion' AS education_type,
	CASE 
        WHEN ffh.education_rate >= 80 THEN 'High primary completion rate'
        WHEN ffh.education_rate >= 60 THEN 'Mid primary completion rate'
        ELSE 'Low primary completion rate'
    END AS education_group,
	AVG(ffh.female_life_expectancy) AS avg_female_life_expectancy
from fact_female_health ffh
join dim_education de 
	on de.education_id = ffh.education_id 
where ffh.education_rate is not null and ffh.education_rate <>0 and ffh.education_id=1 --Primary completion
group by 
	CASE 
        WHEN ffh.education_rate >= 80 THEN 'High primary completion rate'
        WHEN ffh.education_rate >= 60 THEN 'Mid primary completion rate'
        ELSE 'Low primary completion rate'
    END
union ALL
SELECT 
'Secondary Enrollment' AS education_type,
	CASE 
        WHEN ffh.education_rate >= 80 THEN 'High secondary enrollment rate'
        WHEN ffh.education_rate >= 60 THEN 'Mid secondary enrollment rate'
        ELSE 'Low secondary enrollment rate'
    END AS education_group,
	AVG(ffh.female_life_expectancy) AS avg_female_life_expectancy
from fact_female_health ffh
join dim_education de 
	on de.education_id = ffh.education_id 
where ffh.education_rate is not null and ffh.education_rate <>0 and ffh.education_id=2 --Secondary enrollment
group by 
	CASE 
        WHEN ffh.education_rate >= 80 THEN 'High secondary enrollment rate'
        WHEN ffh.education_rate >= 60 THEN 'Mid secondary enrollment rate'
        ELSE 'Low secondary enrollment rate'
    end
order by 
education_type,
avg_female_life_expectancy DESC;