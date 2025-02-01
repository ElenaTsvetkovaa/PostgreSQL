SELECT
    p.id,
    p.title,
    pdi.duration,
    ROUND(pdi.budget, 1) AS budget,
    TO_CHAR(pdi.release_date, 'MM-YY') AS release_date
FROM
    productions AS p
JOIN
    productions_info AS pdi
ON pdi.id = p.production_info_id
WHERE
    pdi.release_date BETWEEN '2023-01-01' AND '2024-12-31'
        AND
    pdi.budget > 1500000.00
ORDER BY
    budget ASC,
    pdi.duration DESC,
    p.id ASC
LIMIT 3;