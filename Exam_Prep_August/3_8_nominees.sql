SELECT
    c.name AS country_name,
    COUNT(p.id) AS productions_count,
    CASE
        WHEN AVG(pdi.budget) IS NULL THEN 0
        ELSE AVG(pdi.budget)
    END AS avg_budget
FROM
    countries AS c
JOIN
    productions AS p
ON c.id = p.country_id
RIGHT JOIN
    productions_info AS pdi
ON p.production_info_id = pdi.id
GROUP BY
    c.name
ORDER BY
    productions_count DESC ,
    country_name;