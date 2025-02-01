SELECT
    id,
    name,
    continent,
    currency
FROM
    countries
WHERE
    continent = 'South America'
            AND
    (SUBSTR(currency, 1, 1) = 'P'
        OR
    SUBSTR(currency, 1, 1) = 'U')
ORDER BY
    currency DESC,
    id ASC;