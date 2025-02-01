SELECT
    p.title,
    CASE
        WHEN pdi.rating > 8 THEN 'excellent'
        WHEN pdi.rating <= 3.50 THEN 'poor'
        ELSE 'good'
    END AS rating,
    CASE
        WHEN pdi.has_subtitles IS TRUE THEN 'Bulgarian'
        ELSE 'N/A'
    END AS subtitles,
    COUNT(pa.actor_id) AS actors_count
FROM
    productions_info AS pdi
JOIN
    productions AS p
ON pdi.id = p.production_info_id
JOIN
    productions_actors as pa
ON p.id = pa.production_id
GROUP BY
    p.title, pdi.rating, pdi.has_subtitles
ORDER BY
    rating ASC,
    actors_count DESC,
    title ASC