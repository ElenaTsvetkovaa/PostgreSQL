SELECT
    a.name AS animal,
    EXTRACT(YEAR FROM birthdate) as birth_year,
    at.animal_type
FROM
    animals AS a
JOIN
    animal_types AS at
ON a.animal_type_id = at.id
WHERE
    at.animal_type <> 'Birds'
        AND
    (a.owner_id IS NULL
         AND
    EXTRACT(YEAR FROM AGE('2022-01-01', birthdate)) < 5)
ORDER BY
    animal;
