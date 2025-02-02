DELETE FROM distributors
WHERE
     id IN (SELECT
                id
            FROM
                distributors
            WHERE
                LEFT(name, 1) = 'L');