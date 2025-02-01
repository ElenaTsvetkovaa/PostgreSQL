DELETE FROM
           countries AS c
WHERE
    c.id NOT IN
        (SELECT DISTINCT a.country_id FROM actors as a
         UNION
         SELECT DISTINCT p.country_id FROM productions as p
        )
RETURNING id, name;