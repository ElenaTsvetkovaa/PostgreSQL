SELECT
    p.id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    age,
    position,
    salary,
    pace,
    shooting
FROM
    players AS p
JOIN
    skills_data AS sd
ON p.skills_data_id = sd.id
WHERE
    pace + shooting > 130
        AND
    p.team_id IS NULL
        AND
    p.position = 'A';

