SELECT
    country_id,
    MAX(legal_score) - MIN(legal_score) AS rights_improvement
FROM (
    SELECT DISTINCT
        f.country_id,
        f.year_id,
        (
            (CASE WHEN l.can_choose_residence THEN 1 ELSE 0 END) +
            (CASE WHEN l.can_travel_domestic THEN 1 ELSE 0 END) +
            (CASE WHEN l.can_apply_passport THEN 1 ELSE 0 END) +
            (CASE WHEN l.can_travel_abroad THEN 1 ELSE 0 END) +
            (CASE WHEN l.get_job THEN 1 ELSE 0 END) +
            (CASE WHEN l.no_gender_discrimination_employment THEN 1 ELSE 0 END) +
            (CASE WHEN l.sexual_harassment_legislation THEN 1 ELSE 0 END) +
            (CASE WHEN l.sexual_harassment_penalties THEN 1 ELSE 0 END) +
            (CASE WHEN l.no_gender_discrimination_credit THEN 1 ELSE 0 END) +
            (CASE WHEN l.can_sign_contract THEN 1 ELSE 0 END) +
            (CASE WHEN l.can_register_business THEN 1 ELSE 0 END) +
            (CASE WHEN l.can_open_bank_account THEN 1 ELSE 0 END)
        ) AS legal_score
    FROM fact_female_health f
    JOIN dim_legal l
        ON f.legal_id = l.legal_id
) t
GROUP BY country_id
ORDER BY rights_improvement DESC;