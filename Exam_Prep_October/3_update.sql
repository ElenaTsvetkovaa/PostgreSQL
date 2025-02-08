UPDATE
    coaches AS c
SET
    salary = salary * coach_level
WHERE
    LEFT(c.first_name, 1) = 'C'
        AND
    (SELECT COUNT(player_id)
     FROM players_coaches as pc
     WHERE pc.coach_id = c.id) >= 1;