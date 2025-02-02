SELECT
    CONCAT(ow.name, ' - ', a.name) AS "owners - animals",
    ow.phone_number,
    ac.cage_id
FROM
    owners AS ow
JOIN
    animals AS a
ON ow.id = a.owner_id
JOIN
    animals_cages AS ac
ON a.id = ac.animal_id
WHERE
    a.animal_type_id = (SELECT id FROM animal_types WHERE animal_type = 'Mammals')
ORDER BY
    ow.name ASC,
    a.name DESC;