INSERT INTO
    actors (first_name, last_name, birthdate, height, awards, country_id)
SELECT
    reverse(first_name),
    reverse(last_name),
    birthdate - INTERVAL '2 days',
    CASE
        WHEN height IS NULL THEN 10
        ELSE
            height + 10
    END,
    country_id,
    (SELECT c.id FROM countries AS c WHERE c.name = 'Armenia')
FROM
    actors
WHERE
    id BETWEEN 10 AND 20;