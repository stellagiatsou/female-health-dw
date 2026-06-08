DROP TABLE IF EXISTS dim_education;

CREATE TABLE dim_education (
    education_id INTEGER PRIMARY KEY,
    education_level VARCHAR(50)
);

INSERT INTO dim_education VALUES
(1,'Primary Completion'),
(2,'Secondary Enrollment');

SELECT * FROM dim_education LIMIT 10;