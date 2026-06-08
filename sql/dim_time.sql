DROP TABLE IF EXISTS dim_time;

CREATE TABLE dim_time (
    year_id INTEGER PRIMARY KEY,
    year INTEGER
);

INSERT INTO dim_time (year_id, year)
SELECT
    y,
    y
FROM generate_series(1990, 2023) AS y;

SELECT * FROM dim_time;